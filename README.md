Poison Pill must-gather
=================

`must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather Poison Pill related information.

### Usage
```sh
oc adm must-gather --image=quay.io/<tbd>/must-gather
```

The command above will create a local directory with a dump of the poison pill state.
Note that this command will only get data related to the poison pill part of the OpenShift cluster.

You will get a dump of:
- openshift-machine-api namespace
- nodes
- machines

In order to get data about other parts of the cluster (not specific to poison pill) you should
run `oc adm must-gather` (without passing a custom image). Run `oc adm must-gather -h` to see more options.

### Development
You can build the image locally using the Dockerfile included.

A `makefile` is also provided. To use it, you must pass a repository via the command-line using the variable `MUST_GATHER_IMAGE`.
You can also specify the registry using the variable `IMAGE_REGISTRY` (default is [quay.io](https://quay.io)) and the tag via `IMAGE_TAG` (default is `latest`).

The targets for `make` are as follows:
- `build`: builds the image with the supplied name and pushes it
- `docker-build`: builds the image but does not push it
- `docker-push`: pushes an already-built image

For example:
```sh
make build MUST_GATHER_IMAGE=foo/must-gather
```
would build the local repository as `quay.io/foo/must-gather:latest` and then push it.