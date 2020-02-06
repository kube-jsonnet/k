{
  meta:: {
    v1:: {
      local apiVersion = { apiVersion: 'rbac.authorization.k8s.io/v1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      clusterRoleBinding:: {
        local kind = { kind: 'ClusterRoleBinding' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}