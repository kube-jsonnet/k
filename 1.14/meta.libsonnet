{
  local hidden = (import '_hidden.libsonnet'),
  v1alpha1:: {
    local apiVersion = { apiVersion: 'auditregistration.k8s.io/v1alpha1' },
    // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
    auditSink:: {
      local kind = { kind: 'AuditSink' },
      new():: apiVersion + kind,
      mixin:: {},
    },
  },
}