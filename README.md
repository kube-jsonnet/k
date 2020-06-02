# !!! THIS REPOSITORY HAS BEEN DEPRECATED IN FAVOR OF [k8s-alpha](https://github.com/jsonnet-libs/k8s-alpha)!!!

# `k.libsonnet`: The Kubernetes library for Jsonnet

Generated from Kubernetes' `swagger.json`, this project provides an always
up-to-date library for quick, flexible and concise creation of
Kubernetes objects using Jsonnet.

## Install

Use jsonnet-bundler to add this library to your `vendor/` folder:

```bash
$ jb install github.com/kube-jsonnet/k/1.16
```

> You might need to pick another cluster version than `1.16`, use `kubectl version` to check that.

## Usage:

```jsonnet
// import the library
(import "github.com/kube-jsonnet/k/1.16/k.libsonnet") +
{
  // create an example deployment
  deployment: $.apps.v1.deployment.new(name="grafana", replicas=1, containers=[
    $.core.v1.container.new(name="grafana", image="grafana/grafana")
  ])
}
```

For more examples, check https://x.tanka.dev

## Versioning

In the context of this project, there are two different versions:

1. **Kubernetes target**: Equals the Kubernetes version, the library is generated
   for. For each Kubernetes major release that is supported, a subdirectory
   exists in this repo, containing a matching library.
2. **Library version**: Independent from the targeted Kubernetes version, this
   repository is frequently released (`git tag`). This version resembles
   enhancements to the generator, etc.

At any time, `master` can be considered stable, tags are just for historic reference.

### Support policy

We support at least three major versions including the current one, perhaps more
when reasonable.

As soon as a version is not maintained anymore, its respective subdirectory is
removed from the tree. If you still need it, consider using the previous tag of
this project that still includes it.

# License

Licensed Apache 2.0, see [`LICENSE`](LICENSE).
