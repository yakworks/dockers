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
IMAGES = $(addprefix $(subst :,\:,$(REGISTRY))/,$(NAMES))
DEPENDS = .depends.mk
PLATFORMS = linux/arm64,linux/amd64

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
$(DEPENDS): $(DOCKERFILES)
	grep '^FROM \$$REGISTRY/' $(DOCKERFILES) | \
		awk -F '/Dockerfile:FROM \\$$REGISTRY/' '{ print $$1 " " $$2 }' | \
		sed 's@[:/]@\\:@g' | awk '{ print "$(subst :,\\:,$(REGISTRY))/" $$1 ": " "$(subst :,\\:,$(REGISTRY))/" $$2 }' > $@

sinclude $(DEPENDS)

dummy_targets = run shell check pull push buildx checkrebuild
.PHONY: $(dummy_targets)

$(NAMES): %: $(REGISTRY)/%
 ifeq (run,$(filter run,$(MAKECMDGOALS)))
	docker run --rm -it $<
 endif
 ifeq (shell,$(filter shell,$(MAKECMDGOALS)))
	docker run --rm -it $< /bin/bash
 endif
 ifeq (check,$(filter check,$(MAKECMDGOALS)))
	duuh $<
 endif


$(IMAGES): DF_DIR=$(subst :,/,$(subst $(REGISTRY)/,,$@))
$(IMAGES):
 ifeq (pull,$(filter pull,$(MAKECMDGOALS)))
	docker pull $@
 endif
 ifeq (buildx,$(filter buildx,$(MAKECMDGOALS)))
	$(logr) "building $@ in $(DF_DIR)"
	docker build --build-arg REGISTRY=$(REGISTRY) -t $@ $(DF_DIR)
	docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg REGISTRY=$(REGISTRY) --platform $(PLATFORMS) -t $@ $(DF_DIR)
 endif
 ifeq (push,$(filter push,$(MAKECMDGOALS)))
	$(logr) "docker push $@"
	docker buildx build --push --platform $(PLATFORMS) -t $@ $(DF_DIR)
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

# build/wtf:
# 	$(logr)  "build/wtf ran"
# 	touch build/wtf
z:
	echo foo

build/%: %
	$(logr)  "$@ running, calling  $*"
	touch $@
