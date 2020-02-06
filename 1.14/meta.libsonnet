{
  meta:: {
    v1beta1:: {
      local apiVersion = { apiVersion: 'apps/v1beta1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      scale:: {
        local kind = { kind: 'Scale' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}