.PHONY: default docker_build docker_push

default: docker_build

DOCKER_IMAGE ?= endrec/helm-kubectl-python
DOCKER_TAG ?= `git rev-parse --abbrev-ref HEAD`

docker_build:
	@docker build \
	  --build-arg VCS_REF=`git rev-parse --short HEAD` \
	  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	  --build-arg HELM_VERSION \
	  --build-arg KUBE_LATEST_VERSION \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
	  
docker_push: docker_build
	# Push to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
