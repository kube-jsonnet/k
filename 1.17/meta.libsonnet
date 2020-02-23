{
  local hidden = (import '_hidden.libsonnet'),
  v1alpha1:: {
    local apiVersion = { apiVersion: 'storage.k8s.io/v1alpha1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    volumeAttachment:: {
      local kind = { kind: 'VolumeAttachment' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}