{
  local hidden = (import '_hidden.libsonnet'),
  meta:: {
    v1beta2:: {
      local apiVersion = { apiVersion: 'apps/v1beta2' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      replicaSet:: {
        local kind = { kind: 'ReplicaSet' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}