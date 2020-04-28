{
  local hidden = (import '_hidden.libsonnet'),
  v1beta2:: {
    local apiVersion = { apiVersion: 'apps/v1beta2' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    statefulSet:: {
      local kind = { kind: 'StatefulSet' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}