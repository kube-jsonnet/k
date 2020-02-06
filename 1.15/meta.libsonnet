{
  meta:: {
    v1beta1:: {
      local apiVersion = { apiVersion: 'apiextensions.k8s.io/v1beta1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      customResourceDefinition:: {
        local kind = { kind: 'CustomResourceDefinition' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}