{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'storage.k8s.io/v1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    storageClass:: {
      local kind = { kind: 'StorageClass' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}