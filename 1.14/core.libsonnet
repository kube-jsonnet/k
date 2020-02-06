{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'v1' },
    // Binding ties one object to another; for example, a pod is bound to a node by a scheduler. Deprecated in 1.7, please use the bindings subresource of pods instead.
    binding:: {
      local kind = { kind: 'Binding' },
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
        // The target object that you want to bind to the standard object.
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
          withFieldPath(fieldPath):: self + __targetMixin({ fieldPath: fieldPath }),
          // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
          withName(name):: self + __targetMixin({ name: name }),
          // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
          withNamespace(namespace):: self + __targetMixin({ namespace: namespace }),
          // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
          withResourceVersion(resourceVersion):: self + __targetMixin({ resourceVersion: resourceVersion }),
          // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
          withUid(uid):: self + __targetMixin({ uid: uid }),
        },
        targetType:: hidden.core.v1.objectReference,
      },
    },
    // ConfigMap holds configuration data for pods to consume.
    configMap:: {
      local kind = { kind: 'ConfigMap' },
      new(name='', data=''):: apiVersion + kind + self.withData(data) + self.mixin.metadata.withName(name),
      // BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet.
      withBinaryData(binaryData):: self + { binaryData: binaryData },
      // BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet.
      withBinaryDataMixin(binaryData):: self + { binaryData+: binaryData },
      // Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process.
      withData(data):: self + { data: data },
      // Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process.
      withDataMixin(data):: self + { data+: data },
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
      },
    },
    // Endpoints is a collection of endpoints that implement the actual service. Example:
    // Name: "mysvc",
    // Subsets: [
    // {
    // Addresses: [{"ip": "10.10.1.1"}, {"ip": "10.10.2.2"}],
    // Ports: [{"name": "a", "port": 8675}, {"name": "b", "port": 309}]
    // },
    // {
    // Addresses: [{"ip": "10.10.3.3"}],
    // Ports: [{"name": "a", "port": 93}, {"name": "b", "port": 76}]
    // },
    // ]
    endpoints:: {
      local kind = { kind: 'Endpoints' },
      new():: apiVersion + kind,
      // The set of all endpoints is the union of all subsets. Addresses are placed into subsets according to the IPs they share. A single address with multiple ports, some of which are ready and some of which are not (because they come from different containers) will result in the address being displayed in different subsets for the different ports. No address will appear in both Addresses and NotReadyAddresses in the same subset. Sets of addresses and ports that comprise a service.
      withSubsets(subsets):: self + if std.type(subsets) == 'array' then { subsets: subsets } else { subsets: [subsets] },
      // The set of all endpoints is the union of all subsets. Addresses are placed into subsets according to the IPs they share. A single address with multiple ports, some of which are ready and some of which are not (because they come from different containers) will result in the address being displayed in different subsets for the different ports. No address will appear in both Addresses and NotReadyAddresses in the same subset. Sets of addresses and ports that comprise a service.
      withSubsetsMixin(subsets):: self + if std.type(subsets) == 'array' then { subsets+: subsets } else { subsets+: [subsets] },
      subsetsType:: hidden.core.v1.endpointSubset,
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
      },
    },
    // Event is a report of an event somewhere in the cluster.
    event:: {
      local kind = { kind: 'Event' },
      new():: apiVersion + kind,
      // What action was taken/failed regarding to the Regarding object.
      withAction(action):: self + { action: action },
      // The number of times this event has occurred.
      withCount(count):: self + { count: count },
      // Time when this Event was first observed.
      withEventTime(eventTime):: self + { eventTime: eventTime },
      // The time at which the event was first recorded. (Time of server receipt is in TypeMeta.)
      withFirstTimestamp(firstTimestamp):: self + { firstTimestamp: firstTimestamp },
      // The time at which the most recent occurrence of this event was recorded.
      withLastTimestamp(lastTimestamp):: self + { lastTimestamp: lastTimestamp },
      // A human-readable description of the status of this operation.
      withMessage(message):: self + { message: message },
      // This should be a short, machine understandable string that gives the reason for the transition into the object's current status.
      withReason(reason):: self + { reason: reason },
      // Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.
      withReportingComponent(reportingComponent):: self + { reportingComponent: reportingComponent },
      // ID of the controller instance, e.g. `kubelet-xyzf`.
      withReportingInstance(reportingInstance):: self + { reportingInstance: reportingInstance },
      // Type of this event (Normal, Warning), new types could be added in the future
      withType(type):: self + { type: type },
      mixin:: {
        // The object that this event is about.
        involvedObject:: {
          local __involvedObjectMixin(involvedObject) = { involvedObject+: involvedObject },
          mixinInstance(involvedObject):: __involvedObjectMixin(involvedObject),
          // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
          withFieldPath(fieldPath):: self + __involvedObjectMixin({ fieldPath: fieldPath }),
          // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
          withName(name):: self + __involvedObjectMixin({ name: name }),
          // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
          withNamespace(namespace):: self + __involvedObjectMixin({ namespace: namespace }),
          // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
          withResourceVersion(resourceVersion):: self + __involvedObjectMixin({ resourceVersion: resourceVersion }),
          // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
          withUid(uid):: self + __involvedObjectMixin({ uid: uid }),
        },
        involvedObjectType:: hidden.core.v1.objectReference,
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
        // Optional secondary object for more complex actions.
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
          // Time of the last occurrence observed
          withLastObservedTime(lastObservedTime):: self + __seriesMixin({ lastObservedTime: lastObservedTime }),
          // State of this Series: Ongoing or Finished
          withState(state):: self + __seriesMixin({ state: state }),
        },
        seriesType:: hidden.core.v1.eventSeries,
        // The component reporting this event. Should be a short machine understandable string.
        source:: {
          local __sourceMixin(source) = { source+: source },
          mixinInstance(source):: __sourceMixin(source),
          // Component from which the event is generated.
          withComponent(component):: self + __sourceMixin({ component: component }),
          // Node name on which the event is generated.
          withHost(host):: self + __sourceMixin({ host: host }),
        },
        sourceType:: hidden.core.v1.eventSource,
      },
    },
    // LimitRange sets resource usage limits for each kind of resource in a Namespace.
    limitRange:: {
      local kind = { kind: 'LimitRange' },
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
        // Spec defines the limits enforced. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Limits is the list of LimitRangeItem objects that are enforced.
          withLimits(limits):: self + if std.type(limits) == 'array' then __specMixin({ limits: limits }) else __specMixin({ limits: [limits] }),
          // Limits is the list of LimitRangeItem objects that are enforced.
          withLimitsMixin(limits):: self + if std.type(limits) == 'array' then __specMixin({ limits+: limits }) else __specMixin({ limits+: [limits] }),
          limitsType:: hidden.core.v1.limitRangeItem,
        },
        specType:: hidden.core.v1.limitRangeSpec,
      },
    },
    // Namespace provides a scope for Names. Use of multiple namespaces is optional.
    namespace:: {
      local kind = { kind: 'Namespace' },
      new(name=''):: apiVersion + kind + self.mixin.metadata.withName(name),
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
        // Spec defines the behavior of the Namespace. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Finalizers is an opaque list of values that must be empty to permanently remove object from storage. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
          withFinalizers(finalizers):: self + if std.type(finalizers) == 'array' then __specMixin({ finalizers: finalizers }) else __specMixin({ finalizers: [finalizers] }),
          // Finalizers is an opaque list of values that must be empty to permanently remove object from storage. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
          withFinalizersMixin(finalizers):: self + if std.type(finalizers) == 'array' then __specMixin({ finalizers+: finalizers }) else __specMixin({ finalizers+: [finalizers] }),
        },
        specType:: hidden.core.v1.namespaceSpec,
      },
    },
    // Node is a worker node in Kubernetes. Each node will have a unique identifier in the cache (i.e. in etcd).
    node:: {
      local kind = { kind: 'Node' },
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
        // Spec defines the behavior of a node. https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // If specified, the source to get node configuration from The DynamicKubeletConfig feature gate must be enabled for the Kubelet to use this field
          configSource:: {
            local __configSourceMixin(configSource) = __specMixin({ configSource+: configSource }),
            mixinInstance(configSource):: __configSourceMixin(configSource),
            // ConfigMap is a reference to a Node's ConfigMap
            configMap:: {
              local __configMapMixin(configMap) = __configSourceMixin({ configMap+: configMap }),
              mixinInstance(configMap):: __configMapMixin(configMap),
              // KubeletConfigKey declares which key of the referenced ConfigMap corresponds to the KubeletConfiguration structure This field is required in all cases.
              withKubeletConfigKey(kubeletConfigKey):: self + __configMapMixin({ kubeletConfigKey: kubeletConfigKey }),
              // Name is the metadata.name of the referenced ConfigMap. This field is required in all cases.
              withName(name):: self + __configMapMixin({ name: name }),
              // Namespace is the metadata.namespace of the referenced ConfigMap. This field is required in all cases.
              withNamespace(namespace):: self + __configMapMixin({ namespace: namespace }),
              // ResourceVersion is the metadata.ResourceVersion of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
              withResourceVersion(resourceVersion):: self + __configMapMixin({ resourceVersion: resourceVersion }),
              // UID is the metadata.UID of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
              withUid(uid):: self + __configMapMixin({ uid: uid }),
            },
            configMapType:: hidden.core.v1.configMapNodeConfigSource,
          },
          configSourceType:: hidden.core.v1.nodeConfigSource,
          // Deprecated. Not all kubelets will set this field. Remove field after 1.13. see: https://issues.k8s.io/61966
          withExternalId(externalId):: self + __specMixin({ externalID: externalId }),
          // PodCIDR represents the pod IP range assigned to the node.
          withPodCidr(podCidr):: self + __specMixin({ podCIDR: podCidr }),
          // ID of the node assigned by the cloud provider in the format: <ProviderName>://<ProviderSpecificNodeID>
          withProviderId(providerId):: self + __specMixin({ providerID: providerId }),
          // If specified, the node's taints.
          withTaints(taints):: self + if std.type(taints) == 'array' then __specMixin({ taints: taints }) else __specMixin({ taints: [taints] }),
          // If specified, the node's taints.
          withTaintsMixin(taints):: self + if std.type(taints) == 'array' then __specMixin({ taints+: taints }) else __specMixin({ taints+: [taints] }),
          taintsType:: hidden.core.v1.taint,
          // Unschedulable controls node schedulability of new pods. By default, node is schedulable. More info: https://kubernetes.io/docs/concepts/nodes/node/#manual-node-administration
          withUnschedulable(unschedulable):: self + __specMixin({ unschedulable: unschedulable }),
        },
        specType:: hidden.core.v1.nodeSpec,
      },
    },
    // PersistentVolume (PV) is a storage resource provisioned by an administrator. It is analogous to a node. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes
    persistentVolume:: {
      local kind = { kind: 'PersistentVolume' },
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
        // Spec defines a specification of a persistent volume owned by the cluster. Provisioned by an administrator. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistent-volumes
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
          withAccessModes(accessModes):: self + if std.type(accessModes) == 'array' then __specMixin({ accessModes: accessModes }) else __specMixin({ accessModes: [accessModes] }),
          // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
          withAccessModesMixin(accessModes):: self + if std.type(accessModes) == 'array' then __specMixin({ accessModes+: accessModes }) else __specMixin({ accessModes+: [accessModes] }),
          // AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
          awsElasticBlockStore:: {
            local __awsElasticBlockStoreMixin(awsElasticBlockStore) = __specMixin({ awsElasticBlockStore+: awsElasticBlockStore }),
            mixinInstance(awsElasticBlockStore):: __awsElasticBlockStoreMixin(awsElasticBlockStore),
            // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
            withFsType(fsType):: self + __awsElasticBlockStoreMixin({ fsType: fsType }),
            // The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as "1". Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
            withPartition(partition):: self + __awsElasticBlockStoreMixin({ partition: partition }),
            // Specify "true" to force and set the ReadOnly property in VolumeMounts to "true". If omitted, the default is "false". More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
            withReadOnly(readOnly):: self + __awsElasticBlockStoreMixin({ readOnly: readOnly }),
            // Unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
            withVolumeId(volumeId):: self + __awsElasticBlockStoreMixin({ volumeID: volumeId }),
          },
          awsElasticBlockStoreType:: hidden.core.v1.awsElasticBlockStoreVolumeSource,
          // AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
          azureDisk:: {
            local __azureDiskMixin(azureDisk) = __specMixin({ azureDisk+: azureDisk }),
            mixinInstance(azureDisk):: __azureDiskMixin(azureDisk),
            // Host Caching mode: None, Read Only, Read Write.
            withCachingMode(cachingMode):: self + __azureDiskMixin({ cachingMode: cachingMode }),
            // The Name of the data disk in the blob storage
            withDiskName(diskName):: self + __azureDiskMixin({ diskName: diskName }),
            // The URI the data disk in the blob storage
            withDiskUri(diskUri):: self + __azureDiskMixin({ diskURI: diskUri }),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
            withFsType(fsType):: self + __azureDiskMixin({ fsType: fsType }),
            // Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __azureDiskMixin({ readOnly: readOnly }),
          },
          azureDiskType:: hidden.core.v1.azureDiskVolumeSource,
          // AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
          azureFile:: {
            local __azureFileMixin(azureFile) = __specMixin({ azureFile+: azureFile }),
            mixinInstance(azureFile):: __azureFileMixin(azureFile),
            // Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __azureFileMixin({ readOnly: readOnly }),
            // the name of secret that contains Azure Storage Account Name and Key
            withSecretName(secretName):: self + __azureFileMixin({ secretName: secretName }),
            // the namespace of the secret that contains Azure Storage Account Name and Key default is the same as the Pod
            withSecretNamespace(secretNamespace):: self + __azureFileMixin({ secretNamespace: secretNamespace }),
            // Share Name
            withShareName(shareName):: self + __azureFileMixin({ shareName: shareName }),
          },
          azureFileType:: hidden.core.v1.azureFilePersistentVolumeSource,
          // A description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
          withCapacity(capacity):: self + __specMixin({ capacity: capacity }),
          // A description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
          withCapacityMixin(capacity):: self + __specMixin({ capacity+: capacity }),
          // CephFS represents a Ceph FS mount on the host that shares a pod's lifetime
          cephfs:: {
            local __cephfsMixin(cephfs) = __specMixin({ cephfs+: cephfs }),
            mixinInstance(cephfs):: __cephfsMixin(cephfs),
            // Required: Monitors is a collection of Ceph monitors More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
            withMonitors(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors: monitors }) else __cephfsMixin({ monitors: [monitors] }),
            // Required: Monitors is a collection of Ceph monitors More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
            withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors+: monitors }) else __cephfsMixin({ monitors+: [monitors] }),
            // Optional: Used as the mounted root, rather than the full Ceph tree, default is /
            withPath(path):: self + __cephfsMixin({ path: path }),
            // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
            withReadOnly(readOnly):: self + __cephfsMixin({ readOnly: readOnly }),
            // Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
            withSecretFile(secretFile):: self + __cephfsMixin({ secretFile: secretFile }),
            // Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
            secretRef:: {
              local __secretRefMixin(secretRef) = __cephfsMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
            },
            secretRefType:: hidden.core.v1.secretReference,
            // Optional: User is the rados user name, default is admin More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
            withUser(user):: self + __cephfsMixin({ user: user }),
          },
          cephfsType:: hidden.core.v1.cephFsPersistentVolumeSource,
          // Cinder represents a cinder volume attached and mounted on kubelets host machine More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
          cinder:: {
            local __cinderMixin(cinder) = __specMixin({ cinder+: cinder }),
            mixinInstance(cinder):: __cinderMixin(cinder),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
            withFsType(fsType):: self + __cinderMixin({ fsType: fsType }),
            // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
            withReadOnly(readOnly):: self + __cinderMixin({ readOnly: readOnly }),
            // Optional: points to a secret object containing parameters used to connect to OpenStack.
            secretRef:: {
              local __secretRefMixin(secretRef) = __cinderMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
            },
            secretRefType:: hidden.core.v1.secretReference,
            // volume id used to identify the volume in cinder More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
            withVolumeId(volumeId):: self + __cinderMixin({ volumeID: volumeId }),
          },
          cinderType:: hidden.core.v1.cinderPersistentVolumeSource,
          // ClaimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
          claimRef:: {
            local __claimRefMixin(claimRef) = __specMixin({ claimRef+: claimRef }),
            mixinInstance(claimRef):: __claimRefMixin(claimRef),
            // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
            withFieldPath(fieldPath):: self + __claimRefMixin({ fieldPath: fieldPath }),
            // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
            withName(name):: self + __claimRefMixin({ name: name }),
            // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
            withNamespace(namespace):: self + __claimRefMixin({ namespace: namespace }),
            // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
            withResourceVersion(resourceVersion):: self + __claimRefMixin({ resourceVersion: resourceVersion }),
            // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
            withUid(uid):: self + __claimRefMixin({ uid: uid }),
          },
          claimRefType:: hidden.core.v1.objectReference,
          // CSI represents storage that is handled by an external CSI driver (Beta feature).
          csi:: {
            local __csiMixin(csi) = __specMixin({ csi+: csi }),
            mixinInstance(csi):: __csiMixin(csi),
            // ControllerPublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerPublishVolume and ControllerUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
            controllerPublishSecretRef:: {
              local __controllerPublishSecretRefMixin(controllerPublishSecretRef) = __csiMixin({ controllerPublishSecretRef+: controllerPublishSecretRef }),
              mixinInstance(controllerPublishSecretRef):: __controllerPublishSecretRefMixin(controllerPublishSecretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __controllerPublishSecretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __controllerPublishSecretRefMixin({ namespace: namespace }),
            },
            controllerPublishSecretRefType:: hidden.core.v1.secretReference,
            // Driver is the name of the driver to use for this volume. Required.
            withDriver(driver):: self + __csiMixin({ driver: driver }),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs".
            withFsType(fsType):: self + __csiMixin({ fsType: fsType }),
            // NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
            nodePublishSecretRef:: {
              local __nodePublishSecretRefMixin(nodePublishSecretRef) = __csiMixin({ nodePublishSecretRef+: nodePublishSecretRef }),
              mixinInstance(nodePublishSecretRef):: __nodePublishSecretRefMixin(nodePublishSecretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __nodePublishSecretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __nodePublishSecretRefMixin({ namespace: namespace }),
            },
            nodePublishSecretRefType:: hidden.core.v1.secretReference,
            // NodeStageSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeStageVolume and NodeStageVolume and NodeUnstageVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
            nodeStageSecretRef:: {
              local __nodeStageSecretRefMixin(nodeStageSecretRef) = __csiMixin({ nodeStageSecretRef+: nodeStageSecretRef }),
              mixinInstance(nodeStageSecretRef):: __nodeStageSecretRefMixin(nodeStageSecretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __nodeStageSecretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __nodeStageSecretRefMixin({ namespace: namespace }),
            },
            nodeStageSecretRefType:: hidden.core.v1.secretReference,
            // Optional: The value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write).
            withReadOnly(readOnly):: self + __csiMixin({ readOnly: readOnly }),
            // Attributes of the volume to publish.
            withVolumeAttributes(volumeAttributes):: self + __csiMixin({ volumeAttributes: volumeAttributes }),
            // Attributes of the volume to publish.
            withVolumeAttributesMixin(volumeAttributes):: self + __csiMixin({ volumeAttributes+: volumeAttributes }),
            // VolumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required.
            withVolumeHandle(volumeHandle):: self + __csiMixin({ volumeHandle: volumeHandle }),
          },
          csiType:: hidden.core.v1.csiPersistentVolumeSource,
          // FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
          fc:: {
            local __fcMixin(fc) = __specMixin({ fc+: fc }),
            mixinInstance(fc):: __fcMixin(fc),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
            withFsType(fsType):: self + __fcMixin({ fsType: fsType }),
            // Optional: FC target lun number
            withLun(lun):: self + __fcMixin({ lun: lun }),
            // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __fcMixin({ readOnly: readOnly }),
            // Optional: FC target worldwide names (WWNs)
            withTargetWwns(targetWwns):: self + if std.type(targetWwns) == 'array' then __fcMixin({ targetWWNs: targetWwns }) else __fcMixin({ targetWWNs: [targetWwns] }),
            // Optional: FC target worldwide names (WWNs)
            withTargetWwnsMixin(targetWwns):: self + if std.type(targetWwns) == 'array' then __fcMixin({ targetWWNs+: targetWwns }) else __fcMixin({ targetWWNs+: [targetWwns] }),
            // Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.
            withWwids(wwids):: self + if std.type(wwids) == 'array' then __fcMixin({ wwids: wwids }) else __fcMixin({ wwids: [wwids] }),
            // Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.
            withWwidsMixin(wwids):: self + if std.type(wwids) == 'array' then __fcMixin({ wwids+: wwids }) else __fcMixin({ wwids+: [wwids] }),
          },
          fcType:: hidden.core.v1.fcVolumeSource,
          // FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
          flexVolume:: {
            local __flexVolumeMixin(flexVolume) = __specMixin({ flexVolume+: flexVolume }),
            mixinInstance(flexVolume):: __flexVolumeMixin(flexVolume),
            // Driver is the name of the driver to use for this volume.
            withDriver(driver):: self + __flexVolumeMixin({ driver: driver }),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
            withFsType(fsType):: self + __flexVolumeMixin({ fsType: fsType }),
            // Optional: Extra command options if any.
            withOptions(options):: self + __flexVolumeMixin({ options: options }),
            // Optional: Extra command options if any.
            withOptionsMixin(options):: self + __flexVolumeMixin({ options+: options }),
            // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __flexVolumeMixin({ readOnly: readOnly }),
            // Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.
            secretRef:: {
              local __secretRefMixin(secretRef) = __flexVolumeMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
            },
            secretRefType:: hidden.core.v1.secretReference,
          },
          flexVolumeType:: hidden.core.v1.flexPersistentVolumeSource,
          // Flocker represents a Flocker volume attached to a kubelet's host machine and exposed to the pod for its usage. This depends on the Flocker control service being running
          flocker:: {
            local __flockerMixin(flocker) = __specMixin({ flocker+: flocker }),
            mixinInstance(flocker):: __flockerMixin(flocker),
            // Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
            withDatasetName(datasetName):: self + __flockerMixin({ datasetName: datasetName }),
            // UUID of the dataset. This is unique identifier of a Flocker dataset
            withDatasetUuid(datasetUuid):: self + __flockerMixin({ datasetUUID: datasetUuid }),
          },
          flockerType:: hidden.core.v1.flockerVolumeSource,
          // GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
          gcePersistentDisk:: {
            local __gcePersistentDiskMixin(gcePersistentDisk) = __specMixin({ gcePersistentDisk+: gcePersistentDisk }),
            mixinInstance(gcePersistentDisk):: __gcePersistentDiskMixin(gcePersistentDisk),
            // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
            withFsType(fsType):: self + __gcePersistentDiskMixin({ fsType: fsType }),
            // The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as "1". Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
            withPartition(partition):: self + __gcePersistentDiskMixin({ partition: partition }),
            // Unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
            withPdName(pdName):: self + __gcePersistentDiskMixin({ pdName: pdName }),
            // ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
            withReadOnly(readOnly):: self + __gcePersistentDiskMixin({ readOnly: readOnly }),
          },
          gcePersistentDiskType:: hidden.core.v1.gcePersistentDiskVolumeSource,
          // Glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md
          glusterfs:: {
            local __glusterfsMixin(glusterfs) = __specMixin({ glusterfs+: glusterfs }),
            mixinInstance(glusterfs):: __glusterfsMixin(glusterfs),
            // EndpointsName is the endpoint name that details Glusterfs topology. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
            withEndpoints(endpoints):: self + __glusterfsMixin({ endpoints: endpoints }),
            // EndpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
            withEndpointsNamespace(endpointsNamespace):: self + __glusterfsMixin({ endpointsNamespace: endpointsNamespace }),
            // Path is the Glusterfs volume path. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
            withPath(path):: self + __glusterfsMixin({ path: path }),
            // ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
            withReadOnly(readOnly):: self + __glusterfsMixin({ readOnly: readOnly }),
          },
          glusterfsType:: hidden.core.v1.glusterfsPersistentVolumeSource,
          // HostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
          hostPath:: {
            local __hostPathMixin(hostPath) = __specMixin({ hostPath+: hostPath }),
            mixinInstance(hostPath):: __hostPathMixin(hostPath),
            // Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
            withPath(path):: self + __hostPathMixin({ path: path }),
            // Type for HostPath Volume Defaults to "" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
            withType(type):: self + __hostPathMixin({ type: type }),
          },
          hostPathType:: hidden.core.v1.hostPathVolumeSource,
          // ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
          iscsi:: {
            local __iscsiMixin(iscsi) = __specMixin({ iscsi+: iscsi }),
            mixinInstance(iscsi):: __iscsiMixin(iscsi),
            // whether support iSCSI Discovery CHAP authentication
            withChapAuthDiscovery(chapAuthDiscovery):: self + __iscsiMixin({ chapAuthDiscovery: chapAuthDiscovery }),
            // whether support iSCSI Session CHAP authentication
            withChapAuthSession(chapAuthSession):: self + __iscsiMixin({ chapAuthSession: chapAuthSession }),
            // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
            withFsType(fsType):: self + __iscsiMixin({ fsType: fsType }),
            // Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.
            withInitiatorName(initiatorName):: self + __iscsiMixin({ initiatorName: initiatorName }),
            // Target iSCSI Qualified Name.
            withIqn(iqn):: self + __iscsiMixin({ iqn: iqn }),
            // iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).
            withIscsiInterface(iscsiInterface):: self + __iscsiMixin({ iscsiInterface: iscsiInterface }),
            // iSCSI Target Lun number.
            withLun(lun):: self + __iscsiMixin({ lun: lun }),
            // iSCSI Target Portal List. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
            withPortals(portals):: self + if std.type(portals) == 'array' then __iscsiMixin({ portals: portals }) else __iscsiMixin({ portals: [portals] }),
            // iSCSI Target Portal List. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
            withPortalsMixin(portals):: self + if std.type(portals) == 'array' then __iscsiMixin({ portals+: portals }) else __iscsiMixin({ portals+: [portals] }),
            // ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.
            withReadOnly(readOnly):: self + __iscsiMixin({ readOnly: readOnly }),
            // CHAP Secret for iSCSI target and initiator authentication
            secretRef:: {
              local __secretRefMixin(secretRef) = __iscsiMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
            },
            secretRefType:: hidden.core.v1.secretReference,
            // iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
            withTargetPortal(targetPortal):: self + __iscsiMixin({ targetPortal: targetPortal }),
          },
          iscsiType:: hidden.core.v1.iscsiPersistentVolumeSource,
          // Local represents directly-attached storage with node affinity
          localStorage:: {
            local __localStorageMixin(localStorage) = __specMixin({ localStorage+: localStorage }),
            mixinInstance(localStorage):: __localStorageMixin(localStorage),
            // Filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a fileystem if unspecified.
            withFsType(fsType):: self + __localStorageMixin({ fsType: fsType }),
            // The full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).
            withPath(path):: self + __localStorageMixin({ path: path }),
          },
          localType:: hidden.core.v1.localVolumeSource,
          // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
          withMountOptions(mountOptions):: self + if std.type(mountOptions) == 'array' then __specMixin({ mountOptions: mountOptions }) else __specMixin({ mountOptions: [mountOptions] }),
          // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
          withMountOptionsMixin(mountOptions):: self + if std.type(mountOptions) == 'array' then __specMixin({ mountOptions+: mountOptions }) else __specMixin({ mountOptions+: [mountOptions] }),
          // NFS represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
          nfs:: {
            local __nfsMixin(nfs) = __specMixin({ nfs+: nfs }),
            mixinInstance(nfs):: __nfsMixin(nfs),
            // Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
            withPath(path):: self + __nfsMixin({ path: path }),
            // ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
            withReadOnly(readOnly):: self + __nfsMixin({ readOnly: readOnly }),
            // Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
            withServer(server):: self + __nfsMixin({ server: server }),
          },
          nfsType:: hidden.core.v1.nfsVolumeSource,
          // NodeAffinity defines constraints that limit what nodes this volume can be accessed from. This field influences the scheduling of pods that use this volume.
          nodeAffinity:: {
            local __nodeAffinityMixin(nodeAffinity) = __specMixin({ nodeAffinity+: nodeAffinity }),
            mixinInstance(nodeAffinity):: __nodeAffinityMixin(nodeAffinity),
            // Required specifies hard node constraints that must be met.
            required:: {
              local __requiredMixin(required) = __nodeAffinityMixin({ required+: required }),
              mixinInstance(required):: __requiredMixin(required),
              // Required. A list of node selector terms. The terms are ORed.
              withNodeSelectorTerms(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredMixin({ nodeSelectorTerms: nodeSelectorTerms }) else __requiredMixin({ nodeSelectorTerms: [nodeSelectorTerms] }),
              // Required. A list of node selector terms. The terms are ORed.
              withNodeSelectorTermsMixin(nodeSelectorTerms):: self + if std.type(nodeSelectorTerms) == 'array' then __requiredMixin({ nodeSelectorTerms+: nodeSelectorTerms }) else __requiredMixin({ nodeSelectorTerms+: [nodeSelectorTerms] }),
              nodeSelectorTermsType:: hidden.core.v1.nodeSelectorTerm,
            },
            requiredType:: hidden.core.v1.nodeSelector,
          },
          nodeAffinityType:: hidden.core.v1.volumeNodeAffinity,
          // What happens to a persistent volume when released from its claim. Valid options are Retain (default for manually created PersistentVolumes), Delete (default for dynamically provisioned PersistentVolumes), and Recycle (deprecated). Recycle must be supported by the volume plugin underlying this PersistentVolume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#reclaiming
          withPersistentVolumeReclaimPolicy(persistentVolumeReclaimPolicy):: self + __specMixin({ persistentVolumeReclaimPolicy: persistentVolumeReclaimPolicy }),
          // PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine
          photonPersistentDisk:: {
            local __photonPersistentDiskMixin(photonPersistentDisk) = __specMixin({ photonPersistentDisk+: photonPersistentDisk }),
            mixinInstance(photonPersistentDisk):: __photonPersistentDiskMixin(photonPersistentDisk),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
            withFsType(fsType):: self + __photonPersistentDiskMixin({ fsType: fsType }),
            // ID that identifies Photon Controller persistent disk
            withPdId(pdId):: self + __photonPersistentDiskMixin({ pdID: pdId }),
          },
          photonPersistentDiskType:: hidden.core.v1.photonPersistentDiskVolumeSource,
          // PortworxVolume represents a portworx volume attached and mounted on kubelets host machine
          portworxVolume:: {
            local __portworxVolumeMixin(portworxVolume) = __specMixin({ portworxVolume+: portworxVolume }),
            mixinInstance(portworxVolume):: __portworxVolumeMixin(portworxVolume),
            // FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if unspecified.
            withFsType(fsType):: self + __portworxVolumeMixin({ fsType: fsType }),
            // Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __portworxVolumeMixin({ readOnly: readOnly }),
            // VolumeID uniquely identifies a Portworx volume
            withVolumeId(volumeId):: self + __portworxVolumeMixin({ volumeID: volumeId }),
          },
          portworxVolumeType:: hidden.core.v1.portworxVolumeSource,
          // Quobyte represents a Quobyte mount on the host that shares a pod's lifetime
          quobyte:: {
            local __quobyteMixin(quobyte) = __specMixin({ quobyte+: quobyte }),
            mixinInstance(quobyte):: __quobyteMixin(quobyte),
            // Group to map volume access to Default is no group
            withGroup(group):: self + __quobyteMixin({ group: group }),
            // ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false.
            withReadOnly(readOnly):: self + __quobyteMixin({ readOnly: readOnly }),
            // Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes
            withRegistry(registry):: self + __quobyteMixin({ registry: registry }),
            // Tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin
            withTenant(tenant):: self + __quobyteMixin({ tenant: tenant }),
            // User to map volume access to Defaults to serivceaccount user
            withUser(user):: self + __quobyteMixin({ user: user }),
            // Volume is a string that references an already created Quobyte volume by name.
            withVolume(volume):: self + __quobyteMixin({ volume: volume }),
          },
          quobyteType:: hidden.core.v1.quobyteVolumeSource,
          // RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md
          rbd:: {
            local __rbdMixin(rbd) = __specMixin({ rbd+: rbd }),
            mixinInstance(rbd):: __rbdMixin(rbd),
            // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
            withFsType(fsType):: self + __rbdMixin({ fsType: fsType }),
            // The rados image name. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withImage(image):: self + __rbdMixin({ image: image }),
            // Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withKeyring(keyring):: self + __rbdMixin({ keyring: keyring }),
            // A collection of Ceph monitors. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withMonitors(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors: monitors }) else __rbdMixin({ monitors: [monitors] }),
            // A collection of Ceph monitors. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors+: monitors }) else __rbdMixin({ monitors+: [monitors] }),
            // The rados pool name. Default is rbd. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withPool(pool):: self + __rbdMixin({ pool: pool }),
            // ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withReadOnly(readOnly):: self + __rbdMixin({ readOnly: readOnly }),
            // SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            secretRef:: {
              local __secretRefMixin(secretRef) = __rbdMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
            },
            secretRefType:: hidden.core.v1.secretReference,
            // The rados user name. Default is admin. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
            withUser(user):: self + __rbdMixin({ user: user }),
          },
          rbdType:: hidden.core.v1.rbdPersistentVolumeSource,
          // ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
          scaleIo:: {
            local __scaleIoMixin(scaleIo) = __specMixin({ scaleIo+: scaleIo }),
            mixinInstance(scaleIo):: __scaleIoMixin(scaleIo),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Default is "xfs"
            withFsType(fsType):: self + __scaleIoMixin({ fsType: fsType }),
            // The host address of the ScaleIO API Gateway.
            withGateway(gateway):: self + __scaleIoMixin({ gateway: gateway }),
            // The name of the ScaleIO Protection Domain for the configured storage.
            withProtectionDomain(protectionDomain):: self + __scaleIoMixin({ protectionDomain: protectionDomain }),
            // Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __scaleIoMixin({ readOnly: readOnly }),
            // SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.
            secretRef:: {
              local __secretRefMixin(secretRef) = __scaleIoMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // Name is unique within a namespace to reference a secret resource.
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace defines the space within which the secret name must be unique.
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
            },
            secretRefType:: hidden.core.v1.secretReference,
            // Flag to enable/disable SSL communication with Gateway, default false
            withSslEnabled(sslEnabled):: self + __scaleIoMixin({ sslEnabled: sslEnabled }),
            // Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.
            withStorageMode(storageMode):: self + __scaleIoMixin({ storageMode: storageMode }),
            // The ScaleIO Storage Pool associated with the protection domain.
            withStoragePool(storagePool):: self + __scaleIoMixin({ storagePool: storagePool }),
            // The name of the storage system as configured in ScaleIO.
            withSystem(system):: self + __scaleIoMixin({ system: system }),
            // The name of a volume already created in the ScaleIO system that is associated with this volume source.
            withVolumeName(volumeName):: self + __scaleIoMixin({ volumeName: volumeName }),
          },
          scaleIOType:: hidden.core.v1.scaleIoPersistentVolumeSource,
          // Name of StorageClass to which this persistent volume belongs. Empty value means that this volume does not belong to any StorageClass.
          withStorageClassName(storageClassName):: self + __specMixin({ storageClassName: storageClassName }),
          // StorageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod More info: https://releases.k8s.io/HEAD/examples/volumes/storageos/README.md
          storageos:: {
            local __storageosMixin(storageos) = __specMixin({ storageos+: storageos }),
            mixinInstance(storageos):: __storageosMixin(storageos),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
            withFsType(fsType):: self + __storageosMixin({ fsType: fsType }),
            // Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
            withReadOnly(readOnly):: self + __storageosMixin({ readOnly: readOnly }),
            // SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.
            secretRef:: {
              local __secretRefMixin(secretRef) = __storageosMixin({ secretRef+: secretRef }),
              mixinInstance(secretRef):: __secretRefMixin(secretRef),
              // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
              withFieldPath(fieldPath):: self + __secretRefMixin({ fieldPath: fieldPath }),
              // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
              withName(name):: self + __secretRefMixin({ name: name }),
              // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
              withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
              // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
              withResourceVersion(resourceVersion):: self + __secretRefMixin({ resourceVersion: resourceVersion }),
              // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
              withUid(uid):: self + __secretRefMixin({ uid: uid }),
            },
            secretRefType:: hidden.core.v1.objectReference,
            // VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.
            withVolumeName(volumeName):: self + __storageosMixin({ volumeName: volumeName }),
            // VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.
            withVolumeNamespace(volumeNamespace):: self + __storageosMixin({ volumeNamespace: volumeNamespace }),
          },
          storageosType:: hidden.core.v1.storageOsPersistentVolumeSource,
          // volumeMode defines if a volume is intended to be used with a formatted filesystem or to remain in raw block state. Value of Filesystem is implied when not included in spec. This is a beta feature.
          withVolumeMode(volumeMode):: self + __specMixin({ volumeMode: volumeMode }),
          // VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine
          vsphereVolume:: {
            local __vsphereVolumeMixin(vsphereVolume) = __specMixin({ vsphereVolume+: vsphereVolume }),
            mixinInstance(vsphereVolume):: __vsphereVolumeMixin(vsphereVolume),
            // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
            withFsType(fsType):: self + __vsphereVolumeMixin({ fsType: fsType }),
            // Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.
            withStoragePolicyId(storagePolicyId):: self + __vsphereVolumeMixin({ storagePolicyID: storagePolicyId }),
            // Storage Policy Based Management (SPBM) profile name.
            withStoragePolicyName(storagePolicyName):: self + __vsphereVolumeMixin({ storagePolicyName: storagePolicyName }),
            // Path that identifies vSphere volume vmdk
            withVolumePath(volumePath):: self + __vsphereVolumeMixin({ volumePath: volumePath }),
          },
          vsphereVolumeType:: hidden.core.v1.vsphereVirtualDiskVolumeSource,
        },
        specType:: hidden.core.v1.persistentVolumeSpec,
      },
    },
    // PersistentVolumeClaim is a user's request for and claim to a persistent volume
    persistentVolumeClaim:: {
      local kind = { kind: 'PersistentVolumeClaim' },
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
        // Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
          withAccessModes(accessModes):: self + if std.type(accessModes) == 'array' then __specMixin({ accessModes: accessModes }) else __specMixin({ accessModes: [accessModes] }),
          // AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
          withAccessModesMixin(accessModes):: self + if std.type(accessModes) == 'array' then __specMixin({ accessModes+: accessModes }) else __specMixin({ accessModes+: [accessModes] }),
          // This field requires the VolumeSnapshotDataSource alpha feature gate to be enabled and currently VolumeSnapshot is the only supported data source. If the provisioner can support VolumeSnapshot data source, it will create a new volume and data will be restored to the volume at the same time. If the provisioner does not support VolumeSnapshot data source, volume will not be created and the failure will be reported as an event. In the future, we plan to support more data source types and the behavior of the provisioner may change.
          dataSource:: {
            local __dataSourceMixin(dataSource) = __specMixin({ dataSource+: dataSource }),
            mixinInstance(dataSource):: __dataSourceMixin(dataSource),
            // APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.
            withApiGroup(apiGroup):: self + __dataSourceMixin({ apiGroup: apiGroup }),
            // Kind is the type of resource being referenced
            withKind(kind):: self + __dataSourceMixin({ kind: kind }),
            // Name is the name of resource being referenced
            withName(name):: self + __dataSourceMixin({ name: name }),
          },
          dataSourceType:: hidden.core.v1.typedLocalObjectReference,
          // Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
          resources:: {
            local __resourcesMixin(resources) = __specMixin({ resources+: resources }),
            mixinInstance(resources):: __resourcesMixin(resources),
            // Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
            withLimits(limits):: self + __resourcesMixin({ limits: limits }),
            // Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
            withLimitsMixin(limits):: self + __resourcesMixin({ limits+: limits }),
            // Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
            withRequests(requests):: self + __resourcesMixin({ requests: requests }),
            // Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
            withRequestsMixin(requests):: self + __resourcesMixin({ requests+: requests }),
          },
          resourcesType:: hidden.core.v1.resourceRequirements,
          // A label query over volumes to consider for binding.
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
          // Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
          withStorageClassName(storageClassName):: self + __specMixin({ storageClassName: storageClassName }),
          // volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. This is a beta feature.
          withVolumeMode(volumeMode):: self + __specMixin({ volumeMode: volumeMode }),
          // VolumeName is the binding reference to the PersistentVolume backing this claim.
          withVolumeName(volumeName):: self + __specMixin({ volumeName: volumeName }),
        },
        specType:: hidden.core.v1.persistentVolumeClaimSpec,
      },
    },
    // Pod is a collection of containers that can run on a host. This resource is created by clients and scheduled onto hosts.
    pod:: {
      local kind = { kind: 'Pod' },
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
        // Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
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
    },
    // PodTemplate describes a template for creating copies of a predefined pod.
    podTemplate:: {
      local kind = { kind: 'PodTemplate' },
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
        // Template defines the pods that will be created from this pod template. https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        template:: {
          local __templateMixin(template) = { template+: template },
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
    },
    // ReplicationController represents the configuration of a replication controller.
    replicationController:: {
      local kind = { kind: 'ReplicationController' },
      new():: apiVersion + kind,
      mixin:: {
        // If the Labels of a ReplicationController are empty, they are defaulted to be the same as the Pod(s) that the replication controller manages. Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
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
        // Spec defines the specification of the desired behavior of the replication controller. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
          withMinReadySeconds(minReadySeconds):: self + __specMixin({ minReadySeconds: minReadySeconds }),
          // Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller
          withReplicas(replicas):: self + __specMixin({ replicas: replicas }),
          // Selector is a label query over pods that should match the Replicas count. If Selector is empty, it is defaulted to the labels present on the Pod template. Label keys and values that must match in order to be controlled by this replication controller, if empty defaulted to labels on Pod template. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
          withSelector(selector):: self + __specMixin({ selector: selector }),
          // Selector is a label query over pods that should match the Replicas count. If Selector is empty, it is defaulted to the labels present on the Pod template. Label keys and values that must match in order to be controlled by this replication controller, if empty defaulted to labels on Pod template. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
          withSelectorMixin(selector):: self + __specMixin({ selector+: selector }),
          // Template is the object that describes the pod that will be created if insufficient replicas are detected. This takes precedence over a TemplateRef. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
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
        specType:: hidden.core.v1.replicationControllerSpec,
      },
    },
    // ResourceQuota sets aggregate quota restrictions enforced per namespace
    resourceQuota:: {
      local kind = { kind: 'ResourceQuota' },
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
        // Spec defines the desired quota. https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // hard is the set of desired hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
          withHard(hard):: self + __specMixin({ hard: hard }),
          // hard is the set of desired hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
          withHardMixin(hard):: self + __specMixin({ hard+: hard }),
          // scopeSelector is also a collection of filters like scopes that must match each object tracked by a quota but expressed using ScopeSelectorOperator in combination with possible values. For a resource to match, both scopes AND scopeSelector (if specified in spec), must be matched.
          scopeSelector:: {
            local __scopeSelectorMixin(scopeSelector) = __specMixin({ scopeSelector+: scopeSelector }),
            mixinInstance(scopeSelector):: __scopeSelectorMixin(scopeSelector),
            // A list of scope selector requirements by scope of the resources.
            withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __scopeSelectorMixin({ matchExpressions: matchExpressions }) else __scopeSelectorMixin({ matchExpressions: [matchExpressions] }),
            // A list of scope selector requirements by scope of the resources.
            withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __scopeSelectorMixin({ matchExpressions+: matchExpressions }) else __scopeSelectorMixin({ matchExpressions+: [matchExpressions] }),
            matchExpressionsType:: hidden.core.v1.scopedResourceSelectorRequirement,
          },
          scopeSelectorType:: hidden.core.v1.scopeSelector,
          // A collection of filters that must match each object tracked by a quota. If not specified, the quota matches all objects.
          withScopes(scopes):: self + if std.type(scopes) == 'array' then __specMixin({ scopes: scopes }) else __specMixin({ scopes: [scopes] }),
          // A collection of filters that must match each object tracked by a quota. If not specified, the quota matches all objects.
          withScopesMixin(scopes):: self + if std.type(scopes) == 'array' then __specMixin({ scopes+: scopes }) else __specMixin({ scopes+: [scopes] }),
        },
        specType:: hidden.core.v1.resourceQuotaSpec,
      },
    },
    // Secret holds secret data of a certain type. The total bytes of the values in the Data field must be less than MaxSecretSize bytes.
    secret:: {
      local kind = { kind: 'Secret' },
      new(name='', data='', type='Opaque'):: apiVersion + kind + self.withData(data).withType(type) + self.mixin.metadata.withName(name),
      // Data contains the secret data. Each key must consist of alphanumeric characters, '-', '_' or '.'. The serialized form of the secret data is a base64 encoded string, representing the arbitrary (possibly non-string) data value here. Described in https://tools.ietf.org/html/rfc4648#section-4
      withData(data):: self + { data: data },
      // Data contains the secret data. Each key must consist of alphanumeric characters, '-', '_' or '.'. The serialized form of the secret data is a base64 encoded string, representing the arbitrary (possibly non-string) data value here. Described in https://tools.ietf.org/html/rfc4648#section-4
      withDataMixin(data):: self + { data+: data },
      // stringData allows specifying non-binary secret data in string form. It is provided as a write-only convenience method. All keys and values are merged into the data field on write, overwriting any existing values. It is never output when reading from the API.
      withStringData(stringData):: self + { stringData: stringData },
      // stringData allows specifying non-binary secret data in string form. It is provided as a write-only convenience method. All keys and values are merged into the data field on write, overwriting any existing values. It is never output when reading from the API.
      withStringDataMixin(stringData):: self + { stringData+: stringData },
      // Used to facilitate programmatic handling of secret data.
      withType(type):: self + { type: type },
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
      },
    },
    // Service is a named abstraction of software service (for example, mysql) consisting of local port (for example 3306) that the proxy listens on, and the selector that determines which pods will answer requests sent through the proxy.
    service:: {
      local kind = { kind: 'Service' },
      new(name='', selector='', ports=''):: apiVersion + kind + self.mixin.metadata.withName(name) + self.mixin.spec.withPorts(ports).withSelector(selector),
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
        // Spec defines the behavior of a service. https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // clusterIP is the IP address of the service and is usually assigned randomly by the master. If an address is specified manually and is not in use by others, it will be allocated to the service; otherwise, creation of the service will fail. This field can not be changed through updates. Valid values are "None", empty string (""), or a valid IP address. "None" can be specified for headless services when proxying is not required. Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if type is ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
          withClusterIp(clusterIp):: self + __specMixin({ clusterIP: clusterIp }),
          // externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.  These IPs are not managed by Kubernetes.  The user is responsible for ensuring that traffic arrives at a node with this IP.  A common example is external load-balancers that are not part of the Kubernetes system.
          withExternalIps(externalIps):: self + if std.type(externalIps) == 'array' then __specMixin({ externalIPs: externalIps }) else __specMixin({ externalIPs: [externalIps] }),
          // externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.  These IPs are not managed by Kubernetes.  The user is responsible for ensuring that traffic arrives at a node with this IP.  A common example is external load-balancers that are not part of the Kubernetes system.
          withExternalIpsMixin(externalIps):: self + if std.type(externalIps) == 'array' then __specMixin({ externalIPs+: externalIps }) else __specMixin({ externalIPs+: [externalIps] }),
          // externalName is the external reference that kubedns or equivalent will return as a CNAME record for this service. No proxying will be involved. Must be a valid RFC-1123 hostname (https://tools.ietf.org/html/rfc1123) and requires Type to be ExternalName.
          withExternalName(externalName):: self + __specMixin({ externalName: externalName }),
          // externalTrafficPolicy denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints. "Local" preserves the client source IP and avoids a second hop for LoadBalancer and Nodeport type services, but risks potentially imbalanced traffic spreading. "Cluster" obscures the client source IP and may cause a second hop to another node, but should have good overall load-spreading.
          withExternalTrafficPolicy(externalTrafficPolicy):: self + __specMixin({ externalTrafficPolicy: externalTrafficPolicy }),
          // healthCheckNodePort specifies the healthcheck nodePort for the service. If not specified, HealthCheckNodePort is created by the service api backend with the allocated nodePort. Will use user-specified nodePort value if specified by the client. Only effects when Type is set to LoadBalancer and ExternalTrafficPolicy is set to Local.
          withHealthCheckNodePort(healthCheckNodePort):: self + __specMixin({ healthCheckNodePort: healthCheckNodePort }),
          // Only applies to Service Type: LoadBalancer LoadBalancer will get created with the IP specified in this field. This feature depends on whether the underlying cloud-provider supports specifying the loadBalancerIP when a load balancer is created. This field will be ignored if the cloud-provider does not support the feature.
          withLoadBalancerIp(loadBalancerIp):: self + __specMixin({ loadBalancerIP: loadBalancerIp }),
          // If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. This field will be ignored if the cloud-provider does not support the feature." More info: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/
          withLoadBalancerSourceRanges(loadBalancerSourceRanges):: self + if std.type(loadBalancerSourceRanges) == 'array' then __specMixin({ loadBalancerSourceRanges: loadBalancerSourceRanges }) else __specMixin({ loadBalancerSourceRanges: [loadBalancerSourceRanges] }),
          // If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. This field will be ignored if the cloud-provider does not support the feature." More info: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/
          withLoadBalancerSourceRangesMixin(loadBalancerSourceRanges):: self + if std.type(loadBalancerSourceRanges) == 'array' then __specMixin({ loadBalancerSourceRanges+: loadBalancerSourceRanges }) else __specMixin({ loadBalancerSourceRanges+: [loadBalancerSourceRanges] }),
          // The list of ports that are exposed by this service. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
          withPorts(ports):: self + if std.type(ports) == 'array' then __specMixin({ ports: ports }) else __specMixin({ ports: [ports] }),
          // The list of ports that are exposed by this service. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
          withPortsMixin(ports):: self + if std.type(ports) == 'array' then __specMixin({ ports+: ports }) else __specMixin({ ports+: [ports] }),
          portsType:: hidden.core.v1.servicePort,
          // publishNotReadyAddresses, when set to true, indicates that DNS implementations must publish the notReadyAddresses of subsets for the Endpoints associated with the Service. The default value is false. The primary use case for setting this field is to use a StatefulSet's Headless Service to propagate SRV records for its Pods without respect to their readiness for purpose of peer discovery.
          withPublishNotReadyAddresses(publishNotReadyAddresses):: self + __specMixin({ publishNotReadyAddresses: publishNotReadyAddresses }),
          // Route service traffic to pods with label keys and values matching this selector. If empty or not present, the service is assumed to have an external process managing its endpoints, which Kubernetes will not modify. Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if type is ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/
          withSelector(selector):: self + __specMixin({ selector: selector }),
          // Route service traffic to pods with label keys and values matching this selector. If empty or not present, the service is assumed to have an external process managing its endpoints, which Kubernetes will not modify. Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if type is ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/
          withSelectorMixin(selector):: self + __specMixin({ selector+: selector }),
          // Supports "ClientIP" and "None". Used to maintain session affinity. Enable client IP based session affinity. Must be ClientIP or None. Defaults to None. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
          withSessionAffinity(sessionAffinity):: self + __specMixin({ sessionAffinity: sessionAffinity }),
          // sessionAffinityConfig contains the configurations of session affinity.
          sessionAffinityConfig:: {
            local __sessionAffinityConfigMixin(sessionAffinityConfig) = __specMixin({ sessionAffinityConfig+: sessionAffinityConfig }),
            mixinInstance(sessionAffinityConfig):: __sessionAffinityConfigMixin(sessionAffinityConfig),
            // clientIP contains the configurations of Client IP based session affinity.
            clientIp:: {
              local __clientIpMixin(clientIp) = __sessionAffinityConfigMixin({ clientIp+: clientIp }),
              mixinInstance(clientIp):: __clientIpMixin(clientIp),
              // timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == "ClientIP". Default value is 10800(for 3 hours).
              withTimeoutSeconds(timeoutSeconds):: self + __clientIpMixin({ timeoutSeconds: timeoutSeconds }),
            },
            clientIPType:: hidden.core.v1.clientIpConfig,
          },
          sessionAffinityConfigType:: hidden.core.v1.sessionAffinityConfig,
          // type determines how the Service is exposed. Defaults to ClusterIP. Valid options are ExternalName, ClusterIP, NodePort, and LoadBalancer. "ExternalName" maps to the specified externalName. "ClusterIP" allocates a cluster-internal IP address for load-balancing to endpoints. Endpoints are determined by the selector or if that is not specified, by manual construction of an Endpoints object. If clusterIP is "None", no virtual IP is allocated and the endpoints are published as a set of endpoints rather than a stable IP. "NodePort" builds on ClusterIP and allocates a port on every node which routes to the clusterIP. "LoadBalancer" builds on NodePort and creates an external load-balancer (if supported in the current cloud) which routes to the clusterIP. More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
          withType(type):: self + __specMixin({ type: type }),
        },
        specType:: hidden.core.v1.serviceSpec,
      },
    },
    // ServiceAccount binds together: * a name, understood by users, and perhaps by peripheral systems, for an identity * a principal that can be authenticated and authorized * a set of secrets
    serviceAccount:: {
      local kind = { kind: 'ServiceAccount' },
      new(name=''):: apiVersion + kind + self.mixin.metadata.withName(name),
      // AutomountServiceAccountToken indicates whether pods running as this service account should have an API token automatically mounted. Can be overridden at the pod level.
      withAutomountServiceAccountToken(automountServiceAccountToken):: self + { automountServiceAccountToken: automountServiceAccountToken },
      // ImagePullSecrets is a list of references to secrets in the same namespace to use for pulling any images in pods that reference this ServiceAccount. ImagePullSecrets are distinct from Secrets because Secrets can be mounted in the pod, but ImagePullSecrets are only accessed by the kubelet. More info: https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod
      withImagePullSecrets(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then { imagePullSecrets: imagePullSecrets } else { imagePullSecrets: [imagePullSecrets] },
      // ImagePullSecrets is a list of references to secrets in the same namespace to use for pulling any images in pods that reference this ServiceAccount. ImagePullSecrets are distinct from Secrets because Secrets can be mounted in the pod, but ImagePullSecrets are only accessed by the kubelet. More info: https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod
      withImagePullSecretsMixin(imagePullSecrets):: self + if std.type(imagePullSecrets) == 'array' then { imagePullSecrets+: imagePullSecrets } else { imagePullSecrets+: [imagePullSecrets] },
      imagePullSecretsType:: hidden.core.v1.localObjectReference,
      // Secrets is the list of secrets allowed to be used by pods running using this ServiceAccount. More info: https://kubernetes.io/docs/concepts/configuration/secret
      withSecrets(secrets):: self + if std.type(secrets) == 'array' then { secrets: secrets } else { secrets: [secrets] },
      // Secrets is the list of secrets allowed to be used by pods running using this ServiceAccount. More info: https://kubernetes.io/docs/concepts/configuration/secret
      withSecretsMixin(secrets):: self + if std.type(secrets) == 'array' then { secrets+: secrets } else { secrets+: [secrets] },
      secretsType:: hidden.core.v1.objectReference,
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
      },
    },
  },
}