{
  local hidden = (import '_hidden.libsonnet'),
  discovery:: {
    v1beta1:: {
      local apiVersion = { apiVersion: 'discovery.k8s.io/v1beta1' },
      // EndpointSlice represents a subset of the endpoints that implement a service. For a given service there may be multiple EndpointSlice objects, selected by labels, which must be joined to produce the full set of endpoints.
      endpointSlice:: {
        local kind = { kind: 'EndpointSlice' },
        new():: apiVersion + kind,
        // addressType specifies the type of address carried by this EndpointSlice. All addresses in this slice must be the same type. This field is immutable after creation. The following address types are currently supported: * IPv4: Represents an IPv4 Address. * IPv6: Represents an IPv6 Address. * FQDN: Represents a Fully Qualified Domain Name.
        withAddressType(addressType):: self + { addressType: addressType },
        // endpoints is a list of unique endpoints in this slice. Each slice may include a maximum of 1000 endpoints.
        withEndpoints(endpoints):: self + if std.type(endpoints) == 'array' then { endpoints: endpoints } else { endpoints: [endpoints] },
        // endpoints is a list of unique endpoints in this slice. Each slice may include a maximum of 1000 endpoints.
        withEndpointsMixin(endpoints):: self + if std.type(endpoints) == 'array' then { endpoints+: endpoints } else { endpoints+: [endpoints] },
        endpointsType:: hidden.discovery.v1beta1.endpoint,
        // ports specifies the list of network ports exposed by each endpoint in this slice. Each port must have a unique name. When ports is empty, it indicates that there are no defined ports. When a port is defined with a nil port value, it indicates "all ports". Each slice may include a maximum of 100 ports.
        withPorts(ports):: self + if std.type(ports) == 'array' then { ports: ports } else { ports: [ports] },
        // ports specifies the list of network ports exposed by each endpoint in this slice. Each port must have a unique name. When ports is empty, it indicates that there are no defined ports. When a port is defined with a nil port value, it indicates "all ports". Each slice may include a maximum of 100 ports.
        withPortsMixin(ports):: self + if std.type(ports) == 'array' then { ports+: ports } else { ports+: [ports] },
        portsType:: hidden.discovery.v1beta1.endpointPort,
        mixin:: {
          // Standard object's metadata.
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
    },
  },
}