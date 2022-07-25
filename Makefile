# check for build/shipkit and clone if not there, this should come first
SHIPKIT_DIR = build/shipkit
$(shell [ ! -e $(SHIPKIT_DIR) ] && git clone -b v2.0.11 https://github.com/yakworks/shipkit.git $(SHIPKIT_DIR) >/dev/null 2>&1)
# Shipkit.make first, which does all the lifting to create makefile.env for the BUILD_VARS
include $(SHIPKIT_DIR)/Shipkit.make
include $(SHIPKIT_DIR)/makefiles/circle.make
include $(SHIPKIT_DIR)/makefiles/vault.make

INCLUDE_DIRS = builder bullseye
DOCKERFILES = $(shell find $(INCLUDE_DIRS) -type f -name 'Dockerfile')
NAMES = $(subst /,\:,$(subst /Dockerfile,,$(DOCKERFILES)))
REGISTRY ?= yakworks
REGISTRY_BUILD ?= build/$(REGISTRY)
IMAGES = $(addprefix $(subst :,\:,$(REGISTRY_BUILD))/,$(NAMES))
DEPENDS = .depends.mk
export PLATFORMS = linux/arm64,linux/amd64

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
		sed 's@[:/]@\\:@g' | awk '{ print "$(subst :,\\:,$(REGISTRY_BUILD))/" $$1 ": " "$(subst :,\\:,$(REGISTRY_BUILD))/" $$2 }' > $@

sinclude $(DEPENDS)

export DCMD ?= buildx
ifeq (pull,$(filter pull,$(MAKECMDGOALS)))
 DCMD = pull
else ifeq (run,$(filter run,$(MAKECMDGOALS)))
 DCMD = run
else ifeq (run-sh,$(filter run-sh,$(MAKECMDGOALS)))
 DCMD = run-sh
else ifeq (pull,$(filter pull,$(MAKECMDGOALS)))
 DCMD = pull
endif

dummy_targets = run run-sh check pull push buildx checkrebuild
.PHONY: $(dummy_targets)

# name short cut so
$(NAMES): %: $(REGISTRY_BUILD)/%
	echo "running $@"

$(IMAGES): $(REGISTRY_BUILD)/%:
	# replace colon with a / to get to the dir
	docker_dir=$(subst :,/,$*)
	# if [[ $(DCMD) = pull ]]
 ifeq (pull,$(filter pull,$(MAKECMDGOALS)))
	docker pull $*
 endif
 ifeq (buildx,$(filter buildx,$(MAKECMDGOALS)))
	$(logr) "building $* in $$docker_dir"
	docker build --build-arg REGISTRY=$(REGISTRY) -t $* $$docker_dir
	# docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg REGISTRY=$(REGISTRY) --platform $(PLATFORMS) -t $* $$docker_dir
 endif
 ifeq (push,$(filter push,$(MAKECMDGOALS)))
	$(logr) "docker push $@"
	docker buildx build --push --platform $(PLATFORMS) -t $@ "$$docker_dir"
 endif
 ifeq (checkrebuild,$(filter checkrebuild,$(MAKECMDGOALS)))
	which duuh >/dev/null || (>&2 echo "checkrebuild require duuh command to be installed in PATH" && exit 1)
	duuh $@ || (docker build --build-arg REGISTRY=$(REGISTRY) --no-cache -t $@ $(subst :,/,$(subst $(REGISTRY)/,,$@)) && duuh $@)
 endif

## build all the debian bullseye targets
bullseye.all: $(bullseye_deps)
	for t in base core helm jdk11 jre11 postgres14-jdk11; do
		$(MAKE) buildx yakworks/bullseye:$$t
	done

## builds and pushes all the debian bullseye targets
bullseye.push: $(bullseye_deps)
	for t in base core helm jdk11 jre11 postgres14-jdk11; do
		$(MAKE) push yakworks/bullseye:$$t
	done

FNAMES = foo\:core foo\:base
FIMAGES = build/demo/foo\:core build/demo/foo\:base
FIMAGES_PUSH = $(addsuffix .push,$(FIMAGES))

build/demo/foo\:core: build/demo/foo\:base

$(FNAMES): %: build/demo/%
	# fired when deps are done
	$(logr) $@
	echo "$*"

$(FIMAGES): build/%:
	$(logr) $@
	echo "$*"
	touch $@

$(FIMAGES_PUSH): build/%:
	$(logr) $@
	echo "$*"
