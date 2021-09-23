SHELL := /bin/bash
MAKEFLAGS += -rR

SLUG_TAG := yakworks/nfs-server:3.14

# double $$ means esacpe it and send to bash as a single $
# for CI login to docker hub using whats in the env vars $DOCKERHUB_USER $DOCKERHUB_PASSWORD
dockerhub-login: FORCE
	echo "$$DOCKERHUB_PASSWORD" | docker login -u "$$DOCKERHUB_USER" --password-stdin

build:
	docker build -t $(SLUG_TAG) .

push:
	docker push $(SLUG_TAG)

run:
	docker run --name nfs_server_test --privileged \
		-v `pwd`:/nfs-volume \
		-e SHARED_DIRECTORY=nfsshare \
		$(SLUG_TAG)

clean:
	docker rm nfs_server_test