IMAGE_REGISTRY ?= quay.io/hybridcloudpatterns
IMAGE_NAME ?= must-gather
IMAGE_TAG ?= latest

IMAGE ?= ${IMAGE_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

##@ Pattern Must Gather Tasks

.PHONY: help
help: ## This help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^(\s|[a-zA-Z_0-9-])+:.*?##/ { printf "  \033[36m%-35s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build
build: docker-build docker-push ## build container and push it to quay

.PHONY: check ## run shellcheck on the gathering script
check:
	shellcheck collection-scripts/*

.PHONY: docker-build
docker-build: ## build container
	docker build -t ${IMAGE} .

.PHONY: docker-push
docker-push: ## push container
	docker push ${IMAGE}

.PHONY: super-linter
super-linter: ## Runs super linter locally
	rm -rf .mypy_cache
	podman run -e RUN_LOCAL=true -e USE_FIND_ALGORITHM=true	\
					-e VALIDATE_ANSIBLE=false \
					-e VALIDATE_BASH=false \
					-e VALIDATE_CHECKOV=false \
					-e VALIDATE_DOCKERFILE_HADOLINT=false \
					-e VALIDATE_GITHUB_ACTIONS_ZIZMOR=false \
					-e VALIDATE_JSCPD=false \
					-e VALIDATE_JSON_PRETTIER=false \
					-e VALIDATE_MARKDOWN_PRETTIER=false \
					-e VALIDATE_PYTHON_PYLINT=false \
					-e VALIDATE_SHELL_SHFMT=false \
					-e VALIDATE_TRIVY=false \
					-e VALIDATE_YAML=false \
					-e VALIDATE_YAML_PRETTIER=false \
					$(DISABLE_LINTERS) \
					-v $(PWD):/tmp/lint:rw,z \
					-w /tmp/lint \
					ghcr.io/super-linter/super-linter:slim-v8
