{
  local hidden = (import '_hidden.libsonnet'),
  meta:: {
    v2beta1:: {
      local apiVersion = { apiVersion: 'autoscaling/v2beta1' },
      // Patch is provided to give a concrete name and type to the Kubernetes PATCH request body.
      horizontalPodAutoscaler:: {
        local kind = { kind: 'HorizontalPodAutoscaler' },
        new():: apiVersion + kind,
        mixin:: {},
      },
    },
  },
}