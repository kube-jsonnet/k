{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'policy/v1beta1' },
    // Eviction evicts a pod from its node subject to certain policies and safety constraints. This is a subresource of Pod.  A request to cause such an eviction is created by POSTing to .../pods/<pod name>/evictions.
    eviction:: {
      local kind = { kind: 'Eviction' },
      new():: apiVersion + kind,
      mixin:: {
        // DeleteOptions may be provided
        deleteOptions:: {
          local __deleteOptionsMixin(deleteOptions) = { deleteOptions+: deleteOptions },
          mixinInstance(deleteOptions):: __deleteOptionsMixin(deleteOptions),
          // When present, indicates that modifications should not be persisted. An invalid or unrecognized dryRun directive will result in an error response and no further processing of the request. Valid values are: - All: all dry run stages will be processed
          withDryRun(dryRun):: self + if std.type(dryRun) == 'array' then __deleteOptionsMixin({ dryRun: dryRun }) else __deleteOptionsMixin({ dryRun: [dryRun] }),
          // When present, indicates that modifications should not be persisted. An invalid or unrecognized dryRun directive will result in an error response and no further processing of the request. Valid values are: - All: all dry run stages will be processed
          withDryRunMixin(dryRun):: self + if std.type(dryRun) == 'array' then __deleteOptionsMixin({ dryRun+: dryRun }) else __deleteOptionsMixin({ dryRun+: [dryRun] }),
          // The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately.
          withGracePeriodSeconds(gracePeriodSeconds):: self + __deleteOptionsMixin({ gracePeriodSeconds: gracePeriodSeconds }),
          // Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the "orphan" finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both.
          withOrphanDependents(orphanDependents):: self + __deleteOptionsMixin({ orphanDependents: orphanDependents }),
          // Must be fulfilled before a deletion is carried out. If not possible, a 409 Conflict status will be returned.
          preconditions:: {
            local __preconditionsMixin(preconditions) = __deleteOptionsMixin({ preconditions+: preconditions }),
            mixinInstance(preconditions):: __preconditionsMixin(preconditions),
            // Specifies the target ResourceVersion
            withResourceVersion(resourceVersion):: self + __preconditionsMixin({ resourceVersion: resourceVersion }),
            // Specifies the target UID.
            withUid(uid):: self + __preconditionsMixin({ uid: uid }),
          },
          preconditionsType:: hidden.meta.v1.preconditions,
          // Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground.
          withPropagationPolicy(propagationPolicy):: self + __deleteOptionsMixin({ propagationPolicy: propagationPolicy }),
        },
        deleteOptionsType:: hidden.meta.v1.deleteOptions,
        // ObjectMeta describes the pod that is being evicted.
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
      },
    },
    // PodDisruptionBudget is an object to define the max disruption that can be caused to a collection of pods
    podDisruptionBudget:: {
      local kind = { kind: 'PodDisruptionBudget' },
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
        // Specification of the desired behavior of the PodDisruptionBudget.
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // An eviction is allowed if at most "maxUnavailable" pods selected by "selector" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with "minAvailable".
          withMaxUnavailable(maxUnavailable):: self + __specMixin({ maxUnavailable: maxUnavailable }),
          // An eviction is allowed if at least "minAvailable" pods selected by "selector" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying "100%".
          withMinAvailable(minAvailable):: self + __specMixin({ minAvailable: minAvailable }),
          // Label query over pods whose evictions are managed by the disruption budget.
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
        },
        specType:: hidden.policy.v1beta1.podDisruptionBudgetSpec,
      },
    },
    // PodSecurityPolicy governs the ability to make requests that affect the Security Context that will be applied to a pod and container.
    podSecurityPolicy:: {
      local kind = { kind: 'PodSecurityPolicy' },
      new():: apiVersion + kind,
      mixin:: {
        // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
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
        // spec defines the policy enforced.
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // allowPrivilegeEscalation determines if a pod can request to allow privilege escalation. If unspecified, defaults to true.
          withAllowPrivilegeEscalation(allowPrivilegeEscalation):: self + __specMixin({ allowPrivilegeEscalation: allowPrivilegeEscalation }),
          // AllowedCSIDrivers is a whitelist of inline CSI drivers that must be explicitly set to be embedded within a pod spec. An empty value means no CSI drivers can run inline within a pod spec.
          withAllowedCsiDrivers(allowedCsiDrivers):: self + if std.type(allowedCsiDrivers) == 'array' then __specMixin({ allowedCSIDrivers: allowedCsiDrivers }) else __specMixin({ allowedCSIDrivers: [allowedCsiDrivers] }),
          // AllowedCSIDrivers is a whitelist of inline CSI drivers that must be explicitly set to be embedded within a pod spec. An empty value means no CSI drivers can run inline within a pod spec.
          withAllowedCsiDriversMixin(allowedCsiDrivers):: self + if std.type(allowedCsiDrivers) == 'array' then __specMixin({ allowedCSIDrivers+: allowedCsiDrivers }) else __specMixin({ allowedCSIDrivers+: [allowedCsiDrivers] }),
          allowedCSIDriversType:: hidden.policy.v1beta1.allowedCsiDriver,
          // allowedCapabilities is a list of capabilities that can be requested to add to the container. Capabilities in this field may be added at the pod author's discretion. You must not list a capability in both allowedCapabilities and requiredDropCapabilities.
          withAllowedCapabilities(allowedCapabilities):: self + if std.type(allowedCapabilities) == 'array' then __specMixin({ allowedCapabilities: allowedCapabilities }) else __specMixin({ allowedCapabilities: [allowedCapabilities] }),
          // allowedCapabilities is a list of capabilities that can be requested to add to the container. Capabilities in this field may be added at the pod author's discretion. You must not list a capability in both allowedCapabilities and requiredDropCapabilities.
          withAllowedCapabilitiesMixin(allowedCapabilities):: self + if std.type(allowedCapabilities) == 'array' then __specMixin({ allowedCapabilities+: allowedCapabilities }) else __specMixin({ allowedCapabilities+: [allowedCapabilities] }),
          // allowedFlexVolumes is a whitelist of allowed Flexvolumes.  Empty or nil indicates that all Flexvolumes may be used.  This parameter is effective only when the usage of the Flexvolumes is allowed in the "volumes" field.
          withAllowedFlexVolumes(allowedFlexVolumes):: self + if std.type(allowedFlexVolumes) == 'array' then __specMixin({ allowedFlexVolumes: allowedFlexVolumes }) else __specMixin({ allowedFlexVolumes: [allowedFlexVolumes] }),
          // allowedFlexVolumes is a whitelist of allowed Flexvolumes.  Empty or nil indicates that all Flexvolumes may be used.  This parameter is effective only when the usage of the Flexvolumes is allowed in the "volumes" field.
          withAllowedFlexVolumesMixin(allowedFlexVolumes):: self + if std.type(allowedFlexVolumes) == 'array' then __specMixin({ allowedFlexVolumes+: allowedFlexVolumes }) else __specMixin({ allowedFlexVolumes+: [allowedFlexVolumes] }),
          allowedFlexVolumesType:: hidden.policy.v1beta1.allowedFlexVolume,
          // allowedHostPaths is a white list of allowed host paths. Empty indicates that all host paths may be used.
          withAllowedHostPaths(allowedHostPaths):: self + if std.type(allowedHostPaths) == 'array' then __specMixin({ allowedHostPaths: allowedHostPaths }) else __specMixin({ allowedHostPaths: [allowedHostPaths] }),
          // allowedHostPaths is a white list of allowed host paths. Empty indicates that all host paths may be used.
          withAllowedHostPathsMixin(allowedHostPaths):: self + if std.type(allowedHostPaths) == 'array' then __specMixin({ allowedHostPaths+: allowedHostPaths }) else __specMixin({ allowedHostPaths+: [allowedHostPaths] }),
          allowedHostPathsType:: hidden.policy.v1beta1.allowedHostPath,
          // AllowedProcMountTypes is a whitelist of allowed ProcMountTypes. Empty or nil indicates that only the DefaultProcMountType may be used. This requires the ProcMountType feature flag to be enabled.
          withAllowedProcMountTypes(allowedProcMountTypes):: self + if std.type(allowedProcMountTypes) == 'array' then __specMixin({ allowedProcMountTypes: allowedProcMountTypes }) else __specMixin({ allowedProcMountTypes: [allowedProcMountTypes] }),
          // AllowedProcMountTypes is a whitelist of allowed ProcMountTypes. Empty or nil indicates that only the DefaultProcMountType may be used. This requires the ProcMountType feature flag to be enabled.
          withAllowedProcMountTypesMixin(allowedProcMountTypes):: self + if std.type(allowedProcMountTypes) == 'array' then __specMixin({ allowedProcMountTypes+: allowedProcMountTypes }) else __specMixin({ allowedProcMountTypes+: [allowedProcMountTypes] }),
          // allowedUnsafeSysctls is a list of explicitly allowed unsafe sysctls, defaults to none. Each entry is either a plain sysctl name or ends in "*" in which case it is considered as a prefix of allowed sysctls. Single * means all unsafe sysctls are allowed. Kubelet has to whitelist all allowed unsafe sysctls explicitly to avoid rejection.
          //
          // Examples: e.g. "foo/*" allows "foo/bar", "foo/baz", etc. e.g. "foo.*" allows "foo.bar", "foo.baz", etc.
          withAllowedUnsafeSysctls(allowedUnsafeSysctls):: self + if std.type(allowedUnsafeSysctls) == 'array' then __specMixin({ allowedUnsafeSysctls: allowedUnsafeSysctls }) else __specMixin({ allowedUnsafeSysctls: [allowedUnsafeSysctls] }),
          // allowedUnsafeSysctls is a list of explicitly allowed unsafe sysctls, defaults to none. Each entry is either a plain sysctl name or ends in "*" in which case it is considered as a prefix of allowed sysctls. Single * means all unsafe sysctls are allowed. Kubelet has to whitelist all allowed unsafe sysctls explicitly to avoid rejection.
          //
          // Examples: e.g. "foo/*" allows "foo/bar", "foo/baz", etc. e.g. "foo.*" allows "foo.bar", "foo.baz", etc.
          withAllowedUnsafeSysctlsMixin(allowedUnsafeSysctls):: self + if std.type(allowedUnsafeSysctls) == 'array' then __specMixin({ allowedUnsafeSysctls+: allowedUnsafeSysctls }) else __specMixin({ allowedUnsafeSysctls+: [allowedUnsafeSysctls] }),
          // defaultAddCapabilities is the default set of capabilities that will be added to the container unless the pod spec specifically drops the capability.  You may not list a capability in both defaultAddCapabilities and requiredDropCapabilities. Capabilities added here are implicitly allowed, and need not be included in the allowedCapabilities list.
          withDefaultAddCapabilities(defaultAddCapabilities):: self + if std.type(defaultAddCapabilities) == 'array' then __specMixin({ defaultAddCapabilities: defaultAddCapabilities }) else __specMixin({ defaultAddCapabilities: [defaultAddCapabilities] }),
          // defaultAddCapabilities is the default set of capabilities that will be added to the container unless the pod spec specifically drops the capability.  You may not list a capability in both defaultAddCapabilities and requiredDropCapabilities. Capabilities added here are implicitly allowed, and need not be included in the allowedCapabilities list.
          withDefaultAddCapabilitiesMixin(defaultAddCapabilities):: self + if std.type(defaultAddCapabilities) == 'array' then __specMixin({ defaultAddCapabilities+: defaultAddCapabilities }) else __specMixin({ defaultAddCapabilities+: [defaultAddCapabilities] }),
          // defaultAllowPrivilegeEscalation controls the default setting for whether a process can gain more privileges than its parent process.
          withDefaultAllowPrivilegeEscalation(defaultAllowPrivilegeEscalation):: self + __specMixin({ defaultAllowPrivilegeEscalation: defaultAllowPrivilegeEscalation }),
          // forbiddenSysctls is a list of explicitly forbidden sysctls, defaults to none. Each entry is either a plain sysctl name or ends in "*" in which case it is considered as a prefix of forbidden sysctls. Single * means all sysctls are forbidden.
          //
          // Examples: e.g. "foo/*" forbids "foo/bar", "foo/baz", etc. e.g. "foo.*" forbids "foo.bar", "foo.baz", etc.
          withForbiddenSysctls(forbiddenSysctls):: self + if std.type(forbiddenSysctls) == 'array' then __specMixin({ forbiddenSysctls: forbiddenSysctls }) else __specMixin({ forbiddenSysctls: [forbiddenSysctls] }),
          // forbiddenSysctls is a list of explicitly forbidden sysctls, defaults to none. Each entry is either a plain sysctl name or ends in "*" in which case it is considered as a prefix of forbidden sysctls. Single * means all sysctls are forbidden.
          //
          // Examples: e.g. "foo/*" forbids "foo/bar", "foo/baz", etc. e.g. "foo.*" forbids "foo.bar", "foo.baz", etc.
          withForbiddenSysctlsMixin(forbiddenSysctls):: self + if std.type(forbiddenSysctls) == 'array' then __specMixin({ forbiddenSysctls+: forbiddenSysctls }) else __specMixin({ forbiddenSysctls+: [forbiddenSysctls] }),
          // fsGroup is the strategy that will dictate what fs group is used by the SecurityContext.
          fsGroup:: {
            local __fsGroupMixin(fsGroup) = __specMixin({ fsGroup+: fsGroup }),
            mixinInstance(fsGroup):: __fsGroupMixin(fsGroup),
            // ranges are the allowed ranges of fs groups.  If you would like to force a single fs group then supply a single range with the same start and end. Required for MustRunAs.
            withRanges(ranges):: self + if std.type(ranges) == 'array' then __fsGroupMixin({ ranges: ranges }) else __fsGroupMixin({ ranges: [ranges] }),
            // ranges are the allowed ranges of fs groups.  If you would like to force a single fs group then supply a single range with the same start and end. Required for MustRunAs.
            withRangesMixin(ranges):: self + if std.type(ranges) == 'array' then __fsGroupMixin({ ranges+: ranges }) else __fsGroupMixin({ ranges+: [ranges] }),
            rangesType:: hidden.policy.v1beta1.idRange,
            // rule is the strategy that will dictate what FSGroup is used in the SecurityContext.
            withRule(rule):: self + __fsGroupMixin({ rule: rule }),
          },
          fsGroupType:: hidden.policy.v1beta1.fsGroupStrategyOptions,
          // hostIPC determines if the policy allows the use of HostIPC in the pod spec.
          withHostIpc(hostIpc):: self + __specMixin({ hostIPC: hostIpc }),
          // hostNetwork determines if the policy allows the use of HostNetwork in the pod spec.
          withHostNetwork(hostNetwork):: self + __specMixin({ hostNetwork: hostNetwork }),
          // hostPID determines if the policy allows the use of HostPID in the pod spec.
          withHostPid(hostPid):: self + __specMixin({ hostPID: hostPid }),
          // hostPorts determines which host port ranges are allowed to be exposed.
          withHostPorts(hostPorts):: self + if std.type(hostPorts) == 'array' then __specMixin({ hostPorts: hostPorts }) else __specMixin({ hostPorts: [hostPorts] }),
          // hostPorts determines which host port ranges are allowed to be exposed.
          withHostPortsMixin(hostPorts):: self + if std.type(hostPorts) == 'array' then __specMixin({ hostPorts+: hostPorts }) else __specMixin({ hostPorts+: [hostPorts] }),
          hostPortsType:: hidden.policy.v1beta1.hostPortRange,
          // privileged determines if a pod can request to be run as privileged.
          withPrivileged(privileged):: self + __specMixin({ privileged: privileged }),
          // readOnlyRootFilesystem when set to true will force containers to run with a read only root file system.  If the container specifically requests to run with a non-read only root file system the PSP should deny the pod. If set to false the container may run with a read only root file system if it wishes but it will not be forced to.
          withReadOnlyRootFilesystem(readOnlyRootFilesystem):: self + __specMixin({ readOnlyRootFilesystem: readOnlyRootFilesystem }),
          // requiredDropCapabilities are the capabilities that will be dropped from the container.  These are required to be dropped and cannot be added.
          withRequiredDropCapabilities(requiredDropCapabilities):: self + if std.type(requiredDropCapabilities) == 'array' then __specMixin({ requiredDropCapabilities: requiredDropCapabilities }) else __specMixin({ requiredDropCapabilities: [requiredDropCapabilities] }),
          // requiredDropCapabilities are the capabilities that will be dropped from the container.  These are required to be dropped and cannot be added.
          withRequiredDropCapabilitiesMixin(requiredDropCapabilities):: self + if std.type(requiredDropCapabilities) == 'array' then __specMixin({ requiredDropCapabilities+: requiredDropCapabilities }) else __specMixin({ requiredDropCapabilities+: [requiredDropCapabilities] }),
          // RunAsGroup is the strategy that will dictate the allowable RunAsGroup values that may be set. If this field is omitted, the pod's RunAsGroup can take any value. This field requires the RunAsGroup feature gate to be enabled.
          runAsGroup:: {
            local __runAsGroupMixin(runAsGroup) = __specMixin({ runAsGroup+: runAsGroup }),
            mixinInstance(runAsGroup):: __runAsGroupMixin(runAsGroup),
            // ranges are the allowed ranges of gids that may be used. If you would like to force a single gid then supply a single range with the same start and end. Required for MustRunAs.
            withRanges(ranges):: self + if std.type(ranges) == 'array' then __runAsGroupMixin({ ranges: ranges }) else __runAsGroupMixin({ ranges: [ranges] }),
            // ranges are the allowed ranges of gids that may be used. If you would like to force a single gid then supply a single range with the same start and end. Required for MustRunAs.
            withRangesMixin(ranges):: self + if std.type(ranges) == 'array' then __runAsGroupMixin({ ranges+: ranges }) else __runAsGroupMixin({ ranges+: [ranges] }),
            rangesType:: hidden.policy.v1beta1.idRange,
            // rule is the strategy that will dictate the allowable RunAsGroup values that may be set.
            withRule(rule):: self + __runAsGroupMixin({ rule: rule }),
          },
          runAsGroupType:: hidden.policy.v1beta1.runAsGroupStrategyOptions,
          // runAsUser is the strategy that will dictate the allowable RunAsUser values that may be set.
          runAsUser:: {
            local __runAsUserMixin(runAsUser) = __specMixin({ runAsUser+: runAsUser }),
            mixinInstance(runAsUser):: __runAsUserMixin(runAsUser),
            // ranges are the allowed ranges of uids that may be used. If you would like to force a single uid then supply a single range with the same start and end. Required for MustRunAs.
            withRanges(ranges):: self + if std.type(ranges) == 'array' then __runAsUserMixin({ ranges: ranges }) else __runAsUserMixin({ ranges: [ranges] }),
            // ranges are the allowed ranges of uids that may be used. If you would like to force a single uid then supply a single range with the same start and end. Required for MustRunAs.
            withRangesMixin(ranges):: self + if std.type(ranges) == 'array' then __runAsUserMixin({ ranges+: ranges }) else __runAsUserMixin({ ranges+: [ranges] }),
            rangesType:: hidden.policy.v1beta1.idRange,
            // rule is the strategy that will dictate the allowable RunAsUser values that may be set.
            withRule(rule):: self + __runAsUserMixin({ rule: rule }),
          },
          runAsUserType:: hidden.policy.v1beta1.runAsUserStrategyOptions,
          // seLinux is the strategy that will dictate the allowable labels that may be set.
          seLinux:: {
            local __seLinuxMixin(seLinux) = __specMixin({ seLinux+: seLinux }),
            mixinInstance(seLinux):: __seLinuxMixin(seLinux),
            // rule is the strategy that will dictate the allowable labels that may be set.
            withRule(rule):: self + __seLinuxMixin({ rule: rule }),
            // seLinuxOptions required to run as; required for MustRunAs More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
            seLinuxOptions:: {
              local __seLinuxOptionsMixin(seLinuxOptions) = __seLinuxMixin({ seLinuxOptions+: seLinuxOptions }),
              mixinInstance(seLinuxOptions):: __seLinuxOptionsMixin(seLinuxOptions),
              // Level is SELinux level label that applies to the container.
              withLevel(level):: self + __seLinuxOptionsMixin({ level: level }),
              // Role is a SELinux role label that applies to the container.
              withRole(role):: self + __seLinuxOptionsMixin({ role: role }),
              // Type is a SELinux type label that applies to the container.
              withType(type):: self + __seLinuxOptionsMixin({ type: type }),
              // User is a SELinux user label that applies to the container.
              withUser(user):: self + __seLinuxOptionsMixin({ user: user }),
            },
            seLinuxOptionsType:: hidden.core.v1.seLinuxOptions,
          },
          seLinuxType:: hidden.policy.v1beta1.seLinuxStrategyOptions,
          // supplementalGroups is the strategy that will dictate what supplemental groups are used by the SecurityContext.
          supplementalGroups:: {
            local __supplementalGroupsMixin(supplementalGroups) = __specMixin({ supplementalGroups+: supplementalGroups }),
            mixinInstance(supplementalGroups):: __supplementalGroupsMixin(supplementalGroups),
            // ranges are the allowed ranges of supplemental groups.  If you would like to force a single supplemental group then supply a single range with the same start and end. Required for MustRunAs.
            withRanges(ranges):: self + if std.type(ranges) == 'array' then __supplementalGroupsMixin({ ranges: ranges }) else __supplementalGroupsMixin({ ranges: [ranges] }),
            // ranges are the allowed ranges of supplemental groups.  If you would like to force a single supplemental group then supply a single range with the same start and end. Required for MustRunAs.
            withRangesMixin(ranges):: self + if std.type(ranges) == 'array' then __supplementalGroupsMixin({ ranges+: ranges }) else __supplementalGroupsMixin({ ranges+: [ranges] }),
            rangesType:: hidden.policy.v1beta1.idRange,
            // rule is the strategy that will dictate what supplemental groups is used in the SecurityContext.
            withRule(rule):: self + __supplementalGroupsMixin({ rule: rule }),
          },
          supplementalGroupsType:: hidden.policy.v1beta1.supplementalGroupsStrategyOptions,
          // volumes is a white list of allowed volume plugins. Empty indicates that no volumes may be used. To allow all volumes you may use '*'.
          withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
          // volumes is a white list of allowed volume plugins. Empty indicates that no volumes may be used. To allow all volumes you may use '*'.
          withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
        },
        specType:: hidden.policy.v1beta1.podSecurityPolicySpec,
      },
    },
  },
}