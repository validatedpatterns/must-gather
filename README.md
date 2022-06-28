Medik8s must-gather
=================

`must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather more related information to Medik8s operators.

### Usage
```sh
oc adm must-gather --image=quay.io/medik8s/must-gather
```

The command above will create a local directory with a dump of the operator's state.
Note that this command will only get data related to the operator's part of the OpenShift cluster.

You will get a dump of:
- the namespace to which NodeHealthCheck and Self Node Remediation Operators are deployed, including logs
- NHC and SNR related CRs
- Nodes

In order to get data about other parts of the cluster (not specific to medik8s) you should
run `oc adm must-gather` (without passing a custom image). Run `oc adm must-gather -h` to see more options.

### Development
You can build the image locally using the Dockerfile included.

A `makefile` is also provided. Override `IMAGE_REGISTRY`, `IMAGE_NAME` and/or `IMAGE_TAG` to your needs. Default is
`quay.io/medik8s/must-gather:latest`.

The targets for `make` are as follows:
- `build`: builds the image with the supplied name and pushes it
- `docker-build`: builds the image but does not push it
- `docker-push`: pushes an already-built image

For example:
```sh
make build IMAGE_REGISTRY=quay.io/my-user IMAGE_NAME=my-must-gather IMAGE_TAG=0.0.1-test
```
would build the local repository as `quay.io/my-user/my-must-gather:0.0.1-test` and then push it.
