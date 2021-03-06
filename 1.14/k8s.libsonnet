{
  __ksonnet: {
    "k8s.io": {
      checksum: 'b923088253256b1ed1631fb8f32328d08984583a7f31c58c1a2d95926f71f204',
      generator: {
        vendor: 'github.com/kube-jsonnet/k',
        version: '21598b7-dirty',
      },
      maintainer: 'kube-jsonnet',
      version: '1.14.0',
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
  events:: (import 'events.libsonnet'),
  extensions:: (import 'extensions.libsonnet'),
  meta:: (import 'meta.libsonnet'),
  networking:: (import 'networking.libsonnet'),
  node:: (import 'node.libsonnet'),
  policy:: (import 'policy.libsonnet'),
  rbac:: (import 'rbac.libsonnet'),
  scheduling:: (import 'scheduling.libsonnet'),
  settings:: (import 'settings.libsonnet'),
  storage:: (import 'storage.libsonnet'),
}