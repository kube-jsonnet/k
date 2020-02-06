{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'apiregistration.k8s.io/v1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    apiService:: {
      local kind = { kind: 'APIService' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}