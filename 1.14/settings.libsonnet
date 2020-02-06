{
  local hidden = (import '_hidden.libsonnet'),
  v1alpha1:: {
    local apiVersion = { apiVersion: 'settings.k8s.io/v1alpha1' },
    // PodPreset is a policy resource that defines additional runtime requirements for a Pod.
    podPreset:: {
      local kind = { kind: 'PodPreset' },
      new():: apiVersion + kind,
      mixin:: {
        metadata:: {
          local __metadataMixin(metadata) = { metadata+: metadata },
          mixinInstance(metadata):: __metadataMixin(metadata),
          // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
          withAnnotations(annotations):: self + __metadataMixin({ annotations: annotations }),
          // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
          withAnnotationsMixin(annotations):: self + __metadataMixin({ annotations+: annotations }),
          // The name of the cluster which the object belongs to. This is used to distinguish resources with same name and namespace in different clusters. This field is not set anywhere right now and apiserver is going to ignore it if set in create or update request.
          withClusterName(clusterName):: self + __metadataMixin({ clusterName: clusterName }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed.
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed.
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
          // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
          //
          // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
          //
          // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#idempotency
          withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
          // An initializer is a controller which enforces some system invariant at object creation time. This field is a list of initializers that have not yet acted on this object. If nil or empty, this object has been completely initialized. Otherwise, the object is considered uninitialized and is hidden (in list/watch and get calls) from clients that haven't explicitly asked to observe uninitialized objects.
          //
          // When an object is created, the system will populate this list with the current set of initializers. Only privileged users may set or modify this list. Once it is empty, it may not be modified further by any user.
          //
          // DEPRECATED - initializers are an alpha field and will be removed in v1.15.
          initializers:: {
            local __initializersMixin(initializers) = __metadataMixin({ initializers+: initializers }),
            mixinInstance(initializers):: __initializersMixin(initializers),
            // Pending is a list of initializers that must execute in order before this object is visible. When the last pending initializer is removed, and no failing result is set, the initializers struct will be set to nil and the object is considered as initialized and visible to all clients.
            withPending(pending):: self + if std.type(pending) == 'array' then __initializersMixin({ pending: pending }) else __initializersMixin({ pending: [pending] }),
            // Pending is a list of initializers that must execute in order before this object is visible. When the last pending initializer is removed, and no failing result is set, the initializers struct will be set to nil and the object is considered as initialized and visible to all clients.
            withPendingMixin(pending):: self + if std.type(pending) == 'array' then __initializersMixin({ pending+: pending }) else __initializersMixin({ pending+: [pending] }),
            pendingType:: hidden.meta.v1.initializer,
          },
          initializersType:: hidden.meta.v1.initializers,
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabels(labels):: self + __metadataMixin({ labels: labels }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          //
          // This field is alpha and can be changed or removed without notice.
          withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          //
          // This field is alpha and can be changed or removed without notice.
          withManagedFieldsMixin(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields+: managedFields }) else __metadataMixin({ managedFields+: [managedFields] }),
          managedFieldsType:: hidden.meta.v1.managedFieldsEntry,
          // Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __metadataMixin({ name: name }),
          // Namespace defines the space within each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.
          //
          // Must be a DNS_LABEL. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/namespaces
          withNamespace(namespace):: self + __metadataMixin({ namespace: namespace }),
          // List of objects depended by this object. If ALL objects in the list have been deleted, this object will be garbage collected. If this object is managed by a controller, then an entry in this list will point to this controller, with the controller field set to true. There cannot be more than one managing controller.
          withOwnerReferences(ownerReferences):: self + if std.type(ownerReferences) == 'array' then __metadataMixin({ ownerReferences: ownerReferences }) else __metadataMixin({ ownerReferences: [ownerReferences] }),
          // List of objects depended by this object. If ALL objects in the list have been deleted, this object will be garbage collected. If this object is managed by a controller, then an entry in this list will point to this controller, with the controller field set to true. There cannot be more than one managing controller.
          withOwnerReferencesMixin(ownerReferences):: self + if std.type(ownerReferences) == 'array' then __metadataMixin({ ownerReferences+: ownerReferences }) else __metadataMixin({ ownerReferences+: [ownerReferences] }),
          ownerReferencesType:: hidden.meta.v1.ownerReference,
        },
        metadataType:: hidden.meta.v1.objectMeta,
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Env defines the collection of EnvVar to inject into containers.
          withEnv(env):: self + if std.type(env) == 'array' then __specMixin({ env: env }) else __specMixin({ env: [env] }),
          // Env defines the collection of EnvVar to inject into containers.
          withEnvMixin(env):: self + if std.type(env) == 'array' then __specMixin({ env+: env }) else __specMixin({ env+: [env] }),
          envType:: hidden.core.v1.envVar,
          // EnvFrom defines the collection of EnvFromSource to inject into containers.
          withEnvFrom(envFrom):: self + if std.type(envFrom) == 'array' then __specMixin({ envFrom: envFrom }) else __specMixin({ envFrom: [envFrom] }),
          // EnvFrom defines the collection of EnvFromSource to inject into containers.
          withEnvFromMixin(envFrom):: self + if std.type(envFrom) == 'array' then __specMixin({ envFrom+: envFrom }) else __specMixin({ envFrom+: [envFrom] }),
          envFromType:: hidden.core.v1.envFromSource,
          // Selector is a label query over a set of resources, in this case pods. Required.
          selector:: {
            local __selectorMixin(selector) = __specMixin({ selector+: selector }),
            mixinInstance(selector):: __selectorMixin(selector),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __selectorMixin({ matchExpressions: matchExpressions }) else __selectorMixin({ matchExpressions: [matchExpressions] }),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __selectorMixin({ matchExpressions+: matchExpressions }) else __selectorMixin({ matchExpressions+: [matchExpressions] }),
            matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabels(matchLabels):: self + __selectorMixin({ matchLabels: matchLabels }),
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabelsMixin(matchLabels):: self + __selectorMixin({ matchLabels+: matchLabels }),
          },
          selectorType:: hidden.meta.v1.labelSelector,
          // VolumeMounts defines the collection of VolumeMount to inject into containers.
          withVolumeMounts(volumeMounts):: self + if std.type(volumeMounts) == 'array' then __specMixin({ volumeMounts: volumeMounts }) else __specMixin({ volumeMounts: [volumeMounts] }),
          // VolumeMounts defines the collection of VolumeMount to inject into containers.
          withVolumeMountsMixin(volumeMounts):: self + if std.type(volumeMounts) == 'array' then __specMixin({ volumeMounts+: volumeMounts }) else __specMixin({ volumeMounts+: [volumeMounts] }),
          volumeMountsType:: hidden.core.v1.volumeMount,
          // Volumes defines the collection of Volume to inject into the pod.
          withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
          // Volumes defines the collection of Volume to inject into the pod.
          withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
          volumesType:: hidden.core.v1.volume,
        },
        specType:: hidden.settings.v1alpha1.podPresetSpec,
      },
    },
  },
}