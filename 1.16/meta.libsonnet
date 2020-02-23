{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'extensions/v1beta1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    ingress:: {
      local kind = { kind: 'Ingress' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}