{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'apiextensions.k8s.io/v1' },
    // CustomResourceDefinition represents a resource that should be exposed on the API server.  Its name MUST be in the format <.spec.name>.<.spec.group>.
    customResourceDefinition:: {
      local kind = { kind: 'CustomResourceDefinition' },
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
        // spec describes how the user wants the resources to appear
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // conversion defines conversion settings for the CRD.
          conversion:: {
            local __conversionMixin(conversion) = __specMixin({ conversion+: conversion }),
            mixinInstance(conversion):: __conversionMixin(conversion),
            // strategy specifies how custom resources are converted between versions. Allowed values are: - `None`: The converter only change the apiVersion and would not touch any other field in the custom resource. - `Webhook`: API Server will call to an external webhook to do the conversion. Additional information
            // is needed for this option. This requires spec.preserveUnknownFields to be false, and spec.conversion.webhook to be set.
            withStrategy(strategy):: self + __conversionMixin({ strategy: strategy }),
            // webhook describes how to call the conversion webhook. Required when `strategy` is set to `Webhook`.
            webhook:: {
              local __webhookMixin(webhook) = __conversionMixin({ webhook+: webhook }),
              mixinInstance(webhook):: __webhookMixin(webhook),
              // clientConfig is the instructions for how to call the webhook if strategy is `Webhook`.
              clientConfig:: {
                local __clientConfigMixin(clientConfig) = __webhookMixin({ clientConfig+: clientConfig }),
                mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
                // caBundle is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
                withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
                // service is a reference to the service for this webhook. Either service or url must be specified.
                //
                // If the webhook is running within the cluster, then you should use `service`.
                service:: {
                  local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
                  mixinInstance(service):: __serviceMixin(service),
                  // name is the name of the service. Required
                  withName(name):: self + __serviceMixin({ name: name }),
                  // namespace is the namespace of the service. Required
                  withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
                  // path is an optional URL path at which the webhook will be contacted.
                  withPath(path):: self + __serviceMixin({ path: path }),
                  // port is an optional service port at which the webhook will be contacted. `port` should be a valid port number (1-65535, inclusive). Defaults to 443 for backward compatibility.
                  withPort(port):: self + __serviceMixin({ port: port }),
                },
                serviceType:: hidden.apiextensions.v1.serviceReference,
                // url gives the location of the webhook, in standard URL form (`scheme://host:port/path`). Exactly one of `url` or `service` must be specified.
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
              clientConfigType:: hidden.apiextensions.v1.webhookClientConfig,
              // conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail.
              withConversionReviewVersions(conversionReviewVersions):: self + if std.type(conversionReviewVersions) == 'array' then __webhookMixin({ conversionReviewVersions: conversionReviewVersions }) else __webhookMixin({ conversionReviewVersions: [conversionReviewVersions] }),
              // conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail.
              withConversionReviewVersionsMixin(conversionReviewVersions):: self + if std.type(conversionReviewVersions) == 'array' then __webhookMixin({ conversionReviewVersions+: conversionReviewVersions }) else __webhookMixin({ conversionReviewVersions+: [conversionReviewVersions] }),
            },
            webhookType:: hidden.apiextensions.v1.webhookConversion,
          },
          conversionType:: hidden.apiextensions.v1.customResourceConversion,
          // group is the API group of the defined custom resource. The custom resources are served under `/apis/<group>/...`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`).
          withGroup(group):: self + __specMixin({ group: group }),
          // names specify the resource and kind names for the custom resource.
          names:: {
            local __namesMixin(names) = __specMixin({ names+: names }),
            mixinInstance(names):: __namesMixin(names),
            // categories is a list of grouped resources this custom resource belongs to (e.g. 'all'). This is published in API discovery documents, and used by clients to support invocations like `kubectl get all`.
            withCategories(categories):: self + if std.type(categories) == 'array' then __namesMixin({ categories: categories }) else __namesMixin({ categories: [categories] }),
            // categories is a list of grouped resources this custom resource belongs to (e.g. 'all'). This is published in API discovery documents, and used by clients to support invocations like `kubectl get all`.
            withCategoriesMixin(categories):: self + if std.type(categories) == 'array' then __namesMixin({ categories+: categories }) else __namesMixin({ categories+: [categories] }),
            // kind is the serialized kind of the resource. It is normally CamelCase and singular. Custom resource instances will use this value as the `kind` attribute in API calls.
            withKind(kind):: self + __namesMixin({ kind: kind }),
            // listKind is the serialized kind of the list for this resource. Defaults to "`kind`List".
            withListKind(listKind):: self + __namesMixin({ listKind: listKind }),
            // plural is the plural name of the resource to serve. The custom resources are served under `/apis/<group>/<version>/.../<plural>`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`). Must be all lowercase.
            withPlural(plural):: self + __namesMixin({ plural: plural }),
            // shortNames are short names for the resource, exposed in API discovery documents, and used by clients to support invocations like `kubectl get <shortname>`. It must be all lowercase.
            withShortNames(shortNames):: self + if std.type(shortNames) == 'array' then __namesMixin({ shortNames: shortNames }) else __namesMixin({ shortNames: [shortNames] }),
            // shortNames are short names for the resource, exposed in API discovery documents, and used by clients to support invocations like `kubectl get <shortname>`. It must be all lowercase.
            withShortNamesMixin(shortNames):: self + if std.type(shortNames) == 'array' then __namesMixin({ shortNames+: shortNames }) else __namesMixin({ shortNames+: [shortNames] }),
            // singular is the singular name of the resource. It must be all lowercase. Defaults to lowercased `kind`.
            withSingular(singular):: self + __namesMixin({ singular: singular }),
          },
          namesType:: hidden.apiextensions.v1.customResourceDefinitionNames,
          // preserveUnknownFields indicates that object fields which are not specified in the OpenAPI schema should be preserved when persisting to storage. apiVersion, kind, metadata and known fields inside metadata are always preserved. This field is deprecated in favor of setting `x-preserve-unknown-fields` to true in `spec.versions[*].schema.openAPIV3Schema`. See https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/#pruning-versus-preserving-unknown-fields for details.
          withPreserveUnknownFields(preserveUnknownFields):: self + __specMixin({ preserveUnknownFields: preserveUnknownFields }),
          // scope indicates whether the defined custom resource is cluster- or namespace-scoped. Allowed values are `Cluster` and `Namespaced`.
          withScope(scope):: self + __specMixin({ scope: scope }),
          // versions is the list of all API versions of the defined custom resource. Version names are used to compute the order in which served versions are listed in API discovery. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
          withVersions(versions):: self + if std.type(versions) == 'array' then __specMixin({ versions: versions }) else __specMixin({ versions: [versions] }),
          // versions is the list of all API versions of the defined custom resource. Version names are used to compute the order in which served versions are listed in API discovery. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
          withVersionsMixin(versions):: self + if std.type(versions) == 'array' then __specMixin({ versions+: versions }) else __specMixin({ versions+: [versions] }),
          versionsType:: hidden.apiextensions.v1.customResourceDefinitionVersion,
        },
        specType:: hidden.apiextensions.v1.customResourceDefinitionSpec,
      },
    },
  },
  v1beta1:: {
    local apiVersion = { apiVersion: 'apiextensions.k8s.io/v1beta1' },
    // CustomResourceDefinition represents a resource that should be exposed on the API server.  Its name MUST be in the format <.spec.name>.<.spec.group>. Deprecated in v1.16, planned for removal in v1.19. Use apiextensions.k8s.io/v1 CustomResourceDefinition instead.
    customResourceDefinition:: {
      local kind = { kind: 'CustomResourceDefinition' },
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
        // spec describes how the user wants the resources to appear
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // additionalPrinterColumns specifies additional columns returned in Table output. See https://kubernetes.io/docs/reference/using-api/api-concepts/#receiving-resources-as-tables for details. If present, this field configures columns for all versions. Top-level and per-version columns are mutually exclusive. If no top-level or per-version columns are specified, a single column displaying the age of the custom resource is used.
          withAdditionalPrinterColumns(additionalPrinterColumns):: self + if std.type(additionalPrinterColumns) == 'array' then __specMixin({ additionalPrinterColumns: additionalPrinterColumns }) else __specMixin({ additionalPrinterColumns: [additionalPrinterColumns] }),
          // additionalPrinterColumns specifies additional columns returned in Table output. See https://kubernetes.io/docs/reference/using-api/api-concepts/#receiving-resources-as-tables for details. If present, this field configures columns for all versions. Top-level and per-version columns are mutually exclusive. If no top-level or per-version columns are specified, a single column displaying the age of the custom resource is used.
          withAdditionalPrinterColumnsMixin(additionalPrinterColumns):: self + if std.type(additionalPrinterColumns) == 'array' then __specMixin({ additionalPrinterColumns+: additionalPrinterColumns }) else __specMixin({ additionalPrinterColumns+: [additionalPrinterColumns] }),
          additionalPrinterColumnsType:: hidden.apiextensions.v1beta1.customResourceColumnDefinition,
          // conversion defines conversion settings for the CRD.
          conversion:: {
            local __conversionMixin(conversion) = __specMixin({ conversion+: conversion }),
            mixinInstance(conversion):: __conversionMixin(conversion),
            // conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail. Defaults to `["v1beta1"]`.
            withConversionReviewVersions(conversionReviewVersions):: self + if std.type(conversionReviewVersions) == 'array' then __conversionMixin({ conversionReviewVersions: conversionReviewVersions }) else __conversionMixin({ conversionReviewVersions: [conversionReviewVersions] }),
            // conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail. Defaults to `["v1beta1"]`.
            withConversionReviewVersionsMixin(conversionReviewVersions):: self + if std.type(conversionReviewVersions) == 'array' then __conversionMixin({ conversionReviewVersions+: conversionReviewVersions }) else __conversionMixin({ conversionReviewVersions+: [conversionReviewVersions] }),
            // strategy specifies how custom resources are converted between versions. Allowed values are: - `None`: The converter only change the apiVersion and would not touch any other field in the custom resource. - `Webhook`: API Server will call to an external webhook to do the conversion. Additional information
            // is needed for this option. This requires spec.preserveUnknownFields to be false, and spec.conversion.webhookClientConfig to be set.
            withStrategy(strategy):: self + __conversionMixin({ strategy: strategy }),
            // webhookClientConfig is the instructions for how to call the webhook if strategy is `Webhook`. Required when `strategy` is set to `Webhook`.
            webhookClientConfig:: {
              local __webhookClientConfigMixin(webhookClientConfig) = __conversionMixin({ webhookClientConfig+: webhookClientConfig }),
              mixinInstance(webhookClientConfig):: __webhookClientConfigMixin(webhookClientConfig),
              // caBundle is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
              withCaBundle(caBundle):: self + __webhookClientConfigMixin({ caBundle: caBundle }),
              // service is a reference to the service for this webhook. Either service or url must be specified.
              //
              // If the webhook is running within the cluster, then you should use `service`.
              service:: {
                local __serviceMixin(service) = __webhookClientConfigMixin({ service+: service }),
                mixinInstance(service):: __serviceMixin(service),
                // name is the name of the service. Required
                withName(name):: self + __serviceMixin({ name: name }),
                // namespace is the namespace of the service. Required
                withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
                // path is an optional URL path at which the webhook will be contacted.
                withPath(path):: self + __serviceMixin({ path: path }),
                // port is an optional service port at which the webhook will be contacted. `port` should be a valid port number (1-65535, inclusive). Defaults to 443 for backward compatibility.
                withPort(port):: self + __serviceMixin({ port: port }),
              },
              serviceType:: hidden.apiextensions.v1beta1.serviceReference,
              // url gives the location of the webhook, in standard URL form (`scheme://host:port/path`). Exactly one of `url` or `service` must be specified.
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
              withUrl(url):: self + __webhookClientConfigMixin({ url: url }),
            },
            webhookClientConfigType:: hidden.apiextensions.v1beta1.webhookClientConfig,
          },
          conversionType:: hidden.apiextensions.v1beta1.customResourceConversion,
          // group is the API group of the defined custom resource. The custom resources are served under `/apis/<group>/...`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`).
          withGroup(group):: self + __specMixin({ group: group }),
          // names specify the resource and kind names for the custom resource.
          names:: {
            local __namesMixin(names) = __specMixin({ names+: names }),
            mixinInstance(names):: __namesMixin(names),
            // categories is a list of grouped resources this custom resource belongs to (e.g. 'all'). This is published in API discovery documents, and used by clients to support invocations like `kubectl get all`.
            withCategories(categories):: self + if std.type(categories) == 'array' then __namesMixin({ categories: categories }) else __namesMixin({ categories: [categories] }),
            // categories is a list of grouped resources this custom resource belongs to (e.g. 'all'). This is published in API discovery documents, and used by clients to support invocations like `kubectl get all`.
            withCategoriesMixin(categories):: self + if std.type(categories) == 'array' then __namesMixin({ categories+: categories }) else __namesMixin({ categories+: [categories] }),
            // kind is the serialized kind of the resource. It is normally CamelCase and singular. Custom resource instances will use this value as the `kind` attribute in API calls.
            withKind(kind):: self + __namesMixin({ kind: kind }),
            // listKind is the serialized kind of the list for this resource. Defaults to "`kind`List".
            withListKind(listKind):: self + __namesMixin({ listKind: listKind }),
            // plural is the plural name of the resource to serve. The custom resources are served under `/apis/<group>/<version>/.../<plural>`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`). Must be all lowercase.
            withPlural(plural):: self + __namesMixin({ plural: plural }),
            // shortNames are short names for the resource, exposed in API discovery documents, and used by clients to support invocations like `kubectl get <shortname>`. It must be all lowercase.
            withShortNames(shortNames):: self + if std.type(shortNames) == 'array' then __namesMixin({ shortNames: shortNames }) else __namesMixin({ shortNames: [shortNames] }),
            // shortNames are short names for the resource, exposed in API discovery documents, and used by clients to support invocations like `kubectl get <shortname>`. It must be all lowercase.
            withShortNamesMixin(shortNames):: self + if std.type(shortNames) == 'array' then __namesMixin({ shortNames+: shortNames }) else __namesMixin({ shortNames+: [shortNames] }),
            // singular is the singular name of the resource. It must be all lowercase. Defaults to lowercased `kind`.
            withSingular(singular):: self + __namesMixin({ singular: singular }),
          },
          namesType:: hidden.apiextensions.v1beta1.customResourceDefinitionNames,
          // preserveUnknownFields indicates that object fields which are not specified in the OpenAPI schema should be preserved when persisting to storage. apiVersion, kind, metadata and known fields inside metadata are always preserved. If false, schemas must be defined for all versions. Defaults to true in v1beta for backwards compatibility. Deprecated: will be required to be false in v1. Preservation of unknown fields can be specified in the validation schema using the `x-kubernetes-preserve-unknown-fields: true` extension. See https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/#pruning-versus-preserving-unknown-fields for details.
          withPreserveUnknownFields(preserveUnknownFields):: self + __specMixin({ preserveUnknownFields: preserveUnknownFields }),
          // scope indicates whether the defined custom resource is cluster- or namespace-scoped. Allowed values are `Cluster` and `Namespaced`. Default is `Namespaced`.
          withScope(scope):: self + __specMixin({ scope: scope }),
          // subresources specify what subresources the defined custom resource has. If present, this field configures subresources for all versions. Top-level and per-version subresources are mutually exclusive.
          subresources:: {
            local __subresourcesMixin(subresources) = __specMixin({ subresources+: subresources }),
            mixinInstance(subresources):: __subresourcesMixin(subresources),
            // scale indicates the custom resource should serve a `/scale` subresource that returns an `autoscaling/v1` Scale object.
            scale:: {
              local __scaleMixin(scale) = __subresourcesMixin({ scale+: scale }),
              mixinInstance(scale):: __scaleMixin(scale),
              // labelSelectorPath defines the JSON path inside of a custom resource that corresponds to Scale `status.selector`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.status` or `.spec`. Must be set to work with HorizontalPodAutoscaler. The field pointed by this JSON path must be a string field (not a complex selector struct) which contains a serialized label selector in string form. More info: https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions#scale-subresource If there is no value under the given path in the custom resource, the `status.selector` value in the `/scale` subresource will default to the empty string.
              withLabelSelectorPath(labelSelectorPath):: self + __scaleMixin({ labelSelectorPath: labelSelectorPath }),
              // specReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `spec.replicas`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.spec`. If there is no value under the given path in the custom resource, the `/scale` subresource will return an error on GET.
              withSpecReplicasPath(specReplicasPath):: self + __scaleMixin({ specReplicasPath: specReplicasPath }),
              // statusReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `status.replicas`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.status`. If there is no value under the given path in the custom resource, the `status.replicas` value in the `/scale` subresource will default to 0.
              withStatusReplicasPath(statusReplicasPath):: self + __scaleMixin({ statusReplicasPath: statusReplicasPath }),
            },
            scaleType:: hidden.apiextensions.v1beta1.customResourceSubresourceScale,
          },
          subresourcesType:: hidden.apiextensions.v1beta1.customResourceSubresources,
          // validation describes the schema used for validation and pruning of the custom resource. If present, this validation schema is used to validate all versions. Top-level and per-version schemas are mutually exclusive.
          validation:: {
            local __validationMixin(validation) = __specMixin({ validation+: validation }),
            mixinInstance(validation):: __validationMixin(validation),
            // openAPIV3Schema is the OpenAPI v3 schema to use for validation and pruning.
            withOpenApiV3Schema(openApiV3Schema):: self + __validationMixin({ openAPIV3Schema: openApiV3Schema }),
            // openAPIV3Schema is the OpenAPI v3 schema to use for validation and pruning.
            withOpenApiV3SchemaMixin(openApiV3Schema):: self + __validationMixin({ openAPIV3Schema+: openApiV3Schema }),
            openAPIV3SchemaType:: hidden.apiextensions.v1beta1.jsonSchemaProps,
          },
          validationType:: hidden.apiextensions.v1beta1.customResourceValidation,
          // version is the API version of the defined custom resource. The custom resources are served under `/apis/<group>/<version>/...`. Must match the name of the first item in the `versions` list if `version` and `versions` are both specified. Optional if `versions` is specified. Deprecated: use `versions` instead.
          withVersion(version):: self + __specMixin({ version: version }),
          // versions is the list of all API versions of the defined custom resource. Optional if `version` is specified. The name of the first item in the `versions` list must match the `version` field if `version` and `versions` are both specified. Version names are used to compute the order in which served versions are listed in API discovery. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
          withVersions(versions):: self + if std.type(versions) == 'array' then __specMixin({ versions: versions }) else __specMixin({ versions: [versions] }),
          // versions is the list of all API versions of the defined custom resource. Optional if `version` is specified. The name of the first item in the `versions` list must match the `version` field if `version` and `versions` are both specified. Version names are used to compute the order in which served versions are listed in API discovery. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
          withVersionsMixin(versions):: self + if std.type(versions) == 'array' then __specMixin({ versions+: versions }) else __specMixin({ versions+: [versions] }),
          versionsType:: hidden.apiextensions.v1beta1.customResourceDefinitionVersion,
        },
        specType:: hidden.apiextensions.v1beta1.customResourceDefinitionSpec,
      },
    },
  },
}