{
  storage:: {
    v1:: {
      local apiVersion = { apiVersion: 'storage.k8s.io/v1' },
      // CSINode holds information about all CSI drivers installed on a node. CSI drivers do not need to create the CSINode object directly. As long as they use the node-driver-registrar sidecar container, the kubelet will automatically populate the CSINode object for the CSI driver as part of kubelet plugin registration. CSINode has the same name as a node. If the object is missing, it means either there are no CSI Drivers available on the node, or the Kubelet version is low enough that it doesn't create this object. CSINode has an OwnerReference that points to the corresponding node object.
      csiNode:: {
        local kind = { kind: 'CSINode' },
        new():: apiVersion + kind,
        mixin:: {
          // metadata.name must be the Kubernetes node name.
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
          // spec is the specification of CSINode
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty.
            withDrivers(drivers):: self + if std.type(drivers) == 'array' then __specMixin({ drivers: drivers }) else __specMixin({ drivers: [drivers] }),
            // drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty.
            withDriversMixin(drivers):: self + if std.type(drivers) == 'array' then __specMixin({ drivers+: drivers }) else __specMixin({ drivers+: [drivers] }),
            driversType:: hidden.storage.v1.csiNodeDriver,
          },
          specType:: hidden.storage.v1.csiNodeSpec,
        },
      },
      // StorageClass describes the parameters for a class of storage for which PersistentVolumes can be dynamically provisioned.
      //
      // StorageClasses are non-namespaced; the name of the storage class according to etcd is in ObjectMeta.Name.
      storageClass:: {
        local kind = { kind: 'StorageClass' },
        new():: apiVersion + kind,
        // AllowVolumeExpansion shows whether the storage class allow volume expand
        withAllowVolumeExpansion(allowVolumeExpansion):: self + { allowVolumeExpansion: allowVolumeExpansion },
        // Restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
        withAllowedTopologies(allowedTopologies):: self + if std.type(allowedTopologies) == 'array' then { allowedTopologies: allowedTopologies } else { allowedTopologies: [allowedTopologies] },
        // Restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
        withAllowedTopologiesMixin(allowedTopologies):: self + if std.type(allowedTopologies) == 'array' then { allowedTopologies+: allowedTopologies } else { allowedTopologies+: [allowedTopologies] },
        allowedTopologiesType:: hidden.core.v1.topologySelectorTerm,
        // Dynamically provisioned PersistentVolumes of this storage class are created with these mountOptions, e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
        withMountOptions(mountOptions):: self + if std.type(mountOptions) == 'array' then { mountOptions: mountOptions } else { mountOptions: [mountOptions] },
        // Dynamically provisioned PersistentVolumes of this storage class are created with these mountOptions, e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
        withMountOptionsMixin(mountOptions):: self + if std.type(mountOptions) == 'array' then { mountOptions+: mountOptions } else { mountOptions+: [mountOptions] },
        // Parameters holds the parameters for the provisioner that should create volumes of this storage class.
        withParameters(parameters):: self + { parameters: parameters },
        // Parameters holds the parameters for the provisioner that should create volumes of this storage class.
        withParametersMixin(parameters):: self + { parameters+: parameters },
        // Provisioner indicates the type of the provisioner.
        withProvisioner(provisioner):: self + { provisioner: provisioner },
        // Dynamically provisioned PersistentVolumes of this storage class are created with this reclaimPolicy. Defaults to Delete.
        withReclaimPolicy(reclaimPolicy):: self + { reclaimPolicy: reclaimPolicy },
        // VolumeBindingMode indicates how PersistentVolumeClaims should be provisioned and bound.  When unset, VolumeBindingImmediate is used. This field is only honored by servers that enable the VolumeScheduling feature.
        withVolumeBindingMode(volumeBindingMode):: self + { volumeBindingMode: volumeBindingMode },
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
        },
      },
      // VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node.
      //
      // VolumeAttachment objects are non-namespaced.
      volumeAttachment:: {
        local kind = { kind: 'VolumeAttachment' },
        new():: apiVersion + kind,
        mixin:: {
          // Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          // Specification of the desired attach/detach volume behavior. Populated by the Kubernetes system.
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // Attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().
            withAttacher(attacher):: self + __specMixin({ attacher: attacher }),
            // The node that the volume should be attached to.
            withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
            // Source represents the volume that should be attached.
            source:: {
              local __sourceMixin(source) = __specMixin({ source+: source }),
              mixinInstance(source):: __sourceMixin(source),
              // inlineVolumeSpec contains all the information necessary to attach a persistent volume defined by a pod's inline VolumeSource. This field is populated only for the CSIMigration feature. It contains translated fields from a pod's inline VolumeSource to a PersistentVolumeSpec. This field is alpha-level and is only honored by servers that enabled the CSIMigration feature.
              inlineVolumeSpec:: {
                local __inlineVolumeSpecMixin(inlineVolumeSpec) = __sourceMixin({ inlineVolumeSpec+: inlineVolumeSpec }),
                mixinInstance(inlineVolumeSpec):: __inlineVolumeSpecMixin(inlineVolumeSpec),
                // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
                withAccessModes(accessModes):: self + if std.type(accessModes) == 'array' then __inlineVolumeSpecMixin({ accessModes: accessModes }) else __inlineVolumeSpecMixin({ accessModes: [accessModes] }),
                // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
                withAccessModesMixin(accessModes):: self + if std.type(accessModes) == 'array' then __inlineVolumeSpecMixin({ accessModes+: accessModes }) else __inlineVolumeSpecMixin({ accessModes+: [accessModes] }),
                // AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                awsElasticBlockStore:: {
                  local __awsElasticBlockStoreMixin(awsElasticBlockStore) = __inlineVolumeSpecMixin({ awsElasticBlockStore+: awsElasticBlockStore }),
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
                  local __azureDiskMixin(azureDisk) = __inlineVolumeSpecMixin({ azureDisk+: azureDisk }),
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
                  local __azureFileMixin(azureFile) = __inlineVolumeSpecMixin({ azureFile+: azureFile }),
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
                withCapacity(capacity):: self + __inlineVolumeSpecMixin({ capacity: capacity }),
                // A description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
                withCapacityMixin(capacity):: self + __inlineVolumeSpecMixin({ capacity+: capacity }),
                // CephFS represents a Ceph FS mount on the host that shares a pod's lifetime
                cephfs:: {
                  local __cephfsMixin(cephfs) = __inlineVolumeSpecMixin({ cephfs+: cephfs }),
                  mixinInstance(cephfs):: __cephfsMixin(cephfs),
                  // Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withMonitors(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors: monitors }) else __cephfsMixin({ monitors: [monitors] }),
                  // Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors+: monitors }) else __cephfsMixin({ monitors+: [monitors] }),
                  // Optional: Used as the mounted root, rather than the full Ceph tree, default is /
                  withPath(path):: self + __cephfsMixin({ path: path }),
                  // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withReadOnly(readOnly):: self + __cephfsMixin({ readOnly: readOnly }),
                  // Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withSecretFile(secretFile):: self + __cephfsMixin({ secretFile: secretFile }),
                  // Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  secretRef:: {
                    local __secretRefMixin(secretRef) = __cephfsMixin({ secretRef+: secretRef }),
                    mixinInstance(secretRef):: __secretRefMixin(secretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __secretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
                  },
                  secretRefType:: hidden.core.v1.secretReference,
                  // Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withUser(user):: self + __cephfsMixin({ user: user }),
                },
                cephfsType:: hidden.core.v1.cephFsPersistentVolumeSource,
                // Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                cinder:: {
                  local __cinderMixin(cinder) = __inlineVolumeSpecMixin({ cinder+: cinder }),
                  mixinInstance(cinder):: __cinderMixin(cinder),
                  // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                  withFsType(fsType):: self + __cinderMixin({ fsType: fsType }),
                  // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
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
                  // volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                  withVolumeId(volumeId):: self + __cinderMixin({ volumeID: volumeId }),
                },
                cinderType:: hidden.core.v1.cinderPersistentVolumeSource,
                // ClaimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
                claimRef:: {
                  local __claimRefMixin(claimRef) = __inlineVolumeSpecMixin({ claimRef+: claimRef }),
                  mixinInstance(claimRef):: __claimRefMixin(claimRef),
                  // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
                  withFieldPath(fieldPath):: self + __claimRefMixin({ fieldPath: fieldPath }),
                  // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                  withName(name):: self + __claimRefMixin({ name: name }),
                  // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
                  withNamespace(namespace):: self + __claimRefMixin({ namespace: namespace }),
                  // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
                  withResourceVersion(resourceVersion):: self + __claimRefMixin({ resourceVersion: resourceVersion }),
                  // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
                  withUid(uid):: self + __claimRefMixin({ uid: uid }),
                },
                claimRefType:: hidden.core.v1.objectReference,
                // CSI represents storage that is handled by an external CSI driver (Beta feature).
                csi:: {
                  local __csiMixin(csi) = __inlineVolumeSpecMixin({ csi+: csi }),
                  mixinInstance(csi):: __csiMixin(csi),
                  // ControllerExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerExpandVolume call. This is an alpha field and requires enabling ExpandCSIVolumes feature gate. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
                  controllerExpandSecretRef:: {
                    local __controllerExpandSecretRefMixin(controllerExpandSecretRef) = __csiMixin({ controllerExpandSecretRef+: controllerExpandSecretRef }),
                    mixinInstance(controllerExpandSecretRef):: __controllerExpandSecretRefMixin(controllerExpandSecretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __controllerExpandSecretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __controllerExpandSecretRefMixin({ namespace: namespace }),
                  },
                  controllerExpandSecretRefType:: hidden.core.v1.secretReference,
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
                  local __fcMixin(fc) = __inlineVolumeSpecMixin({ fc+: fc }),
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
                  local __flexVolumeMixin(flexVolume) = __inlineVolumeSpecMixin({ flexVolume+: flexVolume }),
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
                  local __flockerMixin(flocker) = __inlineVolumeSpecMixin({ flocker+: flocker }),
                  mixinInstance(flocker):: __flockerMixin(flocker),
                  // Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
                  withDatasetName(datasetName):: self + __flockerMixin({ datasetName: datasetName }),
                  // UUID of the dataset. This is unique identifier of a Flocker dataset
                  withDatasetUuid(datasetUuid):: self + __flockerMixin({ datasetUUID: datasetUuid }),
                },
                flockerType:: hidden.core.v1.flockerVolumeSource,
                // GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                gcePersistentDisk:: {
                  local __gcePersistentDiskMixin(gcePersistentDisk) = __inlineVolumeSpecMixin({ gcePersistentDisk+: gcePersistentDisk }),
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
                // Glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. More info: https://examples.k8s.io/volumes/glusterfs/README.md
                glusterfs:: {
                  local __glusterfsMixin(glusterfs) = __inlineVolumeSpecMixin({ glusterfs+: glusterfs }),
                  mixinInstance(glusterfs):: __glusterfsMixin(glusterfs),
                  // EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withEndpoints(endpoints):: self + __glusterfsMixin({ endpoints: endpoints }),
                  // EndpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withEndpointsNamespace(endpointsNamespace):: self + __glusterfsMixin({ endpointsNamespace: endpointsNamespace }),
                  // Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withPath(path):: self + __glusterfsMixin({ path: path }),
                  // ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withReadOnly(readOnly):: self + __glusterfsMixin({ readOnly: readOnly }),
                },
                glusterfsType:: hidden.core.v1.glusterfsPersistentVolumeSource,
                // HostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                hostPath:: {
                  local __hostPathMixin(hostPath) = __inlineVolumeSpecMixin({ hostPath+: hostPath }),
                  mixinInstance(hostPath):: __hostPathMixin(hostPath),
                  // Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                  withPath(path):: self + __hostPathMixin({ path: path }),
                  // Type for HostPath Volume Defaults to "" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                  withType(type):: self + __hostPathMixin({ type: type }),
                },
                hostPathType:: hidden.core.v1.hostPathVolumeSource,
                // ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
                iscsi:: {
                  local __iscsiMixin(iscsi) = __inlineVolumeSpecMixin({ iscsi+: iscsi }),
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
                  local __localStorageMixin(localStorage) = __inlineVolumeSpecMixin({ localStorage+: localStorage }),
                  mixinInstance(localStorage):: __localStorageMixin(localStorage),
                  // Filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a fileystem if unspecified.
                  withFsType(fsType):: self + __localStorageMixin({ fsType: fsType }),
                  // The full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).
                  withPath(path):: self + __localStorageMixin({ path: path }),
                },
                localType:: hidden.core.v1.localVolumeSource,
                // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
                withMountOptions(mountOptions):: self + if std.type(mountOptions) == 'array' then __inlineVolumeSpecMixin({ mountOptions: mountOptions }) else __inlineVolumeSpecMixin({ mountOptions: [mountOptions] }),
                // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
                withMountOptionsMixin(mountOptions):: self + if std.type(mountOptions) == 'array' then __inlineVolumeSpecMixin({ mountOptions+: mountOptions }) else __inlineVolumeSpecMixin({ mountOptions+: [mountOptions] }),
                // NFS represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                nfs:: {
                  local __nfsMixin(nfs) = __inlineVolumeSpecMixin({ nfs+: nfs }),
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
                  local __nodeAffinityMixin(nodeAffinity) = __inlineVolumeSpecMixin({ nodeAffinity+: nodeAffinity }),
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
                withPersistentVolumeReclaimPolicy(persistentVolumeReclaimPolicy):: self + __inlineVolumeSpecMixin({ persistentVolumeReclaimPolicy: persistentVolumeReclaimPolicy }),
                // PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine
                photonPersistentDisk:: {
                  local __photonPersistentDiskMixin(photonPersistentDisk) = __inlineVolumeSpecMixin({ photonPersistentDisk+: photonPersistentDisk }),
                  mixinInstance(photonPersistentDisk):: __photonPersistentDiskMixin(photonPersistentDisk),
                  // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                  withFsType(fsType):: self + __photonPersistentDiskMixin({ fsType: fsType }),
                  // ID that identifies Photon Controller persistent disk
                  withPdId(pdId):: self + __photonPersistentDiskMixin({ pdID: pdId }),
                },
                photonPersistentDiskType:: hidden.core.v1.photonPersistentDiskVolumeSource,
                // PortworxVolume represents a portworx volume attached and mounted on kubelets host machine
                portworxVolume:: {
                  local __portworxVolumeMixin(portworxVolume) = __inlineVolumeSpecMixin({ portworxVolume+: portworxVolume }),
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
                  local __quobyteMixin(quobyte) = __inlineVolumeSpecMixin({ quobyte+: quobyte }),
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
                // RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md
                rbd:: {
                  local __rbdMixin(rbd) = __inlineVolumeSpecMixin({ rbd+: rbd }),
                  mixinInstance(rbd):: __rbdMixin(rbd),
                  // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
                  withFsType(fsType):: self + __rbdMixin({ fsType: fsType }),
                  // The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withImage(image):: self + __rbdMixin({ image: image }),
                  // Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withKeyring(keyring):: self + __rbdMixin({ keyring: keyring }),
                  // A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withMonitors(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors: monitors }) else __rbdMixin({ monitors: [monitors] }),
                  // A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors+: monitors }) else __rbdMixin({ monitors+: [monitors] }),
                  // The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withPool(pool):: self + __rbdMixin({ pool: pool }),
                  // ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withReadOnly(readOnly):: self + __rbdMixin({ readOnly: readOnly }),
                  // SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  secretRef:: {
                    local __secretRefMixin(secretRef) = __rbdMixin({ secretRef+: secretRef }),
                    mixinInstance(secretRef):: __secretRefMixin(secretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __secretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
                  },
                  secretRefType:: hidden.core.v1.secretReference,
                  // The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withUser(user):: self + __rbdMixin({ user: user }),
                },
                rbdType:: hidden.core.v1.rbdPersistentVolumeSource,
                // ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
                scaleIo:: {
                  local __scaleIoMixin(scaleIo) = __inlineVolumeSpecMixin({ scaleIo+: scaleIo }),
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
                withStorageClassName(storageClassName):: self + __inlineVolumeSpecMixin({ storageClassName: storageClassName }),
                // StorageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod More info: https://examples.k8s.io/volumes/storageos/README.md
                storageos:: {
                  local __storageosMixin(storageos) = __inlineVolumeSpecMixin({ storageos+: storageos }),
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
                    // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
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
                withVolumeMode(volumeMode):: self + __inlineVolumeSpecMixin({ volumeMode: volumeMode }),
                // VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine
                vsphereVolume:: {
                  local __vsphereVolumeMixin(vsphereVolume) = __inlineVolumeSpecMixin({ vsphereVolume+: vsphereVolume }),
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
              inlineVolumeSpecType:: hidden.core.v1.persistentVolumeSpec,
              // Name of the persistent volume to attach.
              withPersistentVolumeName(persistentVolumeName):: self + __sourceMixin({ persistentVolumeName: persistentVolumeName }),
            },
            sourceType:: hidden.storage.v1.volumeAttachmentSource,
          },
          specType:: hidden.storage.v1.volumeAttachmentSpec,
        },
      },
    },
    v1alpha1:: {
      local apiVersion = { apiVersion: 'storage.k8s.io/v1alpha1' },
      // VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node.
      //
      // VolumeAttachment objects are non-namespaced.
      volumeAttachment:: {
        local kind = { kind: 'VolumeAttachment' },
        new():: apiVersion + kind,
        mixin:: {
          // Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          // Specification of the desired attach/detach volume behavior. Populated by the Kubernetes system.
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // Attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().
            withAttacher(attacher):: self + __specMixin({ attacher: attacher }),
            // The node that the volume should be attached to.
            withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
            // Source represents the volume that should be attached.
            source:: {
              local __sourceMixin(source) = __specMixin({ source+: source }),
              mixinInstance(source):: __sourceMixin(source),
              // inlineVolumeSpec contains all the information necessary to attach a persistent volume defined by a pod's inline VolumeSource. This field is populated only for the CSIMigration feature. It contains translated fields from a pod's inline VolumeSource to a PersistentVolumeSpec. This field is alpha-level and is only honored by servers that enabled the CSIMigration feature.
              inlineVolumeSpec:: {
                local __inlineVolumeSpecMixin(inlineVolumeSpec) = __sourceMixin({ inlineVolumeSpec+: inlineVolumeSpec }),
                mixinInstance(inlineVolumeSpec):: __inlineVolumeSpecMixin(inlineVolumeSpec),
                // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
                withAccessModes(accessModes):: self + if std.type(accessModes) == 'array' then __inlineVolumeSpecMixin({ accessModes: accessModes }) else __inlineVolumeSpecMixin({ accessModes: [accessModes] }),
                // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
                withAccessModesMixin(accessModes):: self + if std.type(accessModes) == 'array' then __inlineVolumeSpecMixin({ accessModes+: accessModes }) else __inlineVolumeSpecMixin({ accessModes+: [accessModes] }),
                // AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                awsElasticBlockStore:: {
                  local __awsElasticBlockStoreMixin(awsElasticBlockStore) = __inlineVolumeSpecMixin({ awsElasticBlockStore+: awsElasticBlockStore }),
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
                  local __azureDiskMixin(azureDisk) = __inlineVolumeSpecMixin({ azureDisk+: azureDisk }),
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
                  local __azureFileMixin(azureFile) = __inlineVolumeSpecMixin({ azureFile+: azureFile }),
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
                withCapacity(capacity):: self + __inlineVolumeSpecMixin({ capacity: capacity }),
                // A description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
                withCapacityMixin(capacity):: self + __inlineVolumeSpecMixin({ capacity+: capacity }),
                // CephFS represents a Ceph FS mount on the host that shares a pod's lifetime
                cephfs:: {
                  local __cephfsMixin(cephfs) = __inlineVolumeSpecMixin({ cephfs+: cephfs }),
                  mixinInstance(cephfs):: __cephfsMixin(cephfs),
                  // Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withMonitors(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors: monitors }) else __cephfsMixin({ monitors: [monitors] }),
                  // Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors+: monitors }) else __cephfsMixin({ monitors+: [monitors] }),
                  // Optional: Used as the mounted root, rather than the full Ceph tree, default is /
                  withPath(path):: self + __cephfsMixin({ path: path }),
                  // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withReadOnly(readOnly):: self + __cephfsMixin({ readOnly: readOnly }),
                  // Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withSecretFile(secretFile):: self + __cephfsMixin({ secretFile: secretFile }),
                  // Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  secretRef:: {
                    local __secretRefMixin(secretRef) = __cephfsMixin({ secretRef+: secretRef }),
                    mixinInstance(secretRef):: __secretRefMixin(secretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __secretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
                  },
                  secretRefType:: hidden.core.v1.secretReference,
                  // Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withUser(user):: self + __cephfsMixin({ user: user }),
                },
                cephfsType:: hidden.core.v1.cephFsPersistentVolumeSource,
                // Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                cinder:: {
                  local __cinderMixin(cinder) = __inlineVolumeSpecMixin({ cinder+: cinder }),
                  mixinInstance(cinder):: __cinderMixin(cinder),
                  // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                  withFsType(fsType):: self + __cinderMixin({ fsType: fsType }),
                  // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
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
                  // volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                  withVolumeId(volumeId):: self + __cinderMixin({ volumeID: volumeId }),
                },
                cinderType:: hidden.core.v1.cinderPersistentVolumeSource,
                // ClaimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
                claimRef:: {
                  local __claimRefMixin(claimRef) = __inlineVolumeSpecMixin({ claimRef+: claimRef }),
                  mixinInstance(claimRef):: __claimRefMixin(claimRef),
                  // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
                  withFieldPath(fieldPath):: self + __claimRefMixin({ fieldPath: fieldPath }),
                  // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                  withName(name):: self + __claimRefMixin({ name: name }),
                  // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
                  withNamespace(namespace):: self + __claimRefMixin({ namespace: namespace }),
                  // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
                  withResourceVersion(resourceVersion):: self + __claimRefMixin({ resourceVersion: resourceVersion }),
                  // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
                  withUid(uid):: self + __claimRefMixin({ uid: uid }),
                },
                claimRefType:: hidden.core.v1.objectReference,
                // CSI represents storage that is handled by an external CSI driver (Beta feature).
                csi:: {
                  local __csiMixin(csi) = __inlineVolumeSpecMixin({ csi+: csi }),
                  mixinInstance(csi):: __csiMixin(csi),
                  // ControllerExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerExpandVolume call. This is an alpha field and requires enabling ExpandCSIVolumes feature gate. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
                  controllerExpandSecretRef:: {
                    local __controllerExpandSecretRefMixin(controllerExpandSecretRef) = __csiMixin({ controllerExpandSecretRef+: controllerExpandSecretRef }),
                    mixinInstance(controllerExpandSecretRef):: __controllerExpandSecretRefMixin(controllerExpandSecretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __controllerExpandSecretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __controllerExpandSecretRefMixin({ namespace: namespace }),
                  },
                  controllerExpandSecretRefType:: hidden.core.v1.secretReference,
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
                  local __fcMixin(fc) = __inlineVolumeSpecMixin({ fc+: fc }),
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
                  local __flexVolumeMixin(flexVolume) = __inlineVolumeSpecMixin({ flexVolume+: flexVolume }),
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
                  local __flockerMixin(flocker) = __inlineVolumeSpecMixin({ flocker+: flocker }),
                  mixinInstance(flocker):: __flockerMixin(flocker),
                  // Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
                  withDatasetName(datasetName):: self + __flockerMixin({ datasetName: datasetName }),
                  // UUID of the dataset. This is unique identifier of a Flocker dataset
                  withDatasetUuid(datasetUuid):: self + __flockerMixin({ datasetUUID: datasetUuid }),
                },
                flockerType:: hidden.core.v1.flockerVolumeSource,
                // GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                gcePersistentDisk:: {
                  local __gcePersistentDiskMixin(gcePersistentDisk) = __inlineVolumeSpecMixin({ gcePersistentDisk+: gcePersistentDisk }),
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
                // Glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. More info: https://examples.k8s.io/volumes/glusterfs/README.md
                glusterfs:: {
                  local __glusterfsMixin(glusterfs) = __inlineVolumeSpecMixin({ glusterfs+: glusterfs }),
                  mixinInstance(glusterfs):: __glusterfsMixin(glusterfs),
                  // EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withEndpoints(endpoints):: self + __glusterfsMixin({ endpoints: endpoints }),
                  // EndpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withEndpointsNamespace(endpointsNamespace):: self + __glusterfsMixin({ endpointsNamespace: endpointsNamespace }),
                  // Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withPath(path):: self + __glusterfsMixin({ path: path }),
                  // ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withReadOnly(readOnly):: self + __glusterfsMixin({ readOnly: readOnly }),
                },
                glusterfsType:: hidden.core.v1.glusterfsPersistentVolumeSource,
                // HostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                hostPath:: {
                  local __hostPathMixin(hostPath) = __inlineVolumeSpecMixin({ hostPath+: hostPath }),
                  mixinInstance(hostPath):: __hostPathMixin(hostPath),
                  // Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                  withPath(path):: self + __hostPathMixin({ path: path }),
                  // Type for HostPath Volume Defaults to "" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                  withType(type):: self + __hostPathMixin({ type: type }),
                },
                hostPathType:: hidden.core.v1.hostPathVolumeSource,
                // ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
                iscsi:: {
                  local __iscsiMixin(iscsi) = __inlineVolumeSpecMixin({ iscsi+: iscsi }),
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
                  local __localStorageMixin(localStorage) = __inlineVolumeSpecMixin({ localStorage+: localStorage }),
                  mixinInstance(localStorage):: __localStorageMixin(localStorage),
                  // Filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a fileystem if unspecified.
                  withFsType(fsType):: self + __localStorageMixin({ fsType: fsType }),
                  // The full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).
                  withPath(path):: self + __localStorageMixin({ path: path }),
                },
                localType:: hidden.core.v1.localVolumeSource,
                // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
                withMountOptions(mountOptions):: self + if std.type(mountOptions) == 'array' then __inlineVolumeSpecMixin({ mountOptions: mountOptions }) else __inlineVolumeSpecMixin({ mountOptions: [mountOptions] }),
                // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
                withMountOptionsMixin(mountOptions):: self + if std.type(mountOptions) == 'array' then __inlineVolumeSpecMixin({ mountOptions+: mountOptions }) else __inlineVolumeSpecMixin({ mountOptions+: [mountOptions] }),
                // NFS represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                nfs:: {
                  local __nfsMixin(nfs) = __inlineVolumeSpecMixin({ nfs+: nfs }),
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
                  local __nodeAffinityMixin(nodeAffinity) = __inlineVolumeSpecMixin({ nodeAffinity+: nodeAffinity }),
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
                withPersistentVolumeReclaimPolicy(persistentVolumeReclaimPolicy):: self + __inlineVolumeSpecMixin({ persistentVolumeReclaimPolicy: persistentVolumeReclaimPolicy }),
                // PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine
                photonPersistentDisk:: {
                  local __photonPersistentDiskMixin(photonPersistentDisk) = __inlineVolumeSpecMixin({ photonPersistentDisk+: photonPersistentDisk }),
                  mixinInstance(photonPersistentDisk):: __photonPersistentDiskMixin(photonPersistentDisk),
                  // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                  withFsType(fsType):: self + __photonPersistentDiskMixin({ fsType: fsType }),
                  // ID that identifies Photon Controller persistent disk
                  withPdId(pdId):: self + __photonPersistentDiskMixin({ pdID: pdId }),
                },
                photonPersistentDiskType:: hidden.core.v1.photonPersistentDiskVolumeSource,
                // PortworxVolume represents a portworx volume attached and mounted on kubelets host machine
                portworxVolume:: {
                  local __portworxVolumeMixin(portworxVolume) = __inlineVolumeSpecMixin({ portworxVolume+: portworxVolume }),
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
                  local __quobyteMixin(quobyte) = __inlineVolumeSpecMixin({ quobyte+: quobyte }),
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
                // RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md
                rbd:: {
                  local __rbdMixin(rbd) = __inlineVolumeSpecMixin({ rbd+: rbd }),
                  mixinInstance(rbd):: __rbdMixin(rbd),
                  // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
                  withFsType(fsType):: self + __rbdMixin({ fsType: fsType }),
                  // The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withImage(image):: self + __rbdMixin({ image: image }),
                  // Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withKeyring(keyring):: self + __rbdMixin({ keyring: keyring }),
                  // A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withMonitors(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors: monitors }) else __rbdMixin({ monitors: [monitors] }),
                  // A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors+: monitors }) else __rbdMixin({ monitors+: [monitors] }),
                  // The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withPool(pool):: self + __rbdMixin({ pool: pool }),
                  // ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withReadOnly(readOnly):: self + __rbdMixin({ readOnly: readOnly }),
                  // SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  secretRef:: {
                    local __secretRefMixin(secretRef) = __rbdMixin({ secretRef+: secretRef }),
                    mixinInstance(secretRef):: __secretRefMixin(secretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __secretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
                  },
                  secretRefType:: hidden.core.v1.secretReference,
                  // The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withUser(user):: self + __rbdMixin({ user: user }),
                },
                rbdType:: hidden.core.v1.rbdPersistentVolumeSource,
                // ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
                scaleIo:: {
                  local __scaleIoMixin(scaleIo) = __inlineVolumeSpecMixin({ scaleIo+: scaleIo }),
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
                withStorageClassName(storageClassName):: self + __inlineVolumeSpecMixin({ storageClassName: storageClassName }),
                // StorageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod More info: https://examples.k8s.io/volumes/storageos/README.md
                storageos:: {
                  local __storageosMixin(storageos) = __inlineVolumeSpecMixin({ storageos+: storageos }),
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
                    // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
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
                withVolumeMode(volumeMode):: self + __inlineVolumeSpecMixin({ volumeMode: volumeMode }),
                // VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine
                vsphereVolume:: {
                  local __vsphereVolumeMixin(vsphereVolume) = __inlineVolumeSpecMixin({ vsphereVolume+: vsphereVolume }),
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
              inlineVolumeSpecType:: hidden.core.v1.persistentVolumeSpec,
              // Name of the persistent volume to attach.
              withPersistentVolumeName(persistentVolumeName):: self + __sourceMixin({ persistentVolumeName: persistentVolumeName }),
            },
            sourceType:: hidden.storage.v1alpha1.volumeAttachmentSource,
          },
          specType:: hidden.storage.v1alpha1.volumeAttachmentSpec,
        },
      },
    },
    v1beta1:: {
      local apiVersion = { apiVersion: 'storage.k8s.io/v1beta1' },
      // CSIDriver captures information about a Container Storage Interface (CSI) volume driver deployed on the cluster. CSI drivers do not need to create the CSIDriver object directly. Instead they may use the cluster-driver-registrar sidecar container. When deployed with a CSI driver it automatically creates a CSIDriver object representing the driver. Kubernetes attach detach controller uses this object to determine whether attach is required. Kubelet uses this object to determine whether pod information needs to be passed on mount. CSIDriver objects are non-namespaced.
      csiDriver:: {
        local kind = { kind: 'CSIDriver' },
        new():: apiVersion + kind,
        mixin:: {
          // Standard object metadata. metadata.Name indicates the name of the CSI driver that this object refers to; it MUST be the same name returned by the CSI GetPluginName() call for that driver. The driver name must be 63 characters or less, beginning and ending with an alphanumeric character ([a-z0-9A-Z]) with dashes (-), dots (.), and alphanumerics between. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          // Specification of the CSI Driver.
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // attachRequired indicates this CSI volume driver requires an attach operation (because it implements the CSI ControllerPublishVolume() method), and that the Kubernetes attach detach controller should call the attach volume interface which checks the volumeattachment status and waits until the volume is attached before proceeding to mounting. The CSI external-attacher coordinates with CSI volume driver and updates the volumeattachment status when the attach operation is complete. If the CSIDriverRegistry feature gate is enabled and the value is specified to false, the attach operation will be skipped. Otherwise the attach operation will be called.
            withAttachRequired(attachRequired):: self + __specMixin({ attachRequired: attachRequired }),
            // If set to true, podInfoOnMount indicates this CSI volume driver requires additional pod information (like podName, podUID, etc.) during mount operations. If set to false, pod information will not be passed on mount. Default is false. The CSI driver specifies podInfoOnMount as part of driver deployment. If true, Kubelet will pass pod information as VolumeContext in the CSI NodePublishVolume() calls. The CSI driver is responsible for parsing and validating the information passed in as VolumeContext. The following VolumeConext will be passed if podInfoOnMount is set to true. This list might grow, but the prefix will be used. "csi.storage.k8s.io/pod.name": pod.Name "csi.storage.k8s.io/pod.namespace": pod.Namespace "csi.storage.k8s.io/pod.uid": string(pod.UID) "csi.storage.k8s.io/ephemeral": "true" iff the volume is an ephemeral inline volume
            // defined by a CSIVolumeSource, otherwise "false"
            //
            // "csi.storage.k8s.io/ephemeral" is a new feature in Kubernetes 1.16. It is only required for drivers which support both the "Persistent" and "Ephemeral" VolumeLifecycleMode. Other drivers can leave pod info disabled and/or ignore this field. As Kubernetes 1.15 doesn't support this field, drivers can only support one mode when deployed on such a cluster and the deployment determines which mode that is, for example via a command line parameter of the driver.
            withPodInfoOnMount(podInfoOnMount):: self + __specMixin({ podInfoOnMount: podInfoOnMount }),
            // VolumeLifecycleModes defines what kind of volumes this CSI volume driver supports. The default if the list is empty is "Persistent", which is the usage defined by the CSI specification and implemented in Kubernetes via the usual PV/PVC mechanism. The other mode is "Ephemeral". In this mode, volumes are defined inline inside the pod spec with CSIVolumeSource and their lifecycle is tied to the lifecycle of that pod. A driver has to be aware of this because it is only going to get a NodePublishVolume call for such a volume. For more information about implementing this mode, see https://kubernetes-csi.github.io/docs/ephemeral-local-volumes.html A driver can support one or more of these modes and more modes may be added in the future.
            withVolumeLifecycleModes(volumeLifecycleModes):: self + if std.type(volumeLifecycleModes) == 'array' then __specMixin({ volumeLifecycleModes: volumeLifecycleModes }) else __specMixin({ volumeLifecycleModes: [volumeLifecycleModes] }),
            // VolumeLifecycleModes defines what kind of volumes this CSI volume driver supports. The default if the list is empty is "Persistent", which is the usage defined by the CSI specification and implemented in Kubernetes via the usual PV/PVC mechanism. The other mode is "Ephemeral". In this mode, volumes are defined inline inside the pod spec with CSIVolumeSource and their lifecycle is tied to the lifecycle of that pod. A driver has to be aware of this because it is only going to get a NodePublishVolume call for such a volume. For more information about implementing this mode, see https://kubernetes-csi.github.io/docs/ephemeral-local-volumes.html A driver can support one or more of these modes and more modes may be added in the future.
            withVolumeLifecycleModesMixin(volumeLifecycleModes):: self + if std.type(volumeLifecycleModes) == 'array' then __specMixin({ volumeLifecycleModes+: volumeLifecycleModes }) else __specMixin({ volumeLifecycleModes+: [volumeLifecycleModes] }),
          },
          specType:: hidden.storage.v1beta1.csiDriverSpec,
        },
      },
      // DEPRECATED - This group version of CSINode is deprecated by storage/v1/CSINode. See the release notes for more information. CSINode holds information about all CSI drivers installed on a node. CSI drivers do not need to create the CSINode object directly. As long as they use the node-driver-registrar sidecar container, the kubelet will automatically populate the CSINode object for the CSI driver as part of kubelet plugin registration. CSINode has the same name as a node. If the object is missing, it means either there are no CSI Drivers available on the node, or the Kubelet version is low enough that it doesn't create this object. CSINode has an OwnerReference that points to the corresponding node object.
      csiNode:: {
        local kind = { kind: 'CSINode' },
        new():: apiVersion + kind,
        mixin:: {
          // metadata.name must be the Kubernetes node name.
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
          // spec is the specification of CSINode
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty.
            withDrivers(drivers):: self + if std.type(drivers) == 'array' then __specMixin({ drivers: drivers }) else __specMixin({ drivers: [drivers] }),
            // drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty.
            withDriversMixin(drivers):: self + if std.type(drivers) == 'array' then __specMixin({ drivers+: drivers }) else __specMixin({ drivers+: [drivers] }),
            driversType:: hidden.storage.v1beta1.csiNodeDriver,
          },
          specType:: hidden.storage.v1beta1.csiNodeSpec,
        },
      },
      // StorageClass describes the parameters for a class of storage for which PersistentVolumes can be dynamically provisioned.
      //
      // StorageClasses are non-namespaced; the name of the storage class according to etcd is in ObjectMeta.Name.
      storageClass:: {
        local kind = { kind: 'StorageClass' },
        new():: apiVersion + kind,
        // AllowVolumeExpansion shows whether the storage class allow volume expand
        withAllowVolumeExpansion(allowVolumeExpansion):: self + { allowVolumeExpansion: allowVolumeExpansion },
        // Restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
        withAllowedTopologies(allowedTopologies):: self + if std.type(allowedTopologies) == 'array' then { allowedTopologies: allowedTopologies } else { allowedTopologies: [allowedTopologies] },
        // Restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
        withAllowedTopologiesMixin(allowedTopologies):: self + if std.type(allowedTopologies) == 'array' then { allowedTopologies+: allowedTopologies } else { allowedTopologies+: [allowedTopologies] },
        allowedTopologiesType:: hidden.core.v1.topologySelectorTerm,
        // Dynamically provisioned PersistentVolumes of this storage class are created with these mountOptions, e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
        withMountOptions(mountOptions):: self + if std.type(mountOptions) == 'array' then { mountOptions: mountOptions } else { mountOptions: [mountOptions] },
        // Dynamically provisioned PersistentVolumes of this storage class are created with these mountOptions, e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
        withMountOptionsMixin(mountOptions):: self + if std.type(mountOptions) == 'array' then { mountOptions+: mountOptions } else { mountOptions+: [mountOptions] },
        // Parameters holds the parameters for the provisioner that should create volumes of this storage class.
        withParameters(parameters):: self + { parameters: parameters },
        // Parameters holds the parameters for the provisioner that should create volumes of this storage class.
        withParametersMixin(parameters):: self + { parameters+: parameters },
        // Provisioner indicates the type of the provisioner.
        withProvisioner(provisioner):: self + { provisioner: provisioner },
        // Dynamically provisioned PersistentVolumes of this storage class are created with this reclaimPolicy. Defaults to Delete.
        withReclaimPolicy(reclaimPolicy):: self + { reclaimPolicy: reclaimPolicy },
        // VolumeBindingMode indicates how PersistentVolumeClaims should be provisioned and bound.  When unset, VolumeBindingImmediate is used. This field is only honored by servers that enable the VolumeScheduling feature.
        withVolumeBindingMode(volumeBindingMode):: self + { volumeBindingMode: volumeBindingMode },
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
        },
      },
      // VolumeAttachment captures the intent to attach or detach the specified volume to/from the specified node.
      //
      // VolumeAttachment objects are non-namespaced.
      volumeAttachment:: {
        local kind = { kind: 'VolumeAttachment' },
        new():: apiVersion + kind,
        mixin:: {
          // Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          // Specification of the desired attach/detach volume behavior. Populated by the Kubernetes system.
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // Attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().
            withAttacher(attacher):: self + __specMixin({ attacher: attacher }),
            // The node that the volume should be attached to.
            withNodeName(nodeName):: self + __specMixin({ nodeName: nodeName }),
            // Source represents the volume that should be attached.
            source:: {
              local __sourceMixin(source) = __specMixin({ source+: source }),
              mixinInstance(source):: __sourceMixin(source),
              // inlineVolumeSpec contains all the information necessary to attach a persistent volume defined by a pod's inline VolumeSource. This field is populated only for the CSIMigration feature. It contains translated fields from a pod's inline VolumeSource to a PersistentVolumeSpec. This field is alpha-level and is only honored by servers that enabled the CSIMigration feature.
              inlineVolumeSpec:: {
                local __inlineVolumeSpecMixin(inlineVolumeSpec) = __sourceMixin({ inlineVolumeSpec+: inlineVolumeSpec }),
                mixinInstance(inlineVolumeSpec):: __inlineVolumeSpecMixin(inlineVolumeSpec),
                // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
                withAccessModes(accessModes):: self + if std.type(accessModes) == 'array' then __inlineVolumeSpecMixin({ accessModes: accessModes }) else __inlineVolumeSpecMixin({ accessModes: [accessModes] }),
                // AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
                withAccessModesMixin(accessModes):: self + if std.type(accessModes) == 'array' then __inlineVolumeSpecMixin({ accessModes+: accessModes }) else __inlineVolumeSpecMixin({ accessModes+: [accessModes] }),
                // AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                awsElasticBlockStore:: {
                  local __awsElasticBlockStoreMixin(awsElasticBlockStore) = __inlineVolumeSpecMixin({ awsElasticBlockStore+: awsElasticBlockStore }),
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
                  local __azureDiskMixin(azureDisk) = __inlineVolumeSpecMixin({ azureDisk+: azureDisk }),
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
                  local __azureFileMixin(azureFile) = __inlineVolumeSpecMixin({ azureFile+: azureFile }),
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
                withCapacity(capacity):: self + __inlineVolumeSpecMixin({ capacity: capacity }),
                // A description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
                withCapacityMixin(capacity):: self + __inlineVolumeSpecMixin({ capacity+: capacity }),
                // CephFS represents a Ceph FS mount on the host that shares a pod's lifetime
                cephfs:: {
                  local __cephfsMixin(cephfs) = __inlineVolumeSpecMixin({ cephfs+: cephfs }),
                  mixinInstance(cephfs):: __cephfsMixin(cephfs),
                  // Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withMonitors(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors: monitors }) else __cephfsMixin({ monitors: [monitors] }),
                  // Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __cephfsMixin({ monitors+: monitors }) else __cephfsMixin({ monitors+: [monitors] }),
                  // Optional: Used as the mounted root, rather than the full Ceph tree, default is /
                  withPath(path):: self + __cephfsMixin({ path: path }),
                  // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withReadOnly(readOnly):: self + __cephfsMixin({ readOnly: readOnly }),
                  // Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withSecretFile(secretFile):: self + __cephfsMixin({ secretFile: secretFile }),
                  // Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  secretRef:: {
                    local __secretRefMixin(secretRef) = __cephfsMixin({ secretRef+: secretRef }),
                    mixinInstance(secretRef):: __secretRefMixin(secretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __secretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
                  },
                  secretRefType:: hidden.core.v1.secretReference,
                  // Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                  withUser(user):: self + __cephfsMixin({ user: user }),
                },
                cephfsType:: hidden.core.v1.cephFsPersistentVolumeSource,
                // Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                cinder:: {
                  local __cinderMixin(cinder) = __inlineVolumeSpecMixin({ cinder+: cinder }),
                  mixinInstance(cinder):: __cinderMixin(cinder),
                  // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                  withFsType(fsType):: self + __cinderMixin({ fsType: fsType }),
                  // Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
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
                  // volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                  withVolumeId(volumeId):: self + __cinderMixin({ volumeID: volumeId }),
                },
                cinderType:: hidden.core.v1.cinderPersistentVolumeSource,
                // ClaimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
                claimRef:: {
                  local __claimRefMixin(claimRef) = __inlineVolumeSpecMixin({ claimRef+: claimRef }),
                  mixinInstance(claimRef):: __claimRefMixin(claimRef),
                  // If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
                  withFieldPath(fieldPath):: self + __claimRefMixin({ fieldPath: fieldPath }),
                  // Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                  withName(name):: self + __claimRefMixin({ name: name }),
                  // Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
                  withNamespace(namespace):: self + __claimRefMixin({ namespace: namespace }),
                  // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
                  withResourceVersion(resourceVersion):: self + __claimRefMixin({ resourceVersion: resourceVersion }),
                  // UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
                  withUid(uid):: self + __claimRefMixin({ uid: uid }),
                },
                claimRefType:: hidden.core.v1.objectReference,
                // CSI represents storage that is handled by an external CSI driver (Beta feature).
                csi:: {
                  local __csiMixin(csi) = __inlineVolumeSpecMixin({ csi+: csi }),
                  mixinInstance(csi):: __csiMixin(csi),
                  // ControllerExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerExpandVolume call. This is an alpha field and requires enabling ExpandCSIVolumes feature gate. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
                  controllerExpandSecretRef:: {
                    local __controllerExpandSecretRefMixin(controllerExpandSecretRef) = __csiMixin({ controllerExpandSecretRef+: controllerExpandSecretRef }),
                    mixinInstance(controllerExpandSecretRef):: __controllerExpandSecretRefMixin(controllerExpandSecretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __controllerExpandSecretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __controllerExpandSecretRefMixin({ namespace: namespace }),
                  },
                  controllerExpandSecretRefType:: hidden.core.v1.secretReference,
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
                  local __fcMixin(fc) = __inlineVolumeSpecMixin({ fc+: fc }),
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
                  local __flexVolumeMixin(flexVolume) = __inlineVolumeSpecMixin({ flexVolume+: flexVolume }),
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
                  local __flockerMixin(flocker) = __inlineVolumeSpecMixin({ flocker+: flocker }),
                  mixinInstance(flocker):: __flockerMixin(flocker),
                  // Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
                  withDatasetName(datasetName):: self + __flockerMixin({ datasetName: datasetName }),
                  // UUID of the dataset. This is unique identifier of a Flocker dataset
                  withDatasetUuid(datasetUuid):: self + __flockerMixin({ datasetUUID: datasetUuid }),
                },
                flockerType:: hidden.core.v1.flockerVolumeSource,
                // GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                gcePersistentDisk:: {
                  local __gcePersistentDiskMixin(gcePersistentDisk) = __inlineVolumeSpecMixin({ gcePersistentDisk+: gcePersistentDisk }),
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
                // Glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. More info: https://examples.k8s.io/volumes/glusterfs/README.md
                glusterfs:: {
                  local __glusterfsMixin(glusterfs) = __inlineVolumeSpecMixin({ glusterfs+: glusterfs }),
                  mixinInstance(glusterfs):: __glusterfsMixin(glusterfs),
                  // EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withEndpoints(endpoints):: self + __glusterfsMixin({ endpoints: endpoints }),
                  // EndpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withEndpointsNamespace(endpointsNamespace):: self + __glusterfsMixin({ endpointsNamespace: endpointsNamespace }),
                  // Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withPath(path):: self + __glusterfsMixin({ path: path }),
                  // ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                  withReadOnly(readOnly):: self + __glusterfsMixin({ readOnly: readOnly }),
                },
                glusterfsType:: hidden.core.v1.glusterfsPersistentVolumeSource,
                // HostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                hostPath:: {
                  local __hostPathMixin(hostPath) = __inlineVolumeSpecMixin({ hostPath+: hostPath }),
                  mixinInstance(hostPath):: __hostPathMixin(hostPath),
                  // Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                  withPath(path):: self + __hostPathMixin({ path: path }),
                  // Type for HostPath Volume Defaults to "" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                  withType(type):: self + __hostPathMixin({ type: type }),
                },
                hostPathType:: hidden.core.v1.hostPathVolumeSource,
                // ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
                iscsi:: {
                  local __iscsiMixin(iscsi) = __inlineVolumeSpecMixin({ iscsi+: iscsi }),
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
                  local __localStorageMixin(localStorage) = __inlineVolumeSpecMixin({ localStorage+: localStorage }),
                  mixinInstance(localStorage):: __localStorageMixin(localStorage),
                  // Filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a fileystem if unspecified.
                  withFsType(fsType):: self + __localStorageMixin({ fsType: fsType }),
                  // The full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).
                  withPath(path):: self + __localStorageMixin({ path: path }),
                },
                localType:: hidden.core.v1.localVolumeSource,
                // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
                withMountOptions(mountOptions):: self + if std.type(mountOptions) == 'array' then __inlineVolumeSpecMixin({ mountOptions: mountOptions }) else __inlineVolumeSpecMixin({ mountOptions: [mountOptions] }),
                // A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
                withMountOptionsMixin(mountOptions):: self + if std.type(mountOptions) == 'array' then __inlineVolumeSpecMixin({ mountOptions+: mountOptions }) else __inlineVolumeSpecMixin({ mountOptions+: [mountOptions] }),
                // NFS represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                nfs:: {
                  local __nfsMixin(nfs) = __inlineVolumeSpecMixin({ nfs+: nfs }),
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
                  local __nodeAffinityMixin(nodeAffinity) = __inlineVolumeSpecMixin({ nodeAffinity+: nodeAffinity }),
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
                withPersistentVolumeReclaimPolicy(persistentVolumeReclaimPolicy):: self + __inlineVolumeSpecMixin({ persistentVolumeReclaimPolicy: persistentVolumeReclaimPolicy }),
                // PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine
                photonPersistentDisk:: {
                  local __photonPersistentDiskMixin(photonPersistentDisk) = __inlineVolumeSpecMixin({ photonPersistentDisk+: photonPersistentDisk }),
                  mixinInstance(photonPersistentDisk):: __photonPersistentDiskMixin(photonPersistentDisk),
                  // Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                  withFsType(fsType):: self + __photonPersistentDiskMixin({ fsType: fsType }),
                  // ID that identifies Photon Controller persistent disk
                  withPdId(pdId):: self + __photonPersistentDiskMixin({ pdID: pdId }),
                },
                photonPersistentDiskType:: hidden.core.v1.photonPersistentDiskVolumeSource,
                // PortworxVolume represents a portworx volume attached and mounted on kubelets host machine
                portworxVolume:: {
                  local __portworxVolumeMixin(portworxVolume) = __inlineVolumeSpecMixin({ portworxVolume+: portworxVolume }),
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
                  local __quobyteMixin(quobyte) = __inlineVolumeSpecMixin({ quobyte+: quobyte }),
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
                // RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md
                rbd:: {
                  local __rbdMixin(rbd) = __inlineVolumeSpecMixin({ rbd+: rbd }),
                  mixinInstance(rbd):: __rbdMixin(rbd),
                  // Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
                  withFsType(fsType):: self + __rbdMixin({ fsType: fsType }),
                  // The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withImage(image):: self + __rbdMixin({ image: image }),
                  // Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withKeyring(keyring):: self + __rbdMixin({ keyring: keyring }),
                  // A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withMonitors(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors: monitors }) else __rbdMixin({ monitors: [monitors] }),
                  // A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withMonitorsMixin(monitors):: self + if std.type(monitors) == 'array' then __rbdMixin({ monitors+: monitors }) else __rbdMixin({ monitors+: [monitors] }),
                  // The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withPool(pool):: self + __rbdMixin({ pool: pool }),
                  // ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withReadOnly(readOnly):: self + __rbdMixin({ readOnly: readOnly }),
                  // SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  secretRef:: {
                    local __secretRefMixin(secretRef) = __rbdMixin({ secretRef+: secretRef }),
                    mixinInstance(secretRef):: __secretRefMixin(secretRef),
                    // Name is unique within a namespace to reference a secret resource.
                    withName(name):: self + __secretRefMixin({ name: name }),
                    // Namespace defines the space within which the secret name must be unique.
                    withNamespace(namespace):: self + __secretRefMixin({ namespace: namespace }),
                  },
                  secretRefType:: hidden.core.v1.secretReference,
                  // The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                  withUser(user):: self + __rbdMixin({ user: user }),
                },
                rbdType:: hidden.core.v1.rbdPersistentVolumeSource,
                // ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
                scaleIo:: {
                  local __scaleIoMixin(scaleIo) = __inlineVolumeSpecMixin({ scaleIo+: scaleIo }),
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
                withStorageClassName(storageClassName):: self + __inlineVolumeSpecMixin({ storageClassName: storageClassName }),
                // StorageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod More info: https://examples.k8s.io/volumes/storageos/README.md
                storageos:: {
                  local __storageosMixin(storageos) = __inlineVolumeSpecMixin({ storageos+: storageos }),
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
                    // Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
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
                withVolumeMode(volumeMode):: self + __inlineVolumeSpecMixin({ volumeMode: volumeMode }),
                // VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine
                vsphereVolume:: {
                  local __vsphereVolumeMixin(vsphereVolume) = __inlineVolumeSpecMixin({ vsphereVolume+: vsphereVolume }),
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
              inlineVolumeSpecType:: hidden.core.v1.persistentVolumeSpec,
              // Name of the persistent volume to attach.
              withPersistentVolumeName(persistentVolumeName):: self + __sourceMixin({ persistentVolumeName: persistentVolumeName }),
            },
            sourceType:: hidden.storage.v1beta1.volumeAttachmentSource,
          },
          specType:: hidden.storage.v1beta1.volumeAttachmentSpec,
        },
      },
    },
  },
}