{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'apps/v1' },
    // ControllerRevision implements an immutable snapshot of state data. Clients are responsible for serializing and deserializing the objects that contain their internal state. Once a ControllerRevision has been successfully created, it can not be updated. The API Server will fail validation of all requests that attempt to mutate the Data field. ControllerRevisions may, however, be deleted. Note that, due to its use by both the DaemonSet and StatefulSet controllers for update and rollback, this object is beta. However, it may be subject to name and representation changes in future releases, and clients should not depend on its stability. It is primarily for internal use by controllers.
    controllerRevision:: {
      local kind = { kind: 'ControllerRevision' },
      new():: apiVersion + kind,
      // Revision indicates the revision of the state represented by Data.
      withRevision(revision):: self + { revision: revision },
      mixin:: {
        // Data is the serialized representation of the state.
        data:: {
          local __dataMixin(data) = { data+: data },
          mixinInstance(data):: __dataMixin(data),
        },
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
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
          // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
          //
          // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
          //
          // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
          withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabels(labels):: self + __metadataMixin({ labels: labels }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
    // DaemonSet represents the configuration of a daemon set.
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
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
          // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
          //
          // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
          //
          // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
          withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabels(labels):: self + __metadataMixin({ labels: labels }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
          // A label query over pods that are managed by the daemon set. Must match in order to be controlled. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
              mixinInstance(metadata):: __metadataMixin(metadata),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotations(annotations):: self + __metadataMixin({ annotations: annotations }),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotationsMixin(annotations):: self + __metadataMixin({ annotations+: annotations }),
              // The name of the cluster which the object belongs to. This is used to distinguish resources with same name and namespace in different clusters. This field is not set anywhere right now and apiserver is going to ignore it if set in create or update request.
              withClusterName(clusterName):: self + __metadataMixin({ clusterName: clusterName }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
              // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
              //
              // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
              //
              // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
              withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabels(labels):: self + __metadataMixin({ labels: labels }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
              withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
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
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainers(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers: ephemeralContainers }) else __specMixin({ ephemeralContainers: [ephemeralContainers] }),
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainersMixin(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers+: ephemeralContainers }) else __specMixin({ ephemeralContainers+: [ephemeralContainers] }),
              ephemeralContainersType:: hidden.core.v1.ephemeralContainer,
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
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverhead(overhead):: self + __specMixin({ overhead: overhead }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverheadMixin(overhead):: self + __specMixin({ overhead+: overhead }),
              // PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. This field is alpha-level and is only honored by servers that enable the NonPreemptingPriority feature.
              withPreemptionPolicy(preemptionPolicy):: self + __specMixin({ preemptionPolicy: preemptionPolicy }),
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
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is a beta feature as of Kubernetes v1.14.
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
                // fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are "OnRootMismatch" and "Always". If not specified defaults to "Always".
                withFsGroupChangePolicy(fsGroupChangePolicy):: self + __securityContextMixin({ fsGroupChangePolicy: fsGroupChangePolicy }),
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
                // The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                windowsOptions:: {
                  local __windowsOptionsMixin(windowsOptions) = __securityContextMixin({ windowsOptions+: windowsOptions }),
                  mixinInstance(windowsOptions):: __windowsOptionsMixin(windowsOptions),
                  // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.
                  withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                  // GMSACredentialSpecName is the name of the GMSA credential spec to use.
                  withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                  // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                  withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
                },
                windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.
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
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraintsMixin(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints+: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints+: [topologySpreadConstraints] }),
              topologySpreadConstraintsType:: hidden.core.v1.topologySpreadConstraint,
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
              volumesType:: hidden.core.v1.volume,
            },
            specType:: hidden.core.v1.podSpec,
          },
          templateType:: hidden.core.v1.podTemplateSpec,
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
            rollingUpdateType:: hidden.apps.v1.rollingUpdateDaemonSet,
            // Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.
            withType(type):: self + __updateStrategyMixin({ type: type }),
          },
          updateStrategyType:: hidden.apps.v1.daemonSetUpdateStrategy,
        },
        specType:: hidden.apps.v1.daemonSetSpec,
      },
    },
    // Deployment enables declarative updates for Pods and ReplicaSets.
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
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
          // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
          //
          // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
          //
          // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
          withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabels(labels):: self + __metadataMixin({ labels: labels }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
          // Indicates that the deployment is paused.
          withPaused(paused):: self + __specMixin({ paused: paused }),
          // The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s.
          withProgressDeadlineSeconds(progressDeadlineSeconds):: self + __specMixin({ progressDeadlineSeconds: progressDeadlineSeconds }),
          // Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
          withReplicas(replicas):: self + __specMixin({ replicas: replicas }),
          // The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
          withRevisionHistoryLimit(revisionHistoryLimit):: self + __specMixin({ revisionHistoryLimit: revisionHistoryLimit }),
          // Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels.
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
              // The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods.
              withMaxSurge(maxSurge):: self + __rollingUpdateMixin({ maxSurge: maxSurge }),
              // The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods.
              withMaxUnavailable(maxUnavailable):: self + __rollingUpdateMixin({ maxUnavailable: maxUnavailable }),
            },
            rollingUpdateType:: hidden.apps.v1.rollingUpdateDeployment,
            // Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
            withType(type):: self + __strategyMixin({ type: type }),
          },
          strategyType:: hidden.apps.v1.deploymentStrategy,
          // Template describes the pods that will be created.
          template:: {
            local __templateMixin(template) = __specMixin({ template+: template }),
            mixinInstance(template):: __templateMixin(template),
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
              mixinInstance(metadata):: __metadataMixin(metadata),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotations(annotations):: self + __metadataMixin({ annotations: annotations }),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotationsMixin(annotations):: self + __metadataMixin({ annotations+: annotations }),
              // The name of the cluster which the object belongs to. This is used to distinguish resources with same name and namespace in different clusters. This field is not set anywhere right now and apiserver is going to ignore it if set in create or update request.
              withClusterName(clusterName):: self + __metadataMixin({ clusterName: clusterName }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
              // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
              //
              // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
              //
              // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
              withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabels(labels):: self + __metadataMixin({ labels: labels }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
              withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
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
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainers(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers: ephemeralContainers }) else __specMixin({ ephemeralContainers: [ephemeralContainers] }),
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainersMixin(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers+: ephemeralContainers }) else __specMixin({ ephemeralContainers+: [ephemeralContainers] }),
              ephemeralContainersType:: hidden.core.v1.ephemeralContainer,
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
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverhead(overhead):: self + __specMixin({ overhead: overhead }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverheadMixin(overhead):: self + __specMixin({ overhead+: overhead }),
              // PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. This field is alpha-level and is only honored by servers that enable the NonPreemptingPriority feature.
              withPreemptionPolicy(preemptionPolicy):: self + __specMixin({ preemptionPolicy: preemptionPolicy }),
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
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is a beta feature as of Kubernetes v1.14.
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
                // fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are "OnRootMismatch" and "Always". If not specified defaults to "Always".
                withFsGroupChangePolicy(fsGroupChangePolicy):: self + __securityContextMixin({ fsGroupChangePolicy: fsGroupChangePolicy }),
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
                // The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                windowsOptions:: {
                  local __windowsOptionsMixin(windowsOptions) = __securityContextMixin({ windowsOptions+: windowsOptions }),
                  mixinInstance(windowsOptions):: __windowsOptionsMixin(windowsOptions),
                  // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.
                  withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                  // GMSACredentialSpecName is the name of the GMSA credential spec to use.
                  withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                  // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                  withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
                },
                windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.
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
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraintsMixin(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints+: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints+: [topologySpreadConstraints] }),
              topologySpreadConstraintsType:: hidden.core.v1.topologySpreadConstraint,
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
        specType:: hidden.apps.v1.deploymentSpec,
      },
    },
    // ReplicaSet ensures that a specified number of pod replicas are running at any given time.
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
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
          // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
          //
          // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
          //
          // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
          withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabels(labels):: self + __metadataMixin({ labels: labels }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
          // Selector is a label query over pods that should match the replica count. Label keys and values that must match in order to be controlled by this replica set. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
              mixinInstance(metadata):: __metadataMixin(metadata),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotations(annotations):: self + __metadataMixin({ annotations: annotations }),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotationsMixin(annotations):: self + __metadataMixin({ annotations+: annotations }),
              // The name of the cluster which the object belongs to. This is used to distinguish resources with same name and namespace in different clusters. This field is not set anywhere right now and apiserver is going to ignore it if set in create or update request.
              withClusterName(clusterName):: self + __metadataMixin({ clusterName: clusterName }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
              // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
              //
              // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
              //
              // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
              withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabels(labels):: self + __metadataMixin({ labels: labels }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
              withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
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
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainers(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers: ephemeralContainers }) else __specMixin({ ephemeralContainers: [ephemeralContainers] }),
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainersMixin(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers+: ephemeralContainers }) else __specMixin({ ephemeralContainers+: [ephemeralContainers] }),
              ephemeralContainersType:: hidden.core.v1.ephemeralContainer,
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
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverhead(overhead):: self + __specMixin({ overhead: overhead }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverheadMixin(overhead):: self + __specMixin({ overhead+: overhead }),
              // PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. This field is alpha-level and is only honored by servers that enable the NonPreemptingPriority feature.
              withPreemptionPolicy(preemptionPolicy):: self + __specMixin({ preemptionPolicy: preemptionPolicy }),
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
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is a beta feature as of Kubernetes v1.14.
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
                // fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are "OnRootMismatch" and "Always". If not specified defaults to "Always".
                withFsGroupChangePolicy(fsGroupChangePolicy):: self + __securityContextMixin({ fsGroupChangePolicy: fsGroupChangePolicy }),
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
                // The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                windowsOptions:: {
                  local __windowsOptionsMixin(windowsOptions) = __securityContextMixin({ windowsOptions+: windowsOptions }),
                  mixinInstance(windowsOptions):: __windowsOptionsMixin(windowsOptions),
                  // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.
                  withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                  // GMSACredentialSpecName is the name of the GMSA credential spec to use.
                  withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                  // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                  withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
                },
                windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.
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
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraintsMixin(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints+: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints+: [topologySpreadConstraints] }),
              topologySpreadConstraintsType:: hidden.core.v1.topologySpreadConstraint,
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
        specType:: hidden.apps.v1.replicaSetSpec,
      },
    },
    // StatefulSet represents a set of pods with consistent identities. Identities are defined as:
    // - Network: A single stable DNS and hostname.
    // - Storage: As many VolumeClaims as requested.
    // The StatefulSet guarantees that a given network identity will always map to the same storage identity.
    statefulSet:: {
      local kind = { kind: 'StatefulSet' },
      new(name='', replicas=1, containers='', volumeClaims='', podLabels={ app: 'name' }):: apiVersion + kind + self.mixin.metadata.withName(name) + self.mixin.spec.withReplicas(replicas).withVolumeClaimTemplates(volumeClaims) + self.mixin.spec.template.metadata.withLabels(podLabels) + self.mixin.spec.template.spec.withContainers(containers),
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
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
          // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
          // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
          //
          // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
          //
          // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
          withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabels(labels):: self + __metadataMixin({ labels: labels }),
          // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
          withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
          withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
          // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
        // Spec defines the desired identities of pods in this set.
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // podManagementPolicy controls how pods are created during initial scale up, when replacing pods on nodes, or when scaling down. The default policy is `OrderedReady`, where pods are created in increasing order (pod-0, then pod-1, etc) and the controller will wait until each pod is ready before continuing. When scaling down, the pods are removed in the opposite order. The alternative policy is `Parallel` which will create pods in parallel to match the desired scale without waiting, and on scale down will delete all pods at once.
          withPodManagementPolicy(podManagementPolicy):: self + __specMixin({ podManagementPolicy: podManagementPolicy }),
          // replicas is the desired number of replicas of the given Template. These are replicas in the sense that they are instantiations of the same Template, but individual replicas also have a consistent identity. If unspecified, defaults to 1.
          withReplicas(replicas):: self + __specMixin({ replicas: replicas }),
          // revisionHistoryLimit is the maximum number of revisions that will be maintained in the StatefulSet's revision history. The revision history consists of all revisions not represented by a currently applied StatefulSetSpec version. The default value is 10.
          withRevisionHistoryLimit(revisionHistoryLimit):: self + __specMixin({ revisionHistoryLimit: revisionHistoryLimit }),
          // selector is a label query over pods that should match the replica count. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
          // serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set. Pods get DNS/hostnames that follow the pattern: pod-specific-string.serviceName.default.svc.cluster.local where "pod-specific-string" is managed by the StatefulSet controller.
          withServiceName(serviceName):: self + __specMixin({ serviceName: serviceName }),
          // template is the object that describes the pod that will be created if insufficient replicas are detected. Each pod stamped out by the StatefulSet will fulfill this Template, but have a unique identity from the rest of the StatefulSet.
          template:: {
            local __templateMixin(template) = __specMixin({ template+: template }),
            mixinInstance(template):: __templateMixin(template),
            // Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
            metadata:: {
              local __metadataMixin(metadata) = __templateMixin({ metadata+: metadata }),
              mixinInstance(metadata):: __metadataMixin(metadata),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotations(annotations):: self + __metadataMixin({ annotations: annotations }),
              // Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations
              withAnnotationsMixin(annotations):: self + __metadataMixin({ annotations+: annotations }),
              // The name of the cluster which the object belongs to. This is used to distinguish resources with same name and namespace in different clusters. This field is not set anywhere right now and apiserver is going to ignore it if set in create or update request.
              withClusterName(clusterName):: self + __metadataMixin({ clusterName: clusterName }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers: finalizers }) else __metadataMixin({ finalizers: [finalizers] }),
              // Must be empty before the object is deleted from the registry. Each entry is an identifier for the responsible component that will remove the entry from the list. If the deletionTimestamp of the object is non-nil, entries in this list can only be removed. Finalizers may be processed and removed in any order.  Order is NOT enforced because it introduces significant risk of stuck finalizers. finalizers is a shared field, any actor with permission can reorder it. If the finalizer list is processed in order, then this can lead to a situation in which the component responsible for the first finalizer in the list is waiting for a signal (field value, external system, or other) produced by a component responsible for a finalizer later in the list, resulting in a deadlock. Without enforced ordering finalizers are free to order amongst themselves and are not vulnerable to ordering changes in the list.
              withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __metadataMixin({ finalizers+: finalizers }) else __metadataMixin({ finalizers+: [finalizers] }),
              // GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.
              //
              // If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).
              //
              // Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#idempotency
              withGenerateName(generateName):: self + __metadataMixin({ generateName: generateName }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabels(labels):: self + __metadataMixin({ labels: labels }),
              // Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels
              withLabelsMixin(labels):: self + __metadataMixin({ labels+: labels }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
              withManagedFields(managedFields):: self + if std.type(managedFields) == 'array' then __metadataMixin({ managedFields: managedFields }) else __metadataMixin({ managedFields: [managedFields] }),
              // ManagedFields maps workflow-id and version to the set of fields that are managed by that workflow. This is mostly for internal housekeeping, and users typically shouldn't need to set or understand this field. A workflow can be the user's name, a controller's name, or the name of a specific apply path like "ci-cd". The set of fields is always in the version that the workflow used when modifying the object.
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
            // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
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
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainers(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers: ephemeralContainers }) else __specMixin({ ephemeralContainers: [ephemeralContainers] }),
              // List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.
              withEphemeralContainersMixin(ephemeralContainers):: self + if std.type(ephemeralContainers) == 'array' then __specMixin({ ephemeralContainers+: ephemeralContainers }) else __specMixin({ ephemeralContainers+: [ephemeralContainers] }),
              ephemeralContainersType:: hidden.core.v1.ephemeralContainer,
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
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainers(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers: initContainers }) else __specMixin({ initContainers: [initContainers] }),
              // List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
              withInitContainersMixin(initContainers):: self + if std.type(initContainers) == 'array' then __specMixin({ initContainers+: initContainers }) else __specMixin({ initContainers+: [initContainers] }),
              initContainersType:: hidden.core.v1.container,
              // NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
              withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelector(nodeSelector):: self + __specMixin({ nodeSelector: nodeSelector }),
              // NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
              withNodeSelectorMixin(nodeSelector):: self + __specMixin({ nodeSelector+: nodeSelector }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverhead(overhead):: self + __specMixin({ overhead: overhead }),
              // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.
              withOverheadMixin(overhead):: self + __specMixin({ overhead+: overhead }),
              // PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. This field is alpha-level and is only honored by servers that enable the NonPreemptingPriority feature.
              withPreemptionPolicy(preemptionPolicy):: self + __specMixin({ preemptionPolicy: preemptionPolicy }),
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
              // RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md This is a beta feature as of Kubernetes v1.14.
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
                // fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are "OnRootMismatch" and "Always". If not specified defaults to "Always".
                withFsGroupChangePolicy(fsGroupChangePolicy):: self + __securityContextMixin({ fsGroupChangePolicy: fsGroupChangePolicy }),
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
                // The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                windowsOptions:: {
                  local __windowsOptionsMixin(windowsOptions) = __securityContextMixin({ windowsOptions+: windowsOptions }),
                  mixinInstance(windowsOptions):: __windowsOptionsMixin(windowsOptions),
                  // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.
                  withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                  // GMSACredentialSpecName is the name of the GMSA credential spec to use.
                  withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                  // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                  withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
                },
                windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
              },
              securityContextType:: hidden.core.v1.podSecurityContext,
              // DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
              withServiceAccount(serviceAccount):: self + __specMixin({ serviceAccount: serviceAccount }),
              // ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
              withServiceAccountName(serviceAccountName):: self + __specMixin({ serviceAccountName: serviceAccountName }),
              // Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.
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
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is only honored by clusters that enable the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraintsMixin(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints+: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints+: [topologySpreadConstraints] }),
              topologySpreadConstraintsType:: hidden.core.v1.topologySpreadConstraint,
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumes(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes: volumes }) else __specMixin({ volumes: [volumes] }),
              // List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
              withVolumesMixin(volumes):: self + if std.type(volumes) == 'array' then __specMixin({ volumes+: volumes }) else __specMixin({ volumes+: [volumes] }),
              volumesType:: hidden.core.v1.volume,
            },
            specType:: hidden.core.v1.podSpec,
          },
          templateType:: hidden.core.v1.podTemplateSpec,
          // updateStrategy indicates the StatefulSetUpdateStrategy that will be employed to update Pods in the StatefulSet when a revision is made to Template.
          updateStrategy:: {
            local __updateStrategyMixin(updateStrategy) = __specMixin({ updateStrategy+: updateStrategy }),
            mixinInstance(updateStrategy):: __updateStrategyMixin(updateStrategy),
            // RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.
            rollingUpdate:: {
              local __rollingUpdateMixin(rollingUpdate) = __updateStrategyMixin({ rollingUpdate+: rollingUpdate }),
              mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
              // Partition indicates the ordinal at which the StatefulSet should be partitioned. Default value is 0.
              withPartition(partition):: self + __rollingUpdateMixin({ partition: partition }),
            },
            rollingUpdateType:: hidden.apps.v1.rollingUpdateStatefulSetStrategy,
            // Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.
            withType(type):: self + __updateStrategyMixin({ type: type }),
          },
          updateStrategyType:: hidden.apps.v1.statefulSetUpdateStrategy,
          // volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
          withVolumeClaimTemplates(volumeClaimTemplates):: self + if std.type(volumeClaimTemplates) == 'array' then __specMixin({ volumeClaimTemplates: volumeClaimTemplates }) else __specMixin({ volumeClaimTemplates: [volumeClaimTemplates] }),
          // volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
          withVolumeClaimTemplatesMixin(volumeClaimTemplates):: self + if std.type(volumeClaimTemplates) == 'array' then __specMixin({ volumeClaimTemplates+: volumeClaimTemplates }) else __specMixin({ volumeClaimTemplates+: [volumeClaimTemplates] }),
          volumeClaimTemplatesType:: hidden.core.v1.persistentVolumeClaim,
        },
        specType:: hidden.apps.v1.statefulSetSpec,
      },
    },
  },
}