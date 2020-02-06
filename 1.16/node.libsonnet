{
  local hidden = (import '_hidden.libsonnet'),
  node:: {
    v1alpha1:: {
      local apiVersion = { apiVersion: 'node.k8s.io/v1alpha1' },
      // RuntimeClass defines a class of container runtime supported in the cluster. The RuntimeClass is used to determine which container runtime is used to run all containers in a pod. RuntimeClasses are (currently) manually defined by a user or cluster provisioner, and referenced in the PodSpec. The Kubelet is responsible for resolving the RuntimeClassName reference before running the pod.  For more details, see https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md
      runtimeClass:: {
        local kind = { kind: 'RuntimeClass' },
        new():: apiVersion + kind,
        mixin:: {
          // More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          // Specification of the RuntimeClass More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            mixinInstance(spec):: __specMixin(spec),
            // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. For more details, see https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.15, and is only honored by servers that enable the PodOverhead feature.
            overhead:: {
              local __overheadMixin(overhead) = __specMixin({ overhead+: overhead }),
              mixinInstance(overhead):: __overheadMixin(overhead),
              // PodFixed represents the fixed resource overhead associated with running a pod.
              withPodFixed(podFixed):: self + __overheadMixin({ podFixed: podFixed }),
              // PodFixed represents the fixed resource overhead associated with running a pod.
              withPodFixedMixin(podFixed):: self + __overheadMixin({ podFixed+: podFixed }),
            },
            overheadType:: hidden.node.v1alpha1.overhead,
            // RuntimeHandler specifies the underlying runtime and configuration that the CRI implementation will use to handle pods of this class. The possible values are specific to the node & CRI configuration.  It is assumed that all handlers are available on every node, and handlers of the same name are equivalent on every node. For example, a handler called "runc" might specify that the runc OCI runtime (using native Linux containers) will be used to run the containers in a pod. The RuntimeHandler must conform to the DNS Label (RFC 1123) requirements and is immutable.
            withRuntimeHandler(runtimeHandler):: self + __specMixin({ runtimeHandler: runtimeHandler }),
            // Scheduling holds the scheduling constraints to ensure that pods running with this RuntimeClass are scheduled to nodes that support it. If scheduling is nil, this RuntimeClass is assumed to be supported by all nodes.
            scheduling:: {
              local __schedulingMixin(scheduling) = __specMixin({ scheduling+: scheduling }),
              mixinInstance(scheduling):: __schedulingMixin(scheduling),
              // nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission.
              withNodeSelector(nodeSelector):: self + __schedulingMixin({ nodeSelector: nodeSelector }),
              // nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission.
              withNodeSelectorMixin(nodeSelector):: self + __schedulingMixin({ nodeSelector+: nodeSelector }),
              // tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass.
              withTolerations(tolerations):: self + if std.type(tolerations) == 'array' then __schedulingMixin({ tolerations: tolerations }) else __schedulingMixin({ tolerations: [tolerations] }),
              // tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass.
              withTolerationsMixin(tolerations):: self + if std.type(tolerations) == 'array' then __schedulingMixin({ tolerations+: tolerations }) else __schedulingMixin({ tolerations+: [tolerations] }),
              tolerationsType:: hidden.core.v1.toleration,
            },
            schedulingType:: hidden.node.v1alpha1.scheduling,
          },
          specType:: hidden.node.v1alpha1.runtimeClassSpec,
        },
      },
    },
    v1beta1:: {
      local apiVersion = { apiVersion: 'node.k8s.io/v1beta1' },
      // RuntimeClass defines a class of container runtime supported in the cluster. The RuntimeClass is used to determine which container runtime is used to run all containers in a pod. RuntimeClasses are (currently) manually defined by a user or cluster provisioner, and referenced in the PodSpec. The Kubelet is responsible for resolving the RuntimeClassName reference before running the pod.  For more details, see https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md
      runtimeClass:: {
        local kind = { kind: 'RuntimeClass' },
        new():: apiVersion + kind,
        // Handler specifies the underlying runtime and configuration that the CRI implementation will use to handle pods of this class. The possible values are specific to the node & CRI configuration.  It is assumed that all handlers are available on every node, and handlers of the same name are equivalent on every node. For example, a handler called "runc" might specify that the runc OCI runtime (using native Linux containers) will be used to run the containers in a pod. The Handler must conform to the DNS Label (RFC 1123) requirements, and is immutable.
        withHandler(handler):: self + { handler: handler },
        mixin:: {
          // More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
          // Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. For more details, see https://git.k8s.io/enhancements/keps/sig-node/20190226-pod-overhead.md This field is alpha-level as of Kubernetes v1.15, and is only honored by servers that enable the PodOverhead feature.
          overhead:: {
            local __overheadMixin(overhead) = { overhead+: overhead },
            mixinInstance(overhead):: __overheadMixin(overhead),
            // PodFixed represents the fixed resource overhead associated with running a pod.
            withPodFixed(podFixed):: self + __overheadMixin({ podFixed: podFixed }),
            // PodFixed represents the fixed resource overhead associated with running a pod.
            withPodFixedMixin(podFixed):: self + __overheadMixin({ podFixed+: podFixed }),
          },
          overheadType:: hidden.node.v1beta1.overhead,
          // Scheduling holds the scheduling constraints to ensure that pods running with this RuntimeClass are scheduled to nodes that support it. If scheduling is nil, this RuntimeClass is assumed to be supported by all nodes.
          scheduling:: {
            local __schedulingMixin(scheduling) = { scheduling+: scheduling },
            mixinInstance(scheduling):: __schedulingMixin(scheduling),
            // nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission.
            withNodeSelector(nodeSelector):: self + __schedulingMixin({ nodeSelector: nodeSelector }),
            // nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission.
            withNodeSelectorMixin(nodeSelector):: self + __schedulingMixin({ nodeSelector+: nodeSelector }),
            // tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass.
            withTolerations(tolerations):: self + if std.type(tolerations) == 'array' then __schedulingMixin({ tolerations: tolerations }) else __schedulingMixin({ tolerations: [tolerations] }),
            // tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass.
            withTolerationsMixin(tolerations):: self + if std.type(tolerations) == 'array' then __schedulingMixin({ tolerations+: tolerations }) else __schedulingMixin({ tolerations+: [tolerations] }),
            tolerationsType:: hidden.core.v1.toleration,
          },
          schedulingType:: hidden.node.v1beta1.scheduling,
        },
      },
    },
  },
}