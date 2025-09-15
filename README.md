# Validated Patterns must-gather

`must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather more related information to Validated Patterns.

## Usage

```sh
# From the patterns git root folder
oc adm must-gather --image=quay.io/validatedpatterns/must-gather
```

The command above will create a local directory with a dump of the operator's state.

You will get a dump of:

- The namespaces used by the patterns in their values-\* files
- The pod logs running in the namespaces running an argocd instance

In order to get data about other parts of the cluster (not specific to Validated Patterns) you should
run `oc adm must-gather` (without passing a custom image). Run `oc adm must-gather -h` to see more options.

## Development

You can build the image locally using the Containerfile included.

A `Makefile` is also provided. Override `UPLOADREGISTRY`, `NAME` and/or `TAG` to your needs. Default is
`quay.io/validatedpatterns/must-gather:latest`.

The targets for `make` are as follows:

- `build`: builds the image locally with podman
- `upload`: uploads the (previously built) image to `$UPLOADREGISTRY`

For example:

```sh
make build NAME=my-must-gather TAG=0.0.1-test
make upload UPLOADREGISTRY=quay.io/my_user
```

would build the image locally as `my-must-gather:0.0.1-test` and then push it to
`quay.io/my_user/my-must-gather:0.0.1-test`.
