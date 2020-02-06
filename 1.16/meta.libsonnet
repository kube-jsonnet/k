{
  meta:: {
    v1:: {
      local apiVersion = { apiVersion: 'v1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      persistentVolume:: {
        local kind = { kind: 'PersistentVolume' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}