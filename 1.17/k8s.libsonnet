{
  __ksonnet: {
    "k8s.io": {
      checksum: '135115c7795ce7e1eceeef34301a1f82fc9972314627261b90bf8913e26d92fa',
      generator: {
        vendor: 'github.com/kube-jsonnet/k',
        version: 'f85c9f5',
      },
      maintainer: 'kube-jsonnet',
      version: '1.17.0',
    },
  },
  _hidden:: (import '_hidden.libsonnet'),
  admissionregistration:: (import 'admissionregistration.libsonnet'),
  apiextensions:: (import 'apiextensions.libsonnet'),
  apiregistration:: (import 'apiregistration.libsonnet'),
  apps:: (import 'apps.libsonnet'),
  auditregistration:: (import 'auditregistration.libsonnet'),
  authentication:: (import 'authentication.libsonnet'),
  authorization:: (import 'authorization.libsonnet'),
  autoscaling:: (import 'autoscaling.libsonnet'),
  batch:: (import 'batch.libsonnet'),
  certificates:: (import 'certificates.libsonnet'),
  coordination:: (import 'coordination.libsonnet'),
  core:: (import 'core.libsonnet'),
  discovery:: (import 'discovery.libsonnet'),
  events:: (import 'events.libsonnet'),
  extensions:: (import 'extensions.libsonnet'),
  flowcontrol:: (import 'flowcontrol.libsonnet'),
  meta:: (import 'meta.libsonnet'),
  networking:: (import 'networking.libsonnet'),
  node:: (import 'node.libsonnet'),
  policy:: (import 'policy.libsonnet'),
  rbac:: (import 'rbac.libsonnet'),
  scheduling:: (import 'scheduling.libsonnet'),
  settings:: (import 'settings.libsonnet'),
  storage:: (import 'storage.libsonnet'),
}