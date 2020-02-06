{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'extensions/v1beta1' },
    // DEPRECATED - This group version of DaemonSet is deprecated by apps/v1beta2/DaemonSet. See the release notes for more information. DaemonSet represents the configuration of a daemon set.
    daemonSet:: {
      local kind = { kind: 'DaemonSet' },
      new():: apiVersion + kind,
      mixin:: {
        // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
        // The desired behavior of this daemon set. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // The minimum number of seconds for which a newly created DaemonSet pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready).
          withMinReadySeconds(minReadySeconds):: self + __specMixin({ minReadySeconds: minReadySeconds }),
          // The number of old history to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
          withRevisionHistoryLimit(revisionHistoryLimit):: self + __specMixin({ revisionHistoryLimit: revisionHistoryLimit }),
          // A label query over pods that are managed by the daemon set. Must match in order to be controlled. If empty, defaulted to labels on Pod template. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
          // An object that describes the pod that will be created. The DaemonSet will create exactly one copy of this pod on every node that matches the template's node selector (or on every node if no node selector is specified). More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
          template:: {
            local __templateMixin(template) = __specMixin({ template+: template }),
            mixinInstance(template):: __templateMixin(template),
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
            spec:: {
              local __specMixin(spec) = __templateMixin({ spec+: spec }),
              mixinInstance(spec):: __specMixin(spec),
              // Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.
              withActiveDeadlineSeconds(activeDeadlineSeconds):: self + __specMixin({ activeDeadlineSeconds: activeDeadlineSeconds }),
              // If specified, the pod's scheduling constraints
              affinity:: {
                local __affinityMixin(affinity) = __specMixin({ affinity+: affinity }),
                mixinInstance(affinity):: __affinityMixin(affinity),
                // Describes node affinity scheduling rules for the pod.
                nodeAffinity:: {
                  local __nodeAffinityMixin(nodeAffinity) = __affinityMixin({ nodeAffinity+: nodeAffinity }),
                  mixinInstance(nodeAffinity):: __nodeAffinityMixin(nodeAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.preferredSchedulingTerm,
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
                  requiredDuringSchedulingIgnoredDuringExecution:: {
                    local __requiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution) = __nodeAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }),
                    mixinInstance(requiredDuringSchedulingIgnoredDuringExecution):: __requiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution),
                    // Required. A list of node selector terms. The terms are ORed.
                    withNodeSelectorTerms(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms: nodeSelectorTerms }) else __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms: [nodeSelectorTerms] }),
                    // Required. A list of node selector terms. The terms are ORed.
                    withNodeSelectorTermsMixin(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms+: nodeSelectorTerms }) else __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms+: [nodeSelectorTerms] }),
                    nodeSelectorTermsType:: hidden.core.v1.nodeSelectorTerm,
                  },
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.nodeSelector,
                },
                nodeAffinityType:: hidden.core.v1.nodeAffinity,
                // Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
                podAffinity:: {
                  local __podAffinityMixin(podAffinity) = __affinityMixin({ podAffinity+: podAffinity }),
                  mixinInstance(podAffinity):: __podAffinityMixin(podAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.weightedPodAffinityTerm,
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecution(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: requiredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.podAffinityTerm,
                },
                podAffinityType:: hidden.core.v1.podAffinity,
                // Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
                podAntiAffinity:: {
                  local __podAntiAffinityMixin(podAntiAffinity) = __affinityMixin({ podAntiAffinity+: podAntiAffinity }),
                  mixinInstance(podAntiAffinity):: __podAntiAffinityMixin(podAntiAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.weightedPodAffinityTerm,
                  // If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecution(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: requiredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  // If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.podAffinityTerm,
                },
                podAntiAffinityType:: hidden.core.v1.podAntiAffinity,
              },
              affinityType:: hidden.core.v1.affinity,
              // AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
              withAutomountServiceAccountToken(automountServiceAccountToken):: self + __specMixin({ automountServiceAccountToken: automountServiceAccountToken }),
              // List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
              withContainers(containers):: self + if std.type(containers) == 'array' then __specMixin({ containers: containers }) else __specMixin({ containers: [containers] }),
              // List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
              withContainersMixin(containers):: self + if std.type(containers) == 'array' then __specMixin({ containers+: containers }) else __specMixin({ containers+: [containers] }),
              containersType:: hidden.core.v1.container,
              // Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.
              dnsConfig:: {
                local __dnsConfigMixin(dnsConfig) = __specMixin({ dnsConfig+: dnsConfig }),
                mixinInstance(dnsConfig):: __dnsConfigMixin(dnsConfig),
                // A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
                withNameservers(nameservers):: self + if std.type(nameservers) == 'array' then __dnsConfigMixin({ nameservers: nameservers }) else __dnsConfigMixin({ nameservers: [nameservers] }),
                // A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
                withNameserversMixin(nameservers):: self + if std.type(nameservers) == 'array' then __dnsConfigMixin({ nameservers+: nameservers }) else __dnsConfigMixin({ nameservers+: [nameservers] }),
                // A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
                withOptions(options):: self + if std.type(options) == 'array' then __dnsConfigMixin({ options: options }) else __dnsConfigMixin({ options: [options] }),
                // A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
                withOptionsMixin(options):: self + if std.type(options) == 'array' then __dnsConfigMixin({ options+: options }) else __dnsConfigMixin({ options+: [options] }),
                optionsType:: hidden.core.v1.podDnsConfigOption,
                // A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
                withSearches(searches):: self + if std.type(searches) == 'array' then __dnsConfigMixin({ searches: searches }) else __dnsConfigMixin({ searches: [searches] }),
                // A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
                withSearchesMixin(searches):: self + if std.type(searches) == 'array' then __dnsConfigMixin({ searches+: searches }) else __dnsConfigMixin({ searches+: [searches] }),
              },
              dnsConfigType:: hidden.core.v1.podDnsConfig,
              // Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.
              withDnsPolicy(dnsPolicy):: self + __specMixin({ dnsPolicy: dnsPolicy }),
              // EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true.
              withEnableServiceLinks(enableServiceLinks):: self + __specMixin({ enableServiceLinks: enableServiceLinks }),
              // HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
              withHostAliases(hostAliases):: self + if std.type(hostAliases) == 'array' then __specMixin({ hostAliases: hostAliases }) else __specMixin({ hostAliases: [hostAliases] }),
              // HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
              withHostAliasesMixin(hostAliases):: self + if std.type(hostAliases) == 'array' then __specMixin({ hostAliases+: hostAliases }) else __specMixin({ hostAliases+: [hostAliases] }),
              hostAliasesType:: hidden.core.v1.hostAlias,
              // Use the host's ipc namespace. Optional: Default to false.
              withHostIpc(hostIpc):: self + __specMixin({ hostIPC: hostIpc }),
              // Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false.
              withHostNetwork(hostNetwork):: self + __specMixin({ hostNetwork: hostNetwork }),
              // Use the host's pid namespace. Optional: Default to false.
              withHostPid(hostPid):: self + __specMixin({ hostPID: hostPid }),
              // Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.
              withHostname(hostname):: self + __specMixin({ hostname: hostname }),
              // ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
              withImagePullSecrets(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then __specMixin({ imagePullSecrets: imagePullSecrets }) else __specMixin({ imagePullSecrets: [imagePullSecrets] }),
              // ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
              withImagePullSecretsMixin(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then __specMixin({ imagePullSecrets+: imagePullSecrets }) else __specMixin({ imagePullSecrets+: [imagePullSecrets] }),
              imagePullSecretsType:: hidden.core.v1.localObjectReference,
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.
              withPriority(priority):: self + __specMixin({ priority: priority }),
              // If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.
              withPriorityClassName(priorityClassName):: self + __specMixin({ priorityClassName: priorityClassName }),
              // If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/0007-pod-ready%2B%2B.md
              withReadinessGates(readinessGates):: self + if std.type(readinessGates) == 'array' then __specMixin({ readinessGates: readinessGates }) else __specMixin({ readinessGates: [readinessGates] }),
              // If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/0007-pod-ready%2B%2B.md
              withReadinessGatesMixin(readinessGates):: self + if std.type(readinessGates) == 'array' then __specMixin({ readinessGates+: readinessGates }) else __specMixin({ readinessGates+: [readinessGates] }),
              readinessGatesType:: hidden.core.v1.podReadinessGate,
              // Restart policy for all containers within the pod. One of Always, OnFailure, Never. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
              withRestartPolicy(restartPolicy):: self + __specMixin({ restartPolicy: restartPolicy }),
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is an alpha feature and may change in the future.
              withRuntimeClassName(runtimeClassName):: self + __specMixin({ runtimeClassName: runtimeClassName }),
              // If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.
              withSchedulerName(schedulerName):: self + __specMixin({ schedulerName: schedulerName }),
              // SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.
              securityContext:: {
                local __securityContextMixin(securityContext) = __specMixin({ securityContext+: securityContext }),
                mixinInstance(securityContext):: __securityContextMixin(securityContext),
                // A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
                //
                // 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
                //
                // If unset, the Kubelet will not modify the ownership and permissions of any volume.
                withFsGroup(fsGroup):: self + __securityContextMixin({ fsGroup: fsGroup }),
                // The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                withRunAsGroup(runAsGroup):: self + __securityContextMixin({ runAsGroup: runAsGroup }),
                // Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                withRunAsNonRoot(runAsNonRoot):: self + __securityContextMixin({ runAsNonRoot: runAsNonRoot }),
                // The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                withRunAsUser(runAsUser):: self + __securityContextMixin({ runAsUser: runAsUser }),
                // The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                seLinuxOptions:: {
                  local __seLinuxOptionsMixin(seLinuxOptions) = __securityContextMixin({ seLinuxOptions+: seLinuxOptions }),
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
                // A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
                withSupplementalGroups(supplementalGroups):: self + if std.type(supplementalGroups) == 'array' then __securityContextMixin({ supplementalGroups: supplementalGroups }) else __securityContextMixin({ supplementalGroups: [supplementalGroups] }),
                // A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
                withSupplementalGroupsMixin(supplementalGroups):: self + if std.type(supplementalGroups) == 'array' then __securityContextMixin({ supplementalGroups+: supplementalGroups }) else __securityContextMixin({ supplementalGroups+: [supplementalGroups] }),
                // Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
                withSysctls(sysctls):: self + if std.type(sysctls) == 'array' then __securityContextMixin({ sysctls: sysctls }) else __securityContextMixin({ sysctls: [sysctls] }),
                // Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
                withSysctlsMixin(sysctls):: self + if std.type(sysctls) == 'array' then __securityContextMixin({ sysctls+: sysctls }) else __securityContextMixin({ sysctls+: [sysctls] }),
                sysctlsType:: hidden.core.v1.sysctl,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. This field is beta-level and may be disabled with the PodShareProcessNamespace feature.
              withShareProcessNamespace(shareProcessNamespace):: self + __specMixin({ shareProcessNamespace: shareProcessNamespace }),
              // If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.
              withSubdomain(subdomain):: self + __specMixin({ subdomain: subdomain }),
              // Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
              withTerminationGracePeriodSeconds(terminationGracePeriodSeconds):: self + __specMixin({ terminationGracePeriodSeconds: terminationGracePeriodSeconds }),
              // If specified, the pod's tolerations.
              withTolerations(tolerations):: self + if std.type(tolerations) == 'array' then __specMixin({ tolerations: tolerations }) else __specMixin({ tolerations: [tolerations] }),
              // If specified, the pod's tolerations.
              withTolerationsMixin(tolerations):: self + if std.type(tolerations) == 'array' then __specMixin({ tolerations+: tolerations }) else __specMixin({ tolerations+: [tolerations] }),
              tolerationsType:: hidden.core.v1.toleration,
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
              volumesType:: hidden.core.v1.volume,
            },
            specType:: hidden.core.v1.podSpec,
          },
          templateType:: hidden.core.v1.podTemplateSpec,
          // DEPRECATED. A sequence number representing a specific generation of the template. Populated by the system. It can be set only during the creation.
          withTemplateGeneration(templateGeneration):: self + __specMixin({ templateGeneration: templateGeneration }),
          // An update strategy to replace existing DaemonSet pods with new pods.
          updateStrategy:: {
            local __updateStrategyMixin(updateStrategy) = __specMixin({ updateStrategy+: updateStrategy }),
            mixinInstance(updateStrategy):: __updateStrategyMixin(updateStrategy),
            // Rolling update config params. Present only if type = "RollingUpdate".
            rollingUpdate:: {
              local __rollingUpdateMixin(rollingUpdate) = __updateStrategyMixin({ rollingUpdate+: rollingUpdate }),
              mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
              // The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0. Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
              withMaxUnavailable(maxUnavailable):: self + __rollingUpdateMixin({ maxUnavailable: maxUnavailable }),
            },
            rollingUpdateType:: hidden.extensions.v1beta1.rollingUpdateDaemonSet,
            // Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is OnDelete.
            withType(type):: self + __updateStrategyMixin({ type: type }),
          },
          updateStrategyType:: hidden.extensions.v1beta1.daemonSetUpdateStrategy,
        },
        specType:: hidden.extensions.v1beta1.daemonSetSpec,
      },
    },
    // DEPRECATED - This group version of Deployment is deprecated by apps/v1beta2/Deployment. See the release notes for more information. Deployment enables declarative updates for Pods and ReplicaSets.
    deployment:: {
      local kind = { kind: 'Deployment' },
      new(name='', replicas=1, containers='', podLabels={ app: 'name' }):: apiVersion + kind + self.mixin.metadata.withName(name) + self.mixin.spec.withReplicas(replicas) + self.mixin.spec.template.metadata.withLabels(podLabels) + self.mixin.spec.template.spec.withContainers(containers),
      mixin:: {
        // Standard object metadata.
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
        // Specification of the desired behavior of the Deployment.
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
          withMinReadySeconds(minReadySeconds):: self + __specMixin({ minReadySeconds: minReadySeconds }),
          // Indicates that the deployment is paused and will not be processed by the deployment controller.
          withPaused(paused):: self + __specMixin({ paused: paused }),
          // The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. This is set to the max value of int32 (i.e. 2147483647) by default, which means "no deadline".
          withProgressDeadlineSeconds(progressDeadlineSeconds):: self + __specMixin({ progressDeadlineSeconds: progressDeadlineSeconds }),
          // Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
          withReplicas(replicas):: self + __specMixin({ replicas: replicas }),
          // The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. This is set to the max value of int32 (i.e. 2147483647) by default, which means "retaining all old RelicaSets".
          withRevisionHistoryLimit(revisionHistoryLimit):: self + __specMixin({ revisionHistoryLimit: revisionHistoryLimit }),
          // DEPRECATED. The config this deployment is rolling back to. Will be cleared after rollback is done.
          rollbackTo:: {
            local __rollbackToMixin(rollbackTo) = __specMixin({ rollbackTo+: rollbackTo }),
            mixinInstance(rollbackTo):: __rollbackToMixin(rollbackTo),
            // The revision to rollback to. If set to 0, rollback to the last revision.
            withRevision(revision):: self + __rollbackToMixin({ revision: revision }),
          },
          rollbackToType:: hidden.extensions.v1beta1.rollbackConfig,
          // Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment.
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
          // The deployment strategy to use to replace existing pods with new ones.
          strategy:: {
            local __strategyMixin(strategy) = __specMixin({ strategy+: strategy }),
            mixinInstance(strategy):: __strategyMixin(strategy),
            // Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.
            rollingUpdate:: {
              local __rollingUpdateMixin(rollingUpdate) = __strategyMixin({ rollingUpdate+: rollingUpdate }),
              mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
              // The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. By default, a value of 1 is used. Example: when this is set to 30%, the new RC can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new RC can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods.
              withMaxSurge(maxSurge):: self + __rollingUpdateMixin({ maxSurge: maxSurge }),
              // The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. By default, a fixed value of 1 is used. Example: when this is set to 30%, the old RC can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old RC can be scaled down further, followed by scaling up the new RC, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods.
              withMaxUnavailable(maxUnavailable):: self + __rollingUpdateMixin({ maxUnavailable: maxUnavailable }),
            },
            rollingUpdateType:: hidden.extensions.v1beta1.rollingUpdateDeployment,
            // Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
            withType(type):: self + __strategyMixin({ type: type }),
          },
          strategyType:: hidden.extensions.v1beta1.deploymentStrategy,
          // Template describes the pods that will be created.
          template:: {
            local __templateMixin(template) = __specMixin({ template+: template }),
            mixinInstance(template):: __templateMixin(template),
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
            spec:: {
              local __specMixin(spec) = __templateMixin({ spec+: spec }),
              mixinInstance(spec):: __specMixin(spec),
              // Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.
              withActiveDeadlineSeconds(activeDeadlineSeconds):: self + __specMixin({ activeDeadlineSeconds: activeDeadlineSeconds }),
              // If specified, the pod's scheduling constraints
              affinity:: {
                local __affinityMixin(affinity) = __specMixin({ affinity+: affinity }),
                mixinInstance(affinity):: __affinityMixin(affinity),
                // Describes node affinity scheduling rules for the pod.
                nodeAffinity:: {
                  local __nodeAffinityMixin(nodeAffinity) = __affinityMixin({ nodeAffinity+: nodeAffinity }),
                  mixinInstance(nodeAffinity):: __nodeAffinityMixin(nodeAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.preferredSchedulingTerm,
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
                  requiredDuringSchedulingIgnoredDuringExecution:: {
                    local __requiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution) = __nodeAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }),
                    mixinInstance(requiredDuringSchedulingIgnoredDuringExecution):: __requiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution),
                    // Required. A list of node selector terms. The terms are ORed.
                    withNodeSelectorTerms(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms: nodeSelectorTerms }) else __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms: [nodeSelectorTerms] }),
                    // Required. A list of node selector terms. The terms are ORed.
                    withNodeSelectorTermsMixin(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms+: nodeSelectorTerms }) else __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms+: [nodeSelectorTerms] }),
                    nodeSelectorTermsType:: hidden.core.v1.nodeSelectorTerm,
                  },
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.nodeSelector,
                },
                nodeAffinityType:: hidden.core.v1.nodeAffinity,
                // Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
                podAffinity:: {
                  local __podAffinityMixin(podAffinity) = __affinityMixin({ podAffinity+: podAffinity }),
                  mixinInstance(podAffinity):: __podAffinityMixin(podAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.weightedPodAffinityTerm,
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecution(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: requiredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.podAffinityTerm,
                },
                podAffinityType:: hidden.core.v1.podAffinity,
                // Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
                podAntiAffinity:: {
                  local __podAntiAffinityMixin(podAntiAffinity) = __affinityMixin({ podAntiAffinity+: podAntiAffinity }),
                  mixinInstance(podAntiAffinity):: __podAntiAffinityMixin(podAntiAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.weightedPodAffinityTerm,
                  // If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecution(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: requiredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  // If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.podAffinityTerm,
                },
                podAntiAffinityType:: hidden.core.v1.podAntiAffinity,
              },
              affinityType:: hidden.core.v1.affinity,
              // AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
              withAutomountServiceAccountToken(automountServiceAccountToken):: self + __specMixin({ automountServiceAccountToken: automountServiceAccountToken }),
              // List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
              withContainers(containers):: self + if std.type(containers) == 'array' then __specMixin({ containers: containers }) else __specMixin({ containers: [containers] }),
              // List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
              withContainersMixin(containers):: self + if std.type(containers) == 'array' then __specMixin({ containers+: containers }) else __specMixin({ containers+: [containers] }),
              containersType:: hidden.core.v1.container,
              // Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.
              dnsConfig:: {
                local __dnsConfigMixin(dnsConfig) = __specMixin({ dnsConfig+: dnsConfig }),
                mixinInstance(dnsConfig):: __dnsConfigMixin(dnsConfig),
                // A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
                withNameservers(nameservers):: self + if std.type(nameservers) == 'array' then __dnsConfigMixin({ nameservers: nameservers }) else __dnsConfigMixin({ nameservers: [nameservers] }),
                // A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
                withNameserversMixin(nameservers):: self + if std.type(nameservers) == 'array' then __dnsConfigMixin({ nameservers+: nameservers }) else __dnsConfigMixin({ nameservers+: [nameservers] }),
                // A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
                withOptions(options):: self + if std.type(options) == 'array' then __dnsConfigMixin({ options: options }) else __dnsConfigMixin({ options: [options] }),
                // A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
                withOptionsMixin(options):: self + if std.type(options) == 'array' then __dnsConfigMixin({ options+: options }) else __dnsConfigMixin({ options+: [options] }),
                optionsType:: hidden.core.v1.podDnsConfigOption,
                // A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
                withSearches(searches):: self + if std.type(searches) == 'array' then __dnsConfigMixin({ searches: searches }) else __dnsConfigMixin({ searches: [searches] }),
                // A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
                withSearchesMixin(searches):: self + if std.type(searches) == 'array' then __dnsConfigMixin({ searches+: searches }) else __dnsConfigMixin({ searches+: [searches] }),
              },
              dnsConfigType:: hidden.core.v1.podDnsConfig,
              // Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.
              withDnsPolicy(dnsPolicy):: self + __specMixin({ dnsPolicy: dnsPolicy }),
              // EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true.
              withEnableServiceLinks(enableServiceLinks):: self + __specMixin({ enableServiceLinks: enableServiceLinks }),
              // HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
              withHostAliases(hostAliases):: self + if std.type(hostAliases) == 'array' then __specMixin({ hostAliases: hostAliases }) else __specMixin({ hostAliases: [hostAliases] }),
              // HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
              withHostAliasesMixin(hostAliases):: self + if std.type(hostAliases) == 'array' then __specMixin({ hostAliases+: hostAliases }) else __specMixin({ hostAliases+: [hostAliases] }),
              hostAliasesType:: hidden.core.v1.hostAlias,
              // Use the host's ipc namespace. Optional: Default to false.
              withHostIpc(hostIpc):: self + __specMixin({ hostIPC: hostIpc }),
              // Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false.
              withHostNetwork(hostNetwork):: self + __specMixin({ hostNetwork: hostNetwork }),
              // Use the host's pid namespace. Optional: Default to false.
              withHostPid(hostPid):: self + __specMixin({ hostPID: hostPid }),
              // Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.
              withHostname(hostname):: self + __specMixin({ hostname: hostname }),
              // ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
              withImagePullSecrets(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then __specMixin({ imagePullSecrets: imagePullSecrets }) else __specMixin({ imagePullSecrets: [imagePullSecrets] }),
              // ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
              withImagePullSecretsMixin(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then __specMixin({ imagePullSecrets+: imagePullSecrets }) else __specMixin({ imagePullSecrets+: [imagePullSecrets] }),
              imagePullSecretsType:: hidden.core.v1.localObjectReference,
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.
              withPriority(priority):: self + __specMixin({ priority: priority }),
              // If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.
              withPriorityClassName(priorityClassName):: self + __specMixin({ priorityClassName: priorityClassName }),
              // If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/0007-pod-ready%2B%2B.md
              withReadinessGates(readinessGates):: self + if std.type(readinessGates) == 'array' then __specMixin({ readinessGates: readinessGates }) else __specMixin({ readinessGates: [readinessGates] }),
              // If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/0007-pod-ready%2B%2B.md
              withReadinessGatesMixin(readinessGates):: self + if std.type(readinessGates) == 'array' then __specMixin({ readinessGates+: readinessGates }) else __specMixin({ readinessGates+: [readinessGates] }),
              readinessGatesType:: hidden.core.v1.podReadinessGate,
              // Restart policy for all containers within the pod. One of Always, OnFailure, Never. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
              withRestartPolicy(restartPolicy):: self + __specMixin({ restartPolicy: restartPolicy }),
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is an alpha feature and may change in the future.
              withRuntimeClassName(runtimeClassName):: self + __specMixin({ runtimeClassName: runtimeClassName }),
              // If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.
              withSchedulerName(schedulerName):: self + __specMixin({ schedulerName: schedulerName }),
              // SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.
              securityContext:: {
                local __securityContextMixin(securityContext) = __specMixin({ securityContext+: securityContext }),
                mixinInstance(securityContext):: __securityContextMixin(securityContext),
                // A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
                //
                // 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
                //
                // If unset, the Kubelet will not modify the ownership and permissions of any volume.
                withFsGroup(fsGroup):: self + __securityContextMixin({ fsGroup: fsGroup }),
                // The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                withRunAsGroup(runAsGroup):: self + __securityContextMixin({ runAsGroup: runAsGroup }),
                // Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                withRunAsNonRoot(runAsNonRoot):: self + __securityContextMixin({ runAsNonRoot: runAsNonRoot }),
                // The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                withRunAsUser(runAsUser):: self + __securityContextMixin({ runAsUser: runAsUser }),
                // The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                seLinuxOptions:: {
                  local __seLinuxOptionsMixin(seLinuxOptions) = __securityContextMixin({ seLinuxOptions+: seLinuxOptions }),
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
                // A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
                withSupplementalGroups(supplementalGroups):: self + if std.type(supplementalGroups) == 'array' then __securityContextMixin({ supplementalGroups: supplementalGroups }) else __securityContextMixin({ supplementalGroups: [supplementalGroups] }),
                // A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
                withSupplementalGroupsMixin(supplementalGroups):: self + if std.type(supplementalGroups) == 'array' then __securityContextMixin({ supplementalGroups+: supplementalGroups }) else __securityContextMixin({ supplementalGroups+: [supplementalGroups] }),
                // Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
                withSysctls(sysctls):: self + if std.type(sysctls) == 'array' then __securityContextMixin({ sysctls: sysctls }) else __securityContextMixin({ sysctls: [sysctls] }),
                // Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
                withSysctlsMixin(sysctls):: self + if std.type(sysctls) == 'array' then __securityContextMixin({ sysctls+: sysctls }) else __securityContextMixin({ sysctls+: [sysctls] }),
                sysctlsType:: hidden.core.v1.sysctl,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. This field is beta-level and may be disabled with the PodShareProcessNamespace feature.
              withShareProcessNamespace(shareProcessNamespace):: self + __specMixin({ shareProcessNamespace: shareProcessNamespace }),
              // If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.
              withSubdomain(subdomain):: self + __specMixin({ subdomain: subdomain }),
              // Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
              withTerminationGracePeriodSeconds(terminationGracePeriodSeconds):: self + __specMixin({ terminationGracePeriodSeconds: terminationGracePeriodSeconds }),
              // If specified, the pod's tolerations.
              withTolerations(tolerations):: self + if std.type(tolerations) == 'array' then __specMixin({ tolerations: tolerations }) else __specMixin({ tolerations: [tolerations] }),
              // If specified, the pod's tolerations.
              withTolerationsMixin(tolerations):: self + if std.type(tolerations) == 'array' then __specMixin({ tolerations+: tolerations }) else __specMixin({ tolerations+: [tolerations] }),
              tolerationsType:: hidden.core.v1.toleration,
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
              volumesType:: hidden.core.v1.volume,
            },
            specType:: hidden.core.v1.podSpec,
          },
          templateType:: hidden.core.v1.podTemplateSpec,
        },
        specType:: hidden.extensions.v1beta1.deploymentSpec,
      },
    },
    // DEPRECATED. DeploymentRollback stores the information required to rollback a deployment.
    deploymentRollback:: {
      local kind = { kind: 'DeploymentRollback' },
      new(name=''):: apiVersion + kind + self.withName(name),
      // Required: This must match the Name of a deployment.
      withName(name):: self + { name: name },
      // The annotations to be updated to a deployment
      withUpdatedAnnotations(updatedAnnotations):: self + { updatedAnnotations: updatedAnnotations },
      // The annotations to be updated to a deployment
      withUpdatedAnnotationsMixin(updatedAnnotations):: self + { updatedAnnotations+: updatedAnnotations },
      mixin:: {
        // The config of this deployment rollback.
        rollbackTo:: {
          local __rollbackToMixin(rollbackTo) = { rollbackTo+: rollbackTo },
          mixinInstance(rollbackTo):: __rollbackToMixin(rollbackTo),
          // The revision to rollback to. If set to 0, rollback to the last revision.
          withRevision(revision):: self + __rollbackToMixin({ revision: revision }),
        },
        rollbackToType:: hidden.extensions.v1beta1.rollbackConfig,
      },
    },
    // Ingress is a collection of rules that allow inbound connections to reach the endpoints defined by a backend. An Ingress can be configured to give services externally-reachable urls, load balance traffic, terminate SSL, offer name based virtual hosting etc. DEPRECATED - This group version of Ingress is deprecated by networking.k8s.io/v1beta1 Ingress. See the release notes for more information.
    ingress:: {
      local kind = { kind: 'Ingress' },
      new():: apiVersion + kind,
      mixin:: {
        // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
        // Spec is the desired state of the Ingress. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // A default backend capable of servicing requests that don't match any rule. At least one of 'backend' or 'rules' must be specified. This field is optional to allow the loadbalancer controller or defaulting logic to specify a global default.
          backend:: {
            local __backendMixin(backend) = __specMixin({ backend+: backend }),
            mixinInstance(backend):: __backendMixin(backend),
            // Specifies the name of the referenced service.
            withServiceName(serviceName):: self + __backendMixin({ serviceName: serviceName }),
            // Specifies the port of the referenced service.
            withServicePort(servicePort):: self + __backendMixin({ servicePort: servicePort }),
          },
          backendType:: hidden.extensions.v1beta1.ingressBackend,
          // A list of host rules used to configure the Ingress. If unspecified, or no rule matches, all traffic is sent to the default backend.
          withRules(rules):: self + if std.type(rules) == 'array' then __specMixin({ rules: rules }) else __specMixin({ rules: [rules] }),
          // A list of host rules used to configure the Ingress. If unspecified, or no rule matches, all traffic is sent to the default backend.
          withRulesMixin(rules):: self + if std.type(rules) == 'array' then __specMixin({ rules+: rules }) else __specMixin({ rules+: [rules] }),
          rulesType:: hidden.extensions.v1beta1.ingressRule,
          // TLS configuration. Currently the Ingress only supports a single TLS port, 443. If multiple members of this list specify different hosts, they will be multiplexed on the same port according to the hostname specified through the SNI TLS extension, if the ingress controller fulfilling the ingress supports SNI.
          withTls(tls):: self + if std.type(tls) == 'array' then __specMixin({ tls: tls }) else __specMixin({ tls: [tls] }),
          // TLS configuration. Currently the Ingress only supports a single TLS port, 443. If multiple members of this list specify different hosts, they will be multiplexed on the same port according to the hostname specified through the SNI TLS extension, if the ingress controller fulfilling the ingress supports SNI.
          withTlsMixin(tls):: self + if std.type(tls) == 'array' then __specMixin({ tls+: tls }) else __specMixin({ tls+: [tls] }),
          tlsType:: hidden.extensions.v1beta1.ingressTls,
        },
        specType:: hidden.extensions.v1beta1.ingressSpec,
      },
    },
    // DEPRECATED 1.9 - This group version of NetworkPolicy is deprecated by networking/v1/NetworkPolicy. NetworkPolicy describes what network traffic is allowed for a set of Pods
    networkPolicy:: {
      local kind = { kind: 'NetworkPolicy' },
      new():: apiVersion + kind,
      mixin:: {
        // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
        // Specification of the desired behavior for this NetworkPolicy.
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // List of egress rules to be applied to the selected pods. Outgoing traffic is allowed if there are no NetworkPolicies selecting the pod (and cluster policy otherwise allows the traffic), OR if the traffic matches at least one egress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy limits all outgoing traffic (and serves solely to ensure that the pods it selects are isolated by default). This field is beta-level in 1.8
          withEgress(egress):: self + if std.type(egress) == 'array' then __specMixin({ egress: egress }) else __specMixin({ egress: [egress] }),
          // List of egress rules to be applied to the selected pods. Outgoing traffic is allowed if there are no NetworkPolicies selecting the pod (and cluster policy otherwise allows the traffic), OR if the traffic matches at least one egress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy limits all outgoing traffic (and serves solely to ensure that the pods it selects are isolated by default). This field is beta-level in 1.8
          withEgressMixin(egress):: self + if std.type(egress) == 'array' then __specMixin({ egress+: egress }) else __specMixin({ egress+: [egress] }),
          egressType:: hidden.extensions.v1beta1.networkPolicyEgressRule,
          // List of ingress rules to be applied to the selected pods. Traffic is allowed to a pod if there are no NetworkPolicies selecting the pod OR if the traffic source is the pod's local node, OR if the traffic matches at least one ingress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy does not allow any traffic (and serves solely to ensure that the pods it selects are isolated by default).
          withIngress(ingress):: self + if std.type(ingress) == 'array' then __specMixin({ ingress: ingress }) else __specMixin({ ingress: [ingress] }),
          // List of ingress rules to be applied to the selected pods. Traffic is allowed to a pod if there are no NetworkPolicies selecting the pod OR if the traffic source is the pod's local node, OR if the traffic matches at least one ingress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy does not allow any traffic (and serves solely to ensure that the pods it selects are isolated by default).
          withIngressMixin(ingress):: self + if std.type(ingress) == 'array' then __specMixin({ ingress+: ingress }) else __specMixin({ ingress+: [ingress] }),
          ingressType:: hidden.extensions.v1beta1.networkPolicyIngressRule,
          // Selects the pods to which this NetworkPolicy object applies.  The array of ingress rules is applied to any pods selected by this field. Multiple network policies can select the same set of pods.  In this case, the ingress rules for each are combined additively. This field is NOT optional and follows standard label selector semantics. An empty podSelector matches all pods in this namespace.
          podSelector:: {
            local __podSelectorMixin(podSelector) = __specMixin({ podSelector+: podSelector }),
            mixinInstance(podSelector):: __podSelectorMixin(podSelector),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __podSelectorMixin({ matchExpressions: matchExpressions }) else __podSelectorMixin({ matchExpressions: [matchExpressions] }),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __podSelectorMixin({ matchExpressions+: matchExpressions }) else __podSelectorMixin({ matchExpressions+: [matchExpressions] }),
            matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabels(matchLabels):: self + __podSelectorMixin({ matchLabels: matchLabels }),
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabelsMixin(matchLabels):: self + __podSelectorMixin({ matchLabels+: matchLabels }),
          },
          podSelectorType:: hidden.meta.v1.labelSelector,
          // List of rule types that the NetworkPolicy relates to. Valid options are "Ingress", "Egress", or "Ingress,Egress". If this field is not specified, it will default based on the existence of Ingress or Egress rules; policies that contain an Egress section are assumed to affect Egress, and all policies (whether or not they contain an Ingress section) are assumed to affect Ingress. If you want to write an egress-only policy, you must explicitly specify policyTypes [ "Egress" ]. Likewise, if you want to write a policy that specifies that no egress is allowed, you must specify a policyTypes value that include "Egress" (since such a policy would not include an Egress section and would otherwise default to just [ "Ingress" ]). This field is beta-level in 1.8
          withPolicyTypes(policyTypes):: self + if std.type(policyTypes) == 'array' then __specMixin({ policyTypes: policyTypes }) else __specMixin({ policyTypes: [policyTypes] }),
          // List of rule types that the NetworkPolicy relates to. Valid options are "Ingress", "Egress", or "Ingress,Egress". If this field is not specified, it will default based on the existence of Ingress or Egress rules; policies that contain an Egress section are assumed to affect Egress, and all policies (whether or not they contain an Ingress section) are assumed to affect Ingress. If you want to write an egress-only policy, you must explicitly specify policyTypes [ "Egress" ]. Likewise, if you want to write a policy that specifies that no egress is allowed, you must specify a policyTypes value that include "Egress" (since such a policy would not include an Egress section and would otherwise default to just [ "Ingress" ]). This field is beta-level in 1.8
          withPolicyTypesMixin(policyTypes):: self + if std.type(policyTypes) == 'array' then __specMixin({ policyTypes+: policyTypes }) else __specMixin({ policyTypes+: [policyTypes] }),
        },
        specType:: hidden.extensions.v1beta1.networkPolicySpec,
      },
    },
    // PodSecurityPolicy governs the ability to make requests that affect the Security Context that will be applied to a pod and container. Deprecated: use PodSecurityPolicy from policy API Group instead.
    podSecurityPolicy:: {
      local kind = { kind: 'PodSecurityPolicy' },
      new():: apiVersion + kind,
      mixin:: {
        // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          allowedCSIDriversType:: hidden.extensions.v1beta1.allowedCsiDriver,
          // allowedCapabilities is a list of capabilities that can be requested to add to the container. Capabilities in this field may be added at the pod author's discretion. You must not list a capability in both allowedCapabilities and requiredDropCapabilities.
          withAllowedCapabilities(allowedCapabilities):: self + if std.type(allowedCapabilities) == 'array' then __specMixin({ allowedCapabilities: allowedCapabilities }) else __specMixin({ allowedCapabilities: [allowedCapabilities] }),
          // allowedCapabilities is a list of capabilities that can be requested to add to the container. Capabilities in this field may be added at the pod author's discretion. You must not list a capability in both allowedCapabilities and requiredDropCapabilities.
          withAllowedCapabilitiesMixin(allowedCapabilities):: self + if std.type(allowedCapabilities) == 'array' then __specMixin({ allowedCapabilities+: allowedCapabilities }) else __specMixin({ allowedCapabilities+: [allowedCapabilities] }),
          // allowedFlexVolumes is a whitelist of allowed Flexvolumes.  Empty or nil indicates that all Flexvolumes may be used.  This parameter is effective only when the usage of the Flexvolumes is allowed in the "volumes" field.
          withAllowedFlexVolumes(allowedFlexVolumes):: self + if std.type(allowedFlexVolumes) == 'array' then __specMixin({ allowedFlexVolumes: allowedFlexVolumes }) else __specMixin({ allowedFlexVolumes: [allowedFlexVolumes] }),
          // allowedFlexVolumes is a whitelist of allowed Flexvolumes.  Empty or nil indicates that all Flexvolumes may be used.  This parameter is effective only when the usage of the Flexvolumes is allowed in the "volumes" field.
          withAllowedFlexVolumesMixin(allowedFlexVolumes):: self + if std.type(allowedFlexVolumes) == 'array' then __specMixin({ allowedFlexVolumes+: allowedFlexVolumes }) else __specMixin({ allowedFlexVolumes+: [allowedFlexVolumes] }),
          allowedFlexVolumesType:: hidden.extensions.v1beta1.allowedFlexVolume,
          // allowedHostPaths is a white list of allowed host paths. Empty indicates that all host paths may be used.
          withAllowedHostPaths(allowedHostPaths):: self + if std.type(allowedHostPaths) == 'array' then __specMixin({ allowedHostPaths: allowedHostPaths }) else __specMixin({ allowedHostPaths: [allowedHostPaths] }),
          // allowedHostPaths is a white list of allowed host paths. Empty indicates that all host paths may be used.
          withAllowedHostPathsMixin(allowedHostPaths):: self + if std.type(allowedHostPaths) == 'array' then __specMixin({ allowedHostPaths+: allowedHostPaths }) else __specMixin({ allowedHostPaths+: [allowedHostPaths] }),
          allowedHostPathsType:: hidden.extensions.v1beta1.allowedHostPath,
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
            rangesType:: hidden.extensions.v1beta1.idRange,
            // rule is the strategy that will dictate what FSGroup is used in the SecurityContext.
            withRule(rule):: self + __fsGroupMixin({ rule: rule }),
          },
          fsGroupType:: hidden.extensions.v1beta1.fsGroupStrategyOptions,
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
          hostPortsType:: hidden.extensions.v1beta1.hostPortRange,
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
            rangesType:: hidden.extensions.v1beta1.idRange,
            // rule is the strategy that will dictate the allowable RunAsGroup values that may be set.
            withRule(rule):: self + __runAsGroupMixin({ rule: rule }),
          },
          runAsGroupType:: hidden.extensions.v1beta1.runAsGroupStrategyOptions,
          // runAsUser is the strategy that will dictate the allowable RunAsUser values that may be set.
          runAsUser:: {
            local __runAsUserMixin(runAsUser) = __specMixin({ runAsUser+: runAsUser }),
            mixinInstance(runAsUser):: __runAsUserMixin(runAsUser),
            // ranges are the allowed ranges of uids that may be used. If you would like to force a single uid then supply a single range with the same start and end. Required for MustRunAs.
            withRanges(ranges):: self + if std.type(ranges) == 'array' then __runAsUserMixin({ ranges: ranges }) else __runAsUserMixin({ ranges: [ranges] }),
            // ranges are the allowed ranges of uids that may be used. If you would like to force a single uid then supply a single range with the same start and end. Required for MustRunAs.
            withRangesMixin(ranges):: self + if std.type(ranges) == 'array' then __runAsUserMixin({ ranges+: ranges }) else __runAsUserMixin({ ranges+: [ranges] }),
            rangesType:: hidden.extensions.v1beta1.idRange,
            // rule is the strategy that will dictate the allowable RunAsUser values that may be set.
            withRule(rule):: self + __runAsUserMixin({ rule: rule }),
          },
          runAsUserType:: hidden.extensions.v1beta1.runAsUserStrategyOptions,
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
          seLinuxType:: hidden.extensions.v1beta1.seLinuxStrategyOptions,
          // supplementalGroups is the strategy that will dictate what supplemental groups are used by the SecurityContext.
          supplementalGroups:: {
            local __supplementalGroupsMixin(supplementalGroups) = __specMixin({ supplementalGroups+: supplementalGroups }),
            mixinInstance(supplementalGroups):: __supplementalGroupsMixin(supplementalGroups),
            // ranges are the allowed ranges of supplemental groups.  If you would like to force a single supplemental group then supply a single range with the same start and end. Required for MustRunAs.
            withRanges(ranges):: self + if std.type(ranges) == 'array' then __supplementalGroupsMixin({ ranges: ranges }) else __supplementalGroupsMixin({ ranges: [ranges] }),
            // ranges are the allowed ranges of supplemental groups.  If you would like to force a single supplemental group then supply a single range with the same start and end. Required for MustRunAs.
            withRangesMixin(ranges):: self + if std.type(ranges) == 'array' then __supplementalGroupsMixin({ ranges+: ranges }) else __supplementalGroupsMixin({ ranges+: [ranges] }),
            rangesType:: hidden.extensions.v1beta1.idRange,
            // rule is the strategy that will dictate what supplemental groups is used in the SecurityContext.
            withRule(rule):: self + __supplementalGroupsMixin({ rule: rule }),
          },
          supplementalGroupsType:: hidden.extensions.v1beta1.supplementalGroupsStrategyOptions,
          // volumes is a white list of allowed volume plugins. Empty indicates that no volumes may be used. To allow all volumes you may use '*'.
          withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
          // volumes is a white list of allowed volume plugins. Empty indicates that no volumes may be used. To allow all volumes you may use '*'.
          withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
        },
        specType:: hidden.extensions.v1beta1.podSecurityPolicySpec,
      },
    },
    // DEPRECATED - This group version of ReplicaSet is deprecated by apps/v1beta2/ReplicaSet. See the release notes for more information. ReplicaSet ensures that a specified number of pod replicas are running at any given time.
    replicaSet:: {
      local kind = { kind: 'ReplicaSet' },
      new():: apiVersion + kind,
      mixin:: {
        // If the Labels of a ReplicaSet are empty, they are defaulted to be the same as the Pod(s) that the ReplicaSet manages. Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
        // Spec defines the specification of the desired behavior of the ReplicaSet. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
          withMinReadySeconds(minReadySeconds):: self + __specMixin({ minReadySeconds: minReadySeconds }),
          // Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller
          withReplicas(replicas):: self + __specMixin({ replicas: replicas }),
          // Selector is a label query over pods that should match the replica count. If the selector is empty, it is defaulted to the labels present on the pod template. Label keys and values that must match in order to be controlled by this replica set. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
          // Template is the object that describes the pod that will be created if insufficient replicas are detected. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
          template:: {
            local __templateMixin(template) = __specMixin({ template+: template }),
            mixinInstance(template):: __templateMixin(template),
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
            spec:: {
              local __specMixin(spec) = __templateMixin({ spec+: spec }),
              mixinInstance(spec):: __specMixin(spec),
              // Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.
              withActiveDeadlineSeconds(activeDeadlineSeconds):: self + __specMixin({ activeDeadlineSeconds: activeDeadlineSeconds }),
              // If specified, the pod's scheduling constraints
              affinity:: {
                local __affinityMixin(affinity) = __specMixin({ affinity+: affinity }),
                mixinInstance(affinity):: __affinityMixin(affinity),
                // Describes node affinity scheduling rules for the pod.
                nodeAffinity:: {
                  local __nodeAffinityMixin(nodeAffinity) = __affinityMixin({ nodeAffinity+: nodeAffinity }),
                  mixinInstance(nodeAffinity):: __nodeAffinityMixin(nodeAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __nodeAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.preferredSchedulingTerm,
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
                  requiredDuringSchedulingIgnoredDuringExecution:: {
                    local __requiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution) = __nodeAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }),
                    mixinInstance(requiredDuringSchedulingIgnoredDuringExecution):: __requiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution),
                    // Required. A list of node selector terms. The terms are ORed.
                    withNodeSelectorTerms(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms: nodeSelectorTerms }) else __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms: [nodeSelectorTerms] }),
                    // Required. A list of node selector terms. The terms are ORed.
                    withNodeSelectorTermsMixin(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms+: nodeSelectorTerms }) else __requiredDuringSchedulingIgnoredDuringExecutionMixin({ nodeSelectorTerms+: [nodeSelectorTerms] }),
                    nodeSelectorTermsType:: hidden.core.v1.nodeSelectorTerm,
                  },
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.nodeSelector,
                },
                nodeAffinityType:: hidden.core.v1.nodeAffinity,
                // Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
                podAffinity:: {
                  local __podAffinityMixin(podAffinity) = __affinityMixin({ podAffinity+: podAffinity }),
                  mixinInstance(podAffinity):: __podAffinityMixin(podAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.weightedPodAffinityTerm,
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecution(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: requiredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  // If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }) else __podAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.podAffinityTerm,
                },
                podAffinityType:: hidden.core.v1.podAffinity,
                // Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
                podAntiAffinity:: {
                  local __podAntiAffinityMixin(podAntiAffinity) = __affinityMixin({ podAntiAffinity+: podAntiAffinity }),
                  mixinInstance(podAntiAffinity):: __podAntiAffinityMixin(podAntiAffinity),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecution(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: preferredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  // The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
                  withPreferredDuringSchedulingIgnoredDuringExecutionMixin(preferredDuringSchedulingIgnoredDuringExecution):: self + if std.type(preferredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: preferredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ preferredDuringSchedulingIgnoredDuringExecution+: [preferredDuringSchedulingIgnoredDuringExecution] }),
                  preferredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.weightedPodAffinityTerm,
                  // If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecution(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: requiredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  // If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
                  withRequiredDuringSchedulingIgnoredDuringExecutionMixin(requiredDuringSchedulingIgnoredDuringExecution):: self + if std.type(requiredDuringSchedulingIgnoredDuringExecution) == 'array' then __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: requiredDuringSchedulingIgnoredDuringExecution }) else __podAntiAffinityMixin({ requiredDuringSchedulingIgnoredDuringExecution+: [requiredDuringSchedulingIgnoredDuringExecution] }),
                  requiredDuringSchedulingIgnoredDuringExecutionType:: hidden.core.v1.podAffinityTerm,
                },
                podAntiAffinityType:: hidden.core.v1.podAntiAffinity,
              },
              affinityType:: hidden.core.v1.affinity,
              // AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
              withAutomountServiceAccountToken(automountServiceAccountToken):: self + __specMixin({ automountServiceAccountToken: automountServiceAccountToken }),
              // List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
              withContainers(containers):: self + if std.type(containers) == 'array' then __specMixin({ containers: containers }) else __specMixin({ containers: [containers] }),
              // List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
              withContainersMixin(containers):: self + if std.type(containers) == 'array' then __specMixin({ containers+: containers }) else __specMixin({ containers+: [containers] }),
              containersType:: hidden.core.v1.container,
              // Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.
              dnsConfig:: {
                local __dnsConfigMixin(dnsConfig) = __specMixin({ dnsConfig+: dnsConfig }),
                mixinInstance(dnsConfig):: __dnsConfigMixin(dnsConfig),
                // A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
                withNameservers(nameservers):: self + if std.type(nameservers) == 'array' then __dnsConfigMixin({ nameservers: nameservers }) else __dnsConfigMixin({ nameservers: [nameservers] }),
                // A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
                withNameserversMixin(nameservers):: self + if std.type(nameservers) == 'array' then __dnsConfigMixin({ nameservers+: nameservers }) else __dnsConfigMixin({ nameservers+: [nameservers] }),
                // A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
                withOptions(options):: self + if std.type(options) == 'array' then __dnsConfigMixin({ options: options }) else __dnsConfigMixin({ options: [options] }),
                // A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
                withOptionsMixin(options):: self + if std.type(options) == 'array' then __dnsConfigMixin({ options+: options }) else __dnsConfigMixin({ options+: [options] }),
                optionsType:: hidden.core.v1.podDnsConfigOption,
                // A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
                withSearches(searches):: self + if std.type(searches) == 'array' then __dnsConfigMixin({ searches: searches }) else __dnsConfigMixin({ searches: [searches] }),
                // A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
                withSearchesMixin(searches):: self + if std.type(searches) == 'array' then __dnsConfigMixin({ searches+: searches }) else __dnsConfigMixin({ searches+: [searches] }),
              },
              dnsConfigType:: hidden.core.v1.podDnsConfig,
              // Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.
              withDnsPolicy(dnsPolicy):: self + __specMixin({ dnsPolicy: dnsPolicy }),
              // EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true.
              withEnableServiceLinks(enableServiceLinks):: self + __specMixin({ enableServiceLinks: enableServiceLinks }),
              // HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
              withHostAliases(hostAliases):: self + if std.type(hostAliases) == 'array' then __specMixin({ hostAliases: hostAliases }) else __specMixin({ hostAliases: [hostAliases] }),
              // HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
              withHostAliasesMixin(hostAliases):: self + if std.type(hostAliases) == 'array' then __specMixin({ hostAliases+: hostAliases }) else __specMixin({ hostAliases+: [hostAliases] }),
              hostAliasesType:: hidden.core.v1.hostAlias,
              // Use the host's ipc namespace. Optional: Default to false.
              withHostIpc(hostIpc):: self + __specMixin({ hostIPC: hostIpc }),
              // Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false.
              withHostNetwork(hostNetwork):: self + __specMixin({ hostNetwork: hostNetwork }),
              // Use the host's pid namespace. Optional: Default to false.
              withHostPid(hostPid):: self + __specMixin({ hostPID: hostPid }),
              // Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.
              withHostname(hostname):: self + __specMixin({ hostname: hostname }),
              // ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
              withImagePullSecrets(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then __specMixin({ imagePullSecrets: imagePullSecrets }) else __specMixin({ imagePullSecrets: [imagePullSecrets] }),
              // ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
              withImagePullSecretsMixin(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then __specMixin({ imagePullSecrets+: imagePullSecrets }) else __specMixin({ imagePullSecrets+: [imagePullSecrets] }),
              imagePullSecretsType:: hidden.core.v1.localObjectReference,
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.
              withPriority(priority):: self + __specMixin({ priority: priority }),
              // If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.
              withPriorityClassName(priorityClassName):: self + __specMixin({ priorityClassName: priorityClassName }),
              // If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/0007-pod-ready%2B%2B.md
              withReadinessGates(readinessGates):: self + if std.type(readinessGates) == 'array' then __specMixin({ readinessGates: readinessGates }) else __specMixin({ readinessGates: [readinessGates] }),
              // If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/0007-pod-ready%2B%2B.md
              withReadinessGatesMixin(readinessGates):: self + if std.type(readinessGates) == 'array' then __specMixin({ readinessGates+: readinessGates }) else __specMixin({ readinessGates+: [readinessGates] }),
              readinessGatesType:: hidden.core.v1.podReadinessGate,
              // Restart policy for all containers within the pod. One of Always, OnFailure, Never. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
              withRestartPolicy(restartPolicy):: self + __specMixin({ restartPolicy: restartPolicy }),
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is an alpha feature and may change in the future.
              withRuntimeClassName(runtimeClassName):: self + __specMixin({ runtimeClassName: runtimeClassName }),
              // If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.
              withSchedulerName(schedulerName):: self + __specMixin({ schedulerName: schedulerName }),
              // SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.
              securityContext:: {
                local __securityContextMixin(securityContext) = __specMixin({ securityContext+: securityContext }),
                mixinInstance(securityContext):: __securityContextMixin(securityContext),
                // A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
                //
                // 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
                //
                // If unset, the Kubelet will not modify the ownership and permissions of any volume.
                withFsGroup(fsGroup):: self + __securityContextMixin({ fsGroup: fsGroup }),
                // The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                withRunAsGroup(runAsGroup):: self + __securityContextMixin({ runAsGroup: runAsGroup }),
                // Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                withRunAsNonRoot(runAsNonRoot):: self + __securityContextMixin({ runAsNonRoot: runAsNonRoot }),
                // The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                withRunAsUser(runAsUser):: self + __securityContextMixin({ runAsUser: runAsUser }),
                // The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
                seLinuxOptions:: {
                  local __seLinuxOptionsMixin(seLinuxOptions) = __securityContextMixin({ seLinuxOptions+: seLinuxOptions }),
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
                // A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
                withSupplementalGroups(supplementalGroups):: self + if std.type(supplementalGroups) == 'array' then __securityContextMixin({ supplementalGroups: supplementalGroups }) else __securityContextMixin({ supplementalGroups: [supplementalGroups] }),
                // A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
                withSupplementalGroupsMixin(supplementalGroups):: self + if std.type(supplementalGroups) == 'array' then __securityContextMixin({ supplementalGroups+: supplementalGroups }) else __securityContextMixin({ supplementalGroups+: [supplementalGroups] }),
                // Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
                withSysctls(sysctls):: self + if std.type(sysctls) == 'array' then __securityContextMixin({ sysctls: sysctls }) else __securityContextMixin({ sysctls: [sysctls] }),
                // Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
                withSysctlsMixin(sysctls):: self + if std.type(sysctls) == 'array' then __securityContextMixin({ sysctls+: sysctls }) else __securityContextMixin({ sysctls+: [sysctls] }),
                sysctlsType:: hidden.core.v1.sysctl,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. This field is beta-level and may be disabled with the PodShareProcessNamespace feature.
              withShareProcessNamespace(shareProcessNamespace):: self + __specMixin({ shareProcessNamespace: shareProcessNamespace }),
              // If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.
              withSubdomain(subdomain):: self + __specMixin({ subdomain: subdomain }),
              // Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
              withTerminationGracePeriodSeconds(terminationGracePeriodSeconds):: self + __specMixin({ terminationGracePeriodSeconds: terminationGracePeriodSeconds }),
              // If specified, the pod's tolerations.
              withTolerations(tolerations):: self + if std.type(tolerations) == 'array' then __specMixin({ tolerations: tolerations }) else __specMixin({ tolerations: [tolerations] }),
              // If specified, the pod's tolerations.
              withTolerationsMixin(tolerations):: self + if std.type(tolerations) == 'array' then __specMixin({ tolerations+: tolerations }) else __specMixin({ tolerations+: [tolerations] }),
              tolerationsType:: hidden.core.v1.toleration,
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
              volumesType:: hidden.core.v1.volume,
            },
            specType:: hidden.core.v1.podSpec,
          },
          templateType:: hidden.core.v1.podTemplateSpec,
        },
        specType:: hidden.extensions.v1beta1.replicaSetSpec,
      },
    },
    // represents a scaling request for a resource.
    scale:: {
      local kind = { kind: 'Scale' },
      new(replicas=1):: apiVersion + kind + self.mixin.spec.withReplicas(replicas),
      mixin:: {
        // Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
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
        // defines the behavior of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // desired number of instances for the scaled object.
          withReplicas(replicas):: self + __specMixin({ replicas: replicas }),
        },
        specType:: hidden.extensions.v1beta1.scaleSpec,
      },
    },
  },
}