{
  local hidden = (import '_hidden.libsonnet'),
  v1alpha1:: {
    local apiVersion = { apiVersion: 'auditregistration.k8s.io/v1alpha1' },
    // AuditSink represents a cluster level audit sink
    auditSink:: {
      local kind = { kind: 'AuditSink' },
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
        // Spec defines the audit configuration spec
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Policy defines the policy for selecting which events should be sent to the webhook required
          policy:: {
            local __policyMixin(policy) = __specMixin({ policy+: policy }),
            mixinInstance(policy):: __policyMixin(policy),
            // The Level that all requests are recorded at. available options: None, Metadata, Request, RequestResponse required
            withLevel(level):: self + __policyMixin({ level: level }),
            // Stages is a list of stages for which events are created.
            withStages(stages):: self + if std.type(stages) == 'array' then __policyMixin({ stages: stages }) else __policyMixin({ stages: [stages] }),
            // Stages is a list of stages for which events are created.
            withStagesMixin(stages):: self + if std.type(stages) == 'array' then __policyMixin({ stages+: stages }) else __policyMixin({ stages+: [stages] }),
          },
          policyType:: hidden.auditregistration.v1alpha1.policy,
          // Webhook to send events required
          webhook:: {
            local __webhookMixin(webhook) = __specMixin({ webhook+: webhook }),
            mixinInstance(webhook):: __webhookMixin(webhook),
            // ClientConfig holds the connection parameters for the webhook required
            clientConfig:: {
              local __clientConfigMixin(clientConfig) = __webhookMixin({ clientConfig+: clientConfig }),
              mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
              // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
              withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
              // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
              //
              // If the webhook is running within the cluster, then you should use `service`.
              //
              // Port 443 will be used if it is open, otherwise it is an error.
              service:: {
                local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
                mixinInstance(service):: __serviceMixin(service),
                // `name` is the name of the service. Required
                withName(name):: self + __serviceMixin({ name: name }),
                // `namespace` is the namespace of the service. Required
                withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
                // `path` is an optional URL path which will be sent in any request to this service.
                withPath(path):: self + __serviceMixin({ path: path }),
              },
              serviceType:: hidden.auditregistration.v1alpha1.serviceReference,
              // `url` gives the location of the webhook, in standard URL form (`scheme://host:port/path`). Exactly one of `url` or `service` must be specified.
              //
              // The `host` should not refer to a service running in the cluster; use the `service` field instead. The host might be resolved via external DNS in some apiservers (e.g., `kube-apiserver` cannot resolve in-cluster DNS as that would be a layering violation). `host` may also be an IP address.
              //
              // Please note that using `localhost` or `127.0.0.1` as a `host` is risky unless you take great care to run this webhook on all hosts which run an apiserver which might need to make calls to this webhook. Such installs are likely to be non-portable, i.e., not easy to turn up in a new cluster.
              //
              // The scheme must be "https"; the URL must begin with "https://".
              //
              // A path is optional, and if present may be any string permissible in a URL. You may use the path to pass an arbitrary string to the webhook, for example, a cluster identifier.
              //
              // Attempting to use a user or basic auth e.g. "user:password@" is not allowed. Fragments ("#...") and query parameters ("?...") are not allowed, either.
              withUrl(url):: self + __clientConfigMixin({ url: url }),
            },
            clientConfigType:: hidden.auditregistration.v1alpha1.webhookClientConfig,
            // Throttle holds the options for throttling the webhook
            throttle:: {
              local __throttleMixin(throttle) = __webhookMixin({ throttle+: throttle }),
              mixinInstance(throttle):: __throttleMixin(throttle),
              // ThrottleBurst is the maximum number of events sent at the same moment default 15 QPS
              withBurst(burst):: self + __throttleMixin({ burst: burst }),
              // ThrottleQPS maximum number of batches per second default 10 QPS
              withQps(qps):: self + __throttleMixin({ qps: qps }),
            },
            throttleType:: hidden.auditregistration.v1alpha1.webhookThrottleConfig,
          },
          webhookType:: hidden.auditregistration.v1alpha1.webhook,
        },
        specType:: hidden.auditregistration.v1alpha1.auditSinkSpec,
      },
    },
  },
}