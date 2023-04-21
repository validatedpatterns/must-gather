# Hybrid Cloud Patterns must-gather

`must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather more related information to Validated Patterns.

## Usage

```sh
# From the patterns git root folder
oc adm must-gather --image=quay.io/hybridcloudpatterns/must-gather
```

The command above will create a local directory with a dump of the operator's state.

You will get a dump of:
- The namespaces used by the patterns in their values-* files
- The pod logs running in the namespaces running an argocd instance

In order to get data about other parts of the cluster (not specific to hybridcloudpatterns) you should
run `oc adm must-gather` (without passing a custom image). Run `oc adm must-gather -h` to see more options.

## Development

You can build the image locally using the Dockerfile included.

A `makefile` is also provided. Override `IMAGE_REGISTRY`, `IMAGE_NAME` and/or `IMAGE_TAG` to your needs. Default is
`quay.io/hybridcloudpatterns/must-gather:latest`.

The targets for `make` are as follows:
- `build`: builds the image with the supplied name and pushes it
- `docker-build`: builds the image but does not push it
- `docker-push`: pushes an already-built image

For example:
```sh
make build IMAGE_REGISTRY=quay.io/my-user IMAGE_NAME=my-must-gather IMAGE_TAG=0.0.1-test
```
would build the local repository as `quay.io/my-user/my-must-gather:0.0.1-test` and then push it.
