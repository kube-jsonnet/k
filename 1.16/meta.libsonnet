{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'batch/v1beta1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    cronJob:: {
      local kind = { kind: 'CronJob' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}