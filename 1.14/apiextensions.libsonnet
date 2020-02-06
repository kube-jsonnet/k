{
  local hidden = (import '_hidden.libsonnet'),
  v1beta1:: {
    local apiVersion = { apiVersion: 'apiextensions.k8s.io/v1beta1' },
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
        // Spec describes how the user wants the resources to appear
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // AdditionalPrinterColumns are additional columns shown e.g. in kubectl next to the name. Defaults to a created-at column. Optional, the global columns for all versions. Top-level and per-version columns are mutually exclusive.
          withAdditionalPrinterColumns(additionalPrinterColumns):: self + if std.type(additionalPrinterColumns) == 'array' then __specMixin({ additionalPrinterColumns: additionalPrinterColumns }) else __specMixin({ additionalPrinterColumns: [additionalPrinterColumns] }),
          // AdditionalPrinterColumns are additional columns shown e.g. in kubectl next to the name. Defaults to a created-at column. Optional, the global columns for all versions. Top-level and per-version columns are mutually exclusive.
          withAdditionalPrinterColumnsMixin(additionalPrinterColumns):: self + if std.type(additionalPrinterColumns) == 'array' then __specMixin({ additionalPrinterColumns+: additionalPrinterColumns }) else __specMixin({ additionalPrinterColumns+: [additionalPrinterColumns] }),
          additionalPrinterColumnsType:: hidden.apiextensions.v1beta1.customResourceColumnDefinition,
          // `conversion` defines conversion settings for the CRD.
          conversion:: {
            local __conversionMixin(conversion) = __specMixin({ conversion+: conversion }),
            mixinInstance(conversion):: __conversionMixin(conversion),
            // ConversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, conversion will fail for this object. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail. Default to `['v1beta1']`.
            withConversionReviewVersions(conversionReviewVersions):: self + if std.type(conversionReviewVersions) == 'array' then __conversionMixin({ conversionReviewVersions: conversionReviewVersions }) else __conversionMixin({ conversionReviewVersions: [conversionReviewVersions] }),
            // ConversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, conversion will fail for this object. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail. Default to `['v1beta1']`.
            withConversionReviewVersionsMixin(conversionReviewVersions):: self + if std.type(conversionReviewVersions) == 'array' then __conversionMixin({ conversionReviewVersions+: conversionReviewVersions }) else __conversionMixin({ conversionReviewVersions+: [conversionReviewVersions] }),
            // `strategy` specifies the conversion strategy. Allowed values are: - `None`: The converter only change the apiVersion and would not touch any other field in the CR. - `Webhook`: API Server will call to an external webhook to do the conversion. Additional information is needed for this option.
            withStrategy(strategy):: self + __conversionMixin({ strategy: strategy }),
            // `webhookClientConfig` is the instructions for how to call the webhook if strategy is `Webhook`. This field is alpha-level and is only honored by servers that enable the CustomResourceWebhookConversion feature.
            webhookClientConfig:: {
              local __webhookClientConfigMixin(webhookClientConfig) = __conversionMixin({ webhookClientConfig+: webhookClientConfig }),
              mixinInstance(webhookClientConfig):: __webhookClientConfigMixin(webhookClientConfig),
              // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
              withCaBundle(caBundle):: self + __webhookClientConfigMixin({ caBundle: caBundle }),
              // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
              //
              // If the webhook is running within the cluster, then you should use `service`.
              //
              // Port 443 will be used if it is open, otherwise it is an error.
              service:: {
                local __serviceMixin(service) = __webhookClientConfigMixin({ service+: service }),
                mixinInstance(service):: __serviceMixin(service),
                // `name` is the name of the service. Required
                withName(name):: self + __serviceMixin({ name: name }),
                // `namespace` is the namespace of the service. Required
                withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
                // `path` is an optional URL path which will be sent in any request to this service.
                withPath(path):: self + __serviceMixin({ path: path }),
              },
              serviceType:: hidden.apiextensions.v1beta1.serviceReference,
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
              withUrl(url):: self + __webhookClientConfigMixin({ url: url }),
            },
            webhookClientConfigType:: hidden.apiextensions.v1beta1.webhookClientConfig,
          },
          conversionType:: hidden.apiextensions.v1beta1.customResourceConversion,
          // Group is the group this resource belongs in
          withGroup(group):: self + __specMixin({ group: group }),
          // Names are the names used to describe this custom resource
          names:: {
            local __namesMixin(names) = __specMixin({ names+: names }),
            mixinInstance(names):: __namesMixin(names),
            // Categories is a list of grouped resources custom resources belong to (e.g. 'all')
            withCategories(categories):: self + if std.type(categories) == 'array' then __namesMixin({ categories: categories }) else __namesMixin({ categories: [categories] }),
            // Categories is a list of grouped resources custom resources belong to (e.g. 'all')
            withCategoriesMixin(categories):: self + if std.type(categories) == 'array' then __namesMixin({ categories+: categories }) else __namesMixin({ categories+: [categories] }),
            // Kind is the serialized kind of the resource.  It is normally CamelCase and singular.
            withKind(kind):: self + __namesMixin({ kind: kind }),
            // ListKind is the serialized kind of the list for this resource.  Defaults to <kind>List.
            withListKind(listKind):: self + __namesMixin({ listKind: listKind }),
            // Plural is the plural name of the resource to serve.  It must match the name of the CustomResourceDefinition-registration too: plural.group and it must be all lowercase.
            withPlural(plural):: self + __namesMixin({ plural: plural }),
            // ShortNames are short names for the resource.  It must be all lowercase.
            withShortNames(shortNames):: self + if std.type(shortNames) == 'array' then __namesMixin({ shortNames: shortNames }) else __namesMixin({ shortNames: [shortNames] }),
            // ShortNames are short names for the resource.  It must be all lowercase.
            withShortNamesMixin(shortNames):: self + if std.type(shortNames) == 'array' then __namesMixin({ shortNames+: shortNames }) else __namesMixin({ shortNames+: [shortNames] }),
            // Singular is the singular name of the resource.  It must be all lowercase  Defaults to lowercased <kind>
            withSingular(singular):: self + __namesMixin({ singular: singular }),
          },
          namesType:: hidden.apiextensions.v1beta1.customResourceDefinitionNames,
          // Scope indicates whether this resource is cluster or namespace scoped.  Default is namespaced
          withScope(scope):: self + __specMixin({ scope: scope }),
          // Subresources describes the subresources for CustomResource Optional, the global subresources for all versions. Top-level and per-version subresources are mutually exclusive.
          subresources:: {
            local __subresourcesMixin(subresources) = __specMixin({ subresources+: subresources }),
            mixinInstance(subresources):: __subresourcesMixin(subresources),
            // Scale denotes the scale subresource for CustomResources
            scale:: {
              local __scaleMixin(scale) = __subresourcesMixin({ scale+: scale }),
              mixinInstance(scale):: __scaleMixin(scale),
              // LabelSelectorPath defines the JSON path inside of a CustomResource that corresponds to Scale.Status.Selector. Only JSON paths without the array notation are allowed. Must be a JSON Path under .status. Must be set to work with HPA. If there is no value under the given path in the CustomResource, the status label selector value in the /scale subresource will default to the empty string.
              withLabelSelectorPath(labelSelectorPath):: self + __scaleMixin({ labelSelectorPath: labelSelectorPath }),
              // SpecReplicasPath defines the JSON path inside of a CustomResource that corresponds to Scale.Spec.Replicas. Only JSON paths without the array notation are allowed. Must be a JSON Path under .spec. If there is no value under the given path in the CustomResource, the /scale subresource will return an error on GET.
              withSpecReplicasPath(specReplicasPath):: self + __scaleMixin({ specReplicasPath: specReplicasPath }),
              // StatusReplicasPath defines the JSON path inside of a CustomResource that corresponds to Scale.Status.Replicas. Only JSON paths without the array notation are allowed. Must be a JSON Path under .status. If there is no value under the given path in the CustomResource, the status replica value in the /scale subresource will default to 0.
              withStatusReplicasPath(statusReplicasPath):: self + __scaleMixin({ statusReplicasPath: statusReplicasPath }),
            },
            scaleType:: hidden.apiextensions.v1beta1.customResourceSubresourceScale,
          },
          subresourcesType:: hidden.apiextensions.v1beta1.customResourceSubresources,
          // Validation describes the validation methods for CustomResources Optional, the global validation schema for all versions. Top-level and per-version schemas are mutually exclusive.
          validation:: {
            local __validationMixin(validation) = __specMixin({ validation+: validation }),
            mixinInstance(validation):: __validationMixin(validation),
            // OpenAPIV3Schema is the OpenAPI v3 schema to be validated against.
            withOpenApiV3Schema(openApiV3Schema):: self + __validationMixin({ openAPIV3Schema: openApiV3Schema }),
            // OpenAPIV3Schema is the OpenAPI v3 schema to be validated against.
            withOpenApiV3SchemaMixin(openApiV3Schema):: self + __validationMixin({ openAPIV3Schema+: openApiV3Schema }),
            openAPIV3SchemaType:: hidden.apiextensions.v1beta1.jsonSchemaProps,
          },
          validationType:: hidden.apiextensions.v1beta1.customResourceValidation,
          // Version is the version this resource belongs in Should be always first item in Versions field if provided. Optional, but at least one of Version or Versions must be set. Deprecated: Please use `Versions`.
          withVersion(version):: self + __specMixin({ version: version }),
          // Versions is the list of all supported versions for this resource. If Version field is provided, this field is optional. Validation: All versions must use the same validation schema for now. i.e., top level Validation field is applied to all of these versions. Order: The version name will be used to compute the order. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
          withVersions(versions):: self + if std.type(versions) == 'array' then __specMixin({ versions: versions }) else __specMixin({ versions: [versions] }),
          // Versions is the list of all supported versions for this resource. If Version field is provided, this field is optional. Validation: All versions must use the same validation schema for now. i.e., top level Validation field is applied to all of these versions. Order: The version name will be used to compute the order. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
          withVersionsMixin(versions):: self + if std.type(versions) == 'array' then __specMixin({ versions+: versions }) else __specMixin({ versions+: [versions] }),
          versionsType:: hidden.apiextensions.v1beta1.customResourceDefinitionVersion,
        },
        specType:: hidden.apiextensions.v1beta1.customResourceDefinitionSpec,
      },
    },
  },
}