{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'rbac.authorization.k8s.io/v1beta1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    roleBinding:: {
      local kind = { kind: 'RoleBinding' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}