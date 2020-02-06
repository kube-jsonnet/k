{
  local hidden = (import '_hidden.libsonnet'),
  meta:: {
    v1beta1:: {
      local apiVersion = { apiVersion: 'storage.k8s.io/v1beta1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      csiNode:: {
        local kind = { kind: 'CSINode' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}