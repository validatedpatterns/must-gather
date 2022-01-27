IMAGE_REGISTRY ?= quay.io/medik8s
IMAGE_NAME ?= must-gather
IMAGE_TAG ?= latest

IMAGE ?= ${IMAGE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

build: docker-build docker-push

# check
check:
	shellcheck collection-scripts/*

docker-build:
	docker build -t ${IMAGE} .

docker-push:
	docker push ${IMAGE}

.PHONY: build docker-build docker-push
