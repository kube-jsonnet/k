{
  local hidden = (import '_hidden.libsonnet'),
  meta:: {
    v1:: {
      local apiVersion = { apiVersion: 'coordination.k8s.io/v1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      lease:: {
        local kind = { kind: 'Lease' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}