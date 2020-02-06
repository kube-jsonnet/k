{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'events.k8s.io/v1beta1' },
    // Event is a report of an event somewhere in the cluster. It generally denotes some state change in the system.
    event:: {
      local kind = { kind: 'Event' },
      new():: apiVersion + kind,
      // What action was taken/failed regarding to the regarding object.
      withAction(action):: self + { action: action },
      // Deprecated field assuring backward compatibility with core.v1 Event type
      withDeprecatedCount(deprecatedCount):: self + { deprecatedCount: deprecatedCount },
      // Deprecated field assuring backward compatibility with core.v1 Event type
      withDeprecatedFirstTimestamp(deprecatedFirstTimestamp):: self + { deprecatedFirstTimestamp: deprecatedFirstTimestamp },
      // Deprecated field assuring backward compatibility with core.v1 Event type
      withDeprecatedLastTimestamp(deprecatedLastTimestamp):: self + { deprecatedLastTimestamp: deprecatedLastTimestamp },
      // Required. Time when this Event was first observed.
      withEventTime(eventTime):: self + { eventTime: eventTime },
      // Optional. A human-readable description of the status of this operation. Maximal length of the note is 1kB, but libraries should be prepared to handle values up to 64kB.
      withNote(note):: self + { note: note },
      // Why the action was taken.
      withReason(reason):: self + { reason: reason },
      // Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.
      withReportingController(reportingController):: self + { reportingController: reportingController },
      // ID of the controller instance, e.g. `kubelet-xyzf`.
      withReportingInstance(reportingInstance):: self + { reportingInstance: reportingInstance },
      // Type of this event (Normal, Warning), new types could be added in the future.
      withType(type):: self + { type: type },
      mixin:: {
        // Deprecated field assuring backward compatibility with core.v1 Event type
        deprecatedSource:: {
          local __deprecatedSourceMixin(deprecatedSource) = { deprecatedSource+: deprecatedSource },
          mixinInstance(deprecatedSource):: __deprecatedSourceMixin(deprecatedSource),
          // Component from which the event is generated.
          withComponent(component):: self + __deprecatedSourceMixin({ component: component }),
          // Node name on which the event is generated.
          withHost(host):: self + __deprecatedSourceMixin({ host: host }),
        },
        deprecatedSourceType:: hidden.core.v1.eventSource,
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
        // The object this Event is about. In most cases it's an Object reporting controller implements. E.g. ReplicaSetController implements ReplicaSets and this event is emitted because it acts on some changes in a ReplicaSet object.
        regarding:: {
          local __regardingMixin(regarding) = { regarding+: regarding },
          mixinInstance(regarding):: __regardingMixin(regarding),
          // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
          withFieldPath(fieldPath):: self + __regardingMixin({ fieldPath: fieldPath }),
          // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
          withName(name):: self + __regardingMixin({ name: name }),
          // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
          withNamespace(namespace):: self + __regardingMixin({ namespace: namespace }),
          // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
          withResourceVersion(resourceVersion):: self + __regardingMixin({ resourceVersion: resourceVersion }),
          // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
          withUid(uid):: self + __regardingMixin({ uid: uid }),
        },
        regardingType:: hidden.core.v1.objectReference,
        // Optional secondary object for more complex actions. E.g. when regarding object triggers a creation or deletion of related object.
        related:: {
          local __relatedMixin(related) = { related+: related },
          mixinInstance(related):: __relatedMixin(related),
          // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
          withFieldPath(fieldPath):: self + __relatedMixin({ fieldPath: fieldPath }),
          // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
          withName(name):: self + __relatedMixin({ name: name }),
          // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
          withNamespace(namespace):: self + __relatedMixin({ namespace: namespace }),
          // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
          withResourceVersion(resourceVersion):: self + __relatedMixin({ resourceVersion: resourceVersion }),
          // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
          withUid(uid):: self + __relatedMixin({ uid: uid }),
        },
        relatedType:: hidden.core.v1.objectReference,
        // Data about the Event series this event represents or nil if it's a singleton Event.
        series:: {
          local __seriesMixin(series) = { series+: series },
          mixinInstance(series):: __seriesMixin(series),
          // Number of occurrences in this series up to the last heartbeat time
          withCount(count):: self + __seriesMixin({ count: count }),
          // Time when last Event from the series was seen before last heartbeat.
          withLastObservedTime(lastObservedTime):: self + __seriesMixin({ lastObservedTime: lastObservedTime }),
          // Information whether this series is ongoing or finished.
          withState(state):: self + __seriesMixin({ state: state }),
        },
        seriesType:: hidden.events.v1beta1.eventSeries,
      },
    },
  },
}