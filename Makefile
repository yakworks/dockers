# check for build/shipkit and clone if not there, this should come first
SHIPKIT_DIR = build/shipkit
$(shell [ ! -e $(SHIPKIT_DIR) ] && git clone -b v2.0.11 https://github.com/yakworks/shipkit.git $(SHIPKIT_DIR) >/dev/null 2>&1)
# Shipkit.make first, which does all the lifting to create makefile.env for the BUILD_VARS
include $(SHIPKIT_DIR)/Shipkit.make
include $(SHIPKIT_DIR)/makefiles/circle.make
include $(SHIPKIT_DIR)/makefiles/vault.make

INCLUDE_DIRS = builder bullseye
DOCKERFILES = $(shell find $(INCLUDE_DIRS) -type f -name 'Dockerfile')
NAMES = $(subst /Dockerfile,,$(DOCKERFILES))
REGISTRY ?= yakworks
REGISTRY_BUILD ?= build/$(REGISTRY)
IMAGES = $(addprefix $(REGISTRY_BUILD)/,$(NAMES))
IMAGES_BUILD = $(addsuffix .build,$(IMAGES))
IMAGES_PUSH = $(addsuffix .push,$(IMAGES))
DEPENDS = .depends.mk
PLATFORMS ?= linux/arm64,linux/amd64

# bullseye_deps = $(shell awk '/^$(REGISTRY)\/bullseye/{ sub(/:$$/, "", $$1); print $$1 }' .depends.mk )
# bullseye_deps += bullseye\:jre11 bullseye\:postgres14-jdk11

print-%:
	@echo '$*=$($*)'

clean:
	rm -f $(DEPENDS)
	rm -rf build

pull-base:
	docker pull debian:bullseye-slim
	docker pull alpine:3.16

grepdeps: $(DOCKERFILES)
	$(logr) $@
	grep '^FROM \$$REGISTRY/' $(DOCKERFILES)

.PHONY: $(DEPENDS)
# depends fires on every make call to build the .depends.mk, so needs to happen first before the others
$(DEPENDS): $(DOCKERFILES)
	grep '^FROM \$$REGISTRY/' $(DOCKERFILES) | \
		awk -F '/Dockerfile:FROM \\$$REGISTRY/' '{ print $$1 " " $$2 }' | \
		sed 's@[:]@/@g' | \
		awk '{ print "$(REGISTRY_BUILD)/" $$1 ".build: " "$(REGISTRY_BUILD)/" $$2 ".build"}' > $@

sinclude $(DEPENDS)

export DCMD ?= build
ifeq (pull,$(filter pull,$(MAKECMDGOALS)))
 DCMD = pull
else ifeq (run,$(filter run,$(MAKECMDGOALS)))
 DCMD = run
else ifeq (run-sh,$(filter run-sh,$(MAKECMDGOALS)))
 DCMD = run-sh
else ifeq (push,$(filter push,$(MAKECMDGOALS)))
 DCMD = push
endif

dummy_targets = run run-sh check pull push buildx checkrebuild
.PHONY: $(dummy_targets)

define SET_TAG_NAME =
 TAG_NAME=$$(echo  "$*" | sed -r 's|(.*)/|\1:|')
 TAG_NAME="$(REGISTRY)/$$TAG_NAME"
 $(logr) "TAG_NAME: $$TAG_NAME"
endef

# shortcut names so can call `make bullseye/base` for example
$(NAMES): %: $(REGISTRY_BUILD)/%.build
	$(SET_TAG_NAME)
	if [[ $(DCMD) = push ]]; then
		$(MAKE) $(REGISTRY_BUILD)/$*.push
	elif [[ $(DCMD) = run ]]; then
		docker run --rm -it $$TAG_NAME
	fi
# sets up the yakworks/image/tag.build targets
$(IMAGES_BUILD): $(REGISTRY_BUILD)/%.build: %/Dockerfile
	$(SET_TAG_NAME)
	docker build --build-arg REGISTRY=$(REGISTRY) -t $$TAG_NAME $*
	# install used instead of touch as it creates the parent dirs see https://stackoverflow.com/a/24675139/6500859
	install -Dv /dev/null $@
	$(logr.done) "$*"

# sets up the yakworks/image:tag.push targets
$(IMAGES_PUSH): $(REGISTRY_BUILD)/%.push:
	$(SET_TAG_NAME)
	# if the DOCKER_DEFAULT_PLATFORM is set then let it use that and dont use buildx
	if [[ $${DOCKER_DEFAULT_PLATFORM:-} ]]; then
		# assumes its built already
		docker push "$$TAG_NAME"
	else
		docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg REGISTRY=$(REGISTRY) \
				 --push --platform $(PLATFORMS) -t $$TAG_NAME $*
	fi

	install -Dv /dev/null $@
	$(logr.done) "$*"

## build all the debian bullseye targets
bullseye.build-all:
	for t in base core helm jdk11 jre11 postgres14-jdk11 docker docker-jdk11; do
		$(MAKE) bullseye/$$t
	done

## builds and pushes all the debian bullseye targets
bullseye.push-all:
	for t in base core helm jdk11 jre11 postgres14-jdk11 docker docker-jdk11 dev; do
		$(MAKE) bullseye/$$t push
	done

## the builder images are arm & amd for base and core, but java images only amd platform
builder.build-all:
	# core will build base as well
	$(MAKE) builder/core $(DMCD)
	for t in jdk11 jre11; do
		DOCKER_DEFAULT_PLATFORM=linux/amd64 $(MAKE) builder/$$t $(DMCD)
	done

## no arm on alpine java images. Set DOCKER_DEFAULT_PLATFORM
builder.java11:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 $(MAKE) builder/java11 $(DMCD)


## playwright is special
builder.playwright:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 $(MAKE) builder/playwright $(DMCD)

## repo-job
builder.repo-job:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 $(MAKE) builder/repo-job $(DMCD)
