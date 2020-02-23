{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'scheduling.k8s.io/v1beta1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    priorityClass:: {
      local kind = { kind: 'PriorityClass' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}