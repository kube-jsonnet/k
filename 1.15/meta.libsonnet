{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'v1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    namespace:: {
      local kind = { kind: 'Namespace' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}