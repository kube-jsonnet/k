{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'networking.k8s.io/v1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    networkPolicy:: {
      local kind = { kind: 'NetworkPolicy' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}