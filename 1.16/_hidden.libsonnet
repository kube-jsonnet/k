{
  local hidden = (import '_hidden.libsonnet'),
  v1:: {
    local apiVersion = { apiVersion: 'admissionregistration/v1' },
    // MutatingWebhook describes an admission webhook and the resources and operations it applies to.
    mutatingWebhook:: {
      new():: {},
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy.
      withAdmissionReviewVersions(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions: admissionReviewVersions } else { admissionReviewVersions: [admissionReviewVersions] },
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy.
      withAdmissionReviewVersionsMixin(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions+: admissionReviewVersions } else { admissionReviewVersions+: [admissionReviewVersions] },
      // FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Fail.
      withFailurePolicy(failurePolicy):: self + { failurePolicy: failurePolicy },
      // matchPolicy defines how the "rules" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
      //
      // - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.
      //
      // - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.
      //
      // Defaults to "Equivalent"
      withMatchPolicy(matchPolicy):: self + { matchPolicy: matchPolicy },
      // The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where "imagepolicy" is the name of the webhook, and kubernetes.io is the name of the organization. Required.
      withName(name):: self + { name: name },
      // reinvocationPolicy indicates whether this webhook should be called multiple times as part of a single admission evaluation. Allowed values are "Never" and "IfNeeded".
      //
      // Never: the webhook will not be called more than once in a single admission evaluation.
      //
      // IfNeeded: the webhook will be called at least one additional time as part of the admission evaluation if the object being admitted is modified by other admission plugins after the initial webhook call. Webhooks that specify this option *must* be idempotent, able to process objects they previously admitted. Note: * the number of additional invocations is not guaranteed to be exactly one. * if additional invocations result in further modifications to the object, webhooks are not guaranteed to be invoked again. * webhooks that use this option may be reordered to minimize the number of additional invocations. * to validate an object after all mutations are guaranteed complete, use a validating admission webhook instead.
      //
      // Defaults to "Never".
      withReinvocationPolicy(reinvocationPolicy):: self + { reinvocationPolicy: reinvocationPolicy },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRules(rules):: self + if std.type(rules) == 'array' then { rules: rules } else { rules: [rules] },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRulesMixin(rules):: self + if std.type(rules) == 'array' then { rules+: rules } else { rules+: [rules] },
      rulesType:: hidden.admissionregistration.v1.ruleWithOperations,
      // SideEffects states whether this webhook has side effects. Acceptable values are: None, NoneOnDryRun (webhooks created via v1beta1 may also specify Some or Unknown). Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission change and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some.
      withSideEffects(sideEffects):: self + { sideEffects: sideEffects },
      // TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 10 seconds.
      withTimeoutSeconds(timeoutSeconds):: self + { timeoutSeconds: timeoutSeconds },
      mixin:: {
        // ClientConfig defines how to communicate with the hook. Required
        clientConfig:: {
          local __clientConfigMixin(clientConfig) = { clientConfig+: clientConfig },
          mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
          // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
          withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
          // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
          //
          // If the webhook is running within the cluster, then you should use `service`.
          service:: {
            local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
            mixinInstance(service):: __serviceMixin(service),
            // `name` is the name of the service. Required
            withName(name):: self + __serviceMixin({ name: name }),
            // `namespace` is the namespace of the service. Required
            withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
            // `path` is an optional URL path which will be sent in any request to this service.
            withPath(path):: self + __serviceMixin({ path: path }),
            // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
            withPort(port):: self + __serviceMixin({ port: port }),
          },
          serviceType:: hidden.admissionregistration.v1.serviceReference,
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
        clientConfigType:: hidden.admissionregistration.v1.webhookClientConfig,
        // NamespaceSelector decides whether to run the webhook on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the webhook.
        //
        // For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "runlevel",
        // "operator": "NotIn",
        // "values": [
        // "0",
        // "1"
        // ]
        // }
        // ]
        // }
        //
        // If instead you want to only run the webhook on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "environment",
        // "operator": "In",
        // "values": [
        // "prod",
        // "staging"
        // ]
        // }
        // ]
        // }
        //
        // See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ for more examples of label selectors.
        //
        // Default to the empty LabelSelector, which matches everything.
        namespaceSelector:: {
          local __namespaceSelectorMixin(namespaceSelector) = { namespaceSelector+: namespaceSelector },
          mixinInstance(namespaceSelector):: __namespaceSelectorMixin(namespaceSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions+: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __namespaceSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __namespaceSelectorMixin({ matchLabels+: matchLabels }),
        },
        namespaceSelectorType:: hidden.meta.v1.labelSelector,
        // ObjectSelector decides whether to run the webhook based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
        objectSelector:: {
          local __objectSelectorMixin(objectSelector) = { objectSelector+: objectSelector },
          mixinInstance(objectSelector):: __objectSelectorMixin(objectSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions: matchExpressions }) else __objectSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions+: matchExpressions }) else __objectSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __objectSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __objectSelectorMixin({ matchLabels+: matchLabels }),
        },
        objectSelectorType:: hidden.meta.v1.labelSelector,
      },
    },
    // MutatingWebhookConfigurationList is a list of MutatingWebhookConfiguration.
    mutatingWebhookConfigurationList:: {
      new():: {},
      // List of MutatingWebhookConfiguration.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // List of MutatingWebhookConfiguration.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.admissionregistration.v1.mutatingWebhookConfiguration,
      mixin:: {},
    },
    // RuleWithOperations is a tuple of Operations and Resources. It is recommended to make sure that all the tuple expansions are valid.
    ruleWithOperations:: {
      new():: {},
      // APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
      withApiGroups(apiGroups):: self + if std.type(apiGroups) == 'array' then { apiGroups: apiGroups } else { apiGroups: [apiGroups] },
      // APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
      withApiGroupsMixin(apiGroups):: self + if std.type(apiGroups) == 'array' then { apiGroups+: apiGroups } else { apiGroups+: [apiGroups] },
      // APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
      withApiVersions(apiVersions):: self + if std.type(apiVersions) == 'array' then { apiVersions: apiVersions } else { apiVersions: [apiVersions] },
      // APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
      withApiVersionsMixin(apiVersions):: self + if std.type(apiVersions) == 'array' then { apiVersions+: apiVersions } else { apiVersions+: [apiVersions] },
      // Operations is the operations the admission hook cares about - CREATE, UPDATE, or * for all operations. If '*' is present, the length of the slice must be one. Required.
      withOperations(operations):: self + if std.type(operations) == 'array' then { operations: operations } else { operations: [operations] },
      // Operations is the operations the admission hook cares about - CREATE, UPDATE, or * for all operations. If '*' is present, the length of the slice must be one. Required.
      withOperationsMixin(operations):: self + if std.type(operations) == 'array' then { operations+: operations } else { operations+: [operations] },
      // Resources is a list of resources this rule applies to.
      //
      // For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
      //
      // If wildcard is present, the validation rule will ensure resources do not overlap with each other.
      //
      // Depending on the enclosing object, subresources might not be allowed. Required.
      withResources(resources):: self + if std.type(resources) == 'array' then { resources: resources } else { resources: [resources] },
      // Resources is a list of resources this rule applies to.
      //
      // For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
      //
      // If wildcard is present, the validation rule will ensure resources do not overlap with each other.
      //
      // Depending on the enclosing object, subresources might not be allowed. Required.
      withResourcesMixin(resources):: self + if std.type(resources) == 'array' then { resources+: resources } else { resources+: [resources] },
      // scope specifies the scope of this rule. Valid values are "Cluster", "Namespaced", and "*" "Cluster" means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. "Namespaced" means that only namespaced resources will match this rule. "*" means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is "*".
      withScope(scope):: self + { scope: scope },
      mixin:: {},
    },
    // ServiceReference holds a reference to Service.legacy.k8s.io
    serviceReference:: {
      new():: {},
      // `name` is the name of the service. Required
      withName(name):: self + { name: name },
      // `namespace` is the namespace of the service. Required
      withNamespace(namespace):: self + { namespace: namespace },
      // `path` is an optional URL path which will be sent in any request to this service.
      withPath(path):: self + { path: path },
      // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
      withPort(port):: self + { port: port },
      mixin:: {},
    },
    // ValidatingWebhook describes an admission webhook and the resources and operations it applies to.
    validatingWebhook:: {
      new():: {},
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy.
      withAdmissionReviewVersions(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions: admissionReviewVersions } else { admissionReviewVersions: [admissionReviewVersions] },
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy.
      withAdmissionReviewVersionsMixin(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions+: admissionReviewVersions } else { admissionReviewVersions+: [admissionReviewVersions] },
      // FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Fail.
      withFailurePolicy(failurePolicy):: self + { failurePolicy: failurePolicy },
      // matchPolicy defines how the "rules" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
      //
      // - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.
      //
      // - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.
      //
      // Defaults to "Equivalent"
      withMatchPolicy(matchPolicy):: self + { matchPolicy: matchPolicy },
      // The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where "imagepolicy" is the name of the webhook, and kubernetes.io is the name of the organization. Required.
      withName(name):: self + { name: name },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRules(rules):: self + if std.type(rules) == 'array' then { rules: rules } else { rules: [rules] },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRulesMixin(rules):: self + if std.type(rules) == 'array' then { rules+: rules } else { rules+: [rules] },
      rulesType:: hidden.admissionregistration.v1.ruleWithOperations,
      // SideEffects states whether this webhook has side effects. Acceptable values are: None, NoneOnDryRun (webhooks created via v1beta1 may also specify Some or Unknown). Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission change and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some.
      withSideEffects(sideEffects):: self + { sideEffects: sideEffects },
      // TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 10 seconds.
      withTimeoutSeconds(timeoutSeconds):: self + { timeoutSeconds: timeoutSeconds },
      mixin:: {
        // ClientConfig defines how to communicate with the hook. Required
        clientConfig:: {
          local __clientConfigMixin(clientConfig) = { clientConfig+: clientConfig },
          mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
          // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
          withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
          // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
          //
          // If the webhook is running within the cluster, then you should use `service`.
          service:: {
            local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
            mixinInstance(service):: __serviceMixin(service),
            // `name` is the name of the service. Required
            withName(name):: self + __serviceMixin({ name: name }),
            // `namespace` is the namespace of the service. Required
            withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
            // `path` is an optional URL path which will be sent in any request to this service.
            withPath(path):: self + __serviceMixin({ path: path }),
            // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
            withPort(port):: self + __serviceMixin({ port: port }),
          },
          serviceType:: hidden.admissionregistration.v1.serviceReference,
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
        clientConfigType:: hidden.admissionregistration.v1.webhookClientConfig,
        // NamespaceSelector decides whether to run the webhook on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the webhook.
        //
        // For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "runlevel",
        // "operator": "NotIn",
        // "values": [
        // "0",
        // "1"
        // ]
        // }
        // ]
        // }
        //
        // If instead you want to only run the webhook on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "environment",
        // "operator": "In",
        // "values": [
        // "prod",
        // "staging"
        // ]
        // }
        // ]
        // }
        //
        // See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels for more examples of label selectors.
        //
        // Default to the empty LabelSelector, which matches everything.
        namespaceSelector:: {
          local __namespaceSelectorMixin(namespaceSelector) = { namespaceSelector+: namespaceSelector },
          mixinInstance(namespaceSelector):: __namespaceSelectorMixin(namespaceSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions+: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __namespaceSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __namespaceSelectorMixin({ matchLabels+: matchLabels }),
        },
        namespaceSelectorType:: hidden.meta.v1.labelSelector,
        // ObjectSelector decides whether to run the webhook based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
        objectSelector:: {
          local __objectSelectorMixin(objectSelector) = { objectSelector+: objectSelector },
          mixinInstance(objectSelector):: __objectSelectorMixin(objectSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions: matchExpressions }) else __objectSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions+: matchExpressions }) else __objectSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __objectSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __objectSelectorMixin({ matchLabels+: matchLabels }),
        },
        objectSelectorType:: hidden.meta.v1.labelSelector,
      },
    },
    // ValidatingWebhookConfigurationList is a list of ValidatingWebhookConfiguration.
    validatingWebhookConfigurationList:: {
      new():: {},
      // List of ValidatingWebhookConfiguration.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // List of ValidatingWebhookConfiguration.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.admissionregistration.v1.validatingWebhookConfiguration,
      mixin:: {},
    },
    // WebhookClientConfig contains the information to make a TLS connection with the webhook
    webhookClientConfig:: {
      new():: {},
      // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
      withCaBundle(caBundle):: self + { caBundle: caBundle },
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
      withUrl(url):: self + { url: url },
      mixin:: {
        // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
        //
        // If the webhook is running within the cluster, then you should use `service`.
        service:: {
          local __serviceMixin(service) = { service+: service },
          mixinInstance(service):: __serviceMixin(service),
          // `name` is the name of the service. Required
          withName(name):: self + __serviceMixin({ name: name }),
          // `namespace` is the namespace of the service. Required
          withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
          // `path` is an optional URL path which will be sent in any request to this service.
          withPath(path):: self + __serviceMixin({ path: path }),
          // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
          withPort(port):: self + __serviceMixin({ port: port }),
        },
        serviceType:: hidden.admissionregistration.v1.serviceReference,
      },
    },
  },
  v1beta1:: {
    local apiVersion = { apiVersion: 'admissionregistration/v1beta1' },
    // MutatingWebhook describes an admission webhook and the resources and operations it applies to.
    mutatingWebhook:: {
      new():: {},
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy. Default to `['v1beta1']`.
      withAdmissionReviewVersions(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions: admissionReviewVersions } else { admissionReviewVersions: [admissionReviewVersions] },
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy. Default to `['v1beta1']`.
      withAdmissionReviewVersionsMixin(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions+: admissionReviewVersions } else { admissionReviewVersions+: [admissionReviewVersions] },
      // FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Ignore.
      withFailurePolicy(failurePolicy):: self + { failurePolicy: failurePolicy },
      // matchPolicy defines how the "rules" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
      //
      // - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.
      //
      // - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.
      //
      // Defaults to "Exact"
      withMatchPolicy(matchPolicy):: self + { matchPolicy: matchPolicy },
      // The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where "imagepolicy" is the name of the webhook, and kubernetes.io is the name of the organization. Required.
      withName(name):: self + { name: name },
      // reinvocationPolicy indicates whether this webhook should be called multiple times as part of a single admission evaluation. Allowed values are "Never" and "IfNeeded".
      //
      // Never: the webhook will not be called more than once in a single admission evaluation.
      //
      // IfNeeded: the webhook will be called at least one additional time as part of the admission evaluation if the object being admitted is modified by other admission plugins after the initial webhook call. Webhooks that specify this option *must* be idempotent, able to process objects they previously admitted. Note: * the number of additional invocations is not guaranteed to be exactly one. * if additional invocations result in further modifications to the object, webhooks are not guaranteed to be invoked again. * webhooks that use this option may be reordered to minimize the number of additional invocations. * to validate an object after all mutations are guaranteed complete, use a validating admission webhook instead.
      //
      // Defaults to "Never".
      withReinvocationPolicy(reinvocationPolicy):: self + { reinvocationPolicy: reinvocationPolicy },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRules(rules):: self + if std.type(rules) == 'array' then { rules: rules } else { rules: [rules] },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRulesMixin(rules):: self + if std.type(rules) == 'array' then { rules+: rules } else { rules+: [rules] },
      rulesType:: hidden.admissionregistration.v1beta1.ruleWithOperations,
      // SideEffects states whether this webhookk has side effects. Acceptable values are: Unknown, None, Some, NoneOnDryRun Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission change and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some. Defaults to Unknown.
      withSideEffects(sideEffects):: self + { sideEffects: sideEffects },
      // TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 30 seconds.
      withTimeoutSeconds(timeoutSeconds):: self + { timeoutSeconds: timeoutSeconds },
      mixin:: {
        // ClientConfig defines how to communicate with the hook. Required
        clientConfig:: {
          local __clientConfigMixin(clientConfig) = { clientConfig+: clientConfig },
          mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
          // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
          withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
          // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
          //
          // If the webhook is running within the cluster, then you should use `service`.
          service:: {
            local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
            mixinInstance(service):: __serviceMixin(service),
            // `name` is the name of the service. Required
            withName(name):: self + __serviceMixin({ name: name }),
            // `namespace` is the namespace of the service. Required
            withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
            // `path` is an optional URL path which will be sent in any request to this service.
            withPath(path):: self + __serviceMixin({ path: path }),
            // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
            withPort(port):: self + __serviceMixin({ port: port }),
          },
          serviceType:: hidden.admissionregistration.v1beta1.serviceReference,
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
        clientConfigType:: hidden.admissionregistration.v1beta1.webhookClientConfig,
        // NamespaceSelector decides whether to run the webhook on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the webhook.
        //
        // For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "runlevel",
        // "operator": "NotIn",
        // "values": [
        // "0",
        // "1"
        // ]
        // }
        // ]
        // }
        //
        // If instead you want to only run the webhook on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "environment",
        // "operator": "In",
        // "values": [
        // "prod",
        // "staging"
        // ]
        // }
        // ]
        // }
        //
        // See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ for more examples of label selectors.
        //
        // Default to the empty LabelSelector, which matches everything.
        namespaceSelector:: {
          local __namespaceSelectorMixin(namespaceSelector) = { namespaceSelector+: namespaceSelector },
          mixinInstance(namespaceSelector):: __namespaceSelectorMixin(namespaceSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions+: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __namespaceSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __namespaceSelectorMixin({ matchLabels+: matchLabels }),
        },
        namespaceSelectorType:: hidden.meta.v1.labelSelector,
        // ObjectSelector decides whether to run the webhook based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
        objectSelector:: {
          local __objectSelectorMixin(objectSelector) = { objectSelector+: objectSelector },
          mixinInstance(objectSelector):: __objectSelectorMixin(objectSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions: matchExpressions }) else __objectSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions+: matchExpressions }) else __objectSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __objectSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __objectSelectorMixin({ matchLabels+: matchLabels }),
        },
        objectSelectorType:: hidden.meta.v1.labelSelector,
      },
    },
    // MutatingWebhookConfigurationList is a list of MutatingWebhookConfiguration.
    mutatingWebhookConfigurationList:: {
      new():: {},
      // List of MutatingWebhookConfiguration.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // List of MutatingWebhookConfiguration.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.admissionregistration.v1beta1.mutatingWebhookConfiguration,
      mixin:: {},
    },
    // RuleWithOperations is a tuple of Operations and Resources. It is recommended to make sure that all the tuple expansions are valid.
    ruleWithOperations:: {
      new():: {},
      // APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
      withApiGroups(apiGroups):: self + if std.type(apiGroups) == 'array' then { apiGroups: apiGroups } else { apiGroups: [apiGroups] },
      // APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
      withApiGroupsMixin(apiGroups):: self + if std.type(apiGroups) == 'array' then { apiGroups+: apiGroups } else { apiGroups+: [apiGroups] },
      // APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
      withApiVersions(apiVersions):: self + if std.type(apiVersions) == 'array' then { apiVersions: apiVersions } else { apiVersions: [apiVersions] },
      // APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
      withApiVersionsMixin(apiVersions):: self + if std.type(apiVersions) == 'array' then { apiVersions+: apiVersions } else { apiVersions+: [apiVersions] },
      // Operations is the operations the admission hook cares about - CREATE, UPDATE, or * for all operations. If '*' is present, the length of the slice must be one. Required.
      withOperations(operations):: self + if std.type(operations) == 'array' then { operations: operations } else { operations: [operations] },
      // Operations is the operations the admission hook cares about - CREATE, UPDATE, or * for all operations. If '*' is present, the length of the slice must be one. Required.
      withOperationsMixin(operations):: self + if std.type(operations) == 'array' then { operations+: operations } else { operations+: [operations] },
      // Resources is a list of resources this rule applies to.
      //
      // For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
      //
      // If wildcard is present, the validation rule will ensure resources do not overlap with each other.
      //
      // Depending on the enclosing object, subresources might not be allowed. Required.
      withResources(resources):: self + if std.type(resources) == 'array' then { resources: resources } else { resources: [resources] },
      // Resources is a list of resources this rule applies to.
      //
      // For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
      //
      // If wildcard is present, the validation rule will ensure resources do not overlap with each other.
      //
      // Depending on the enclosing object, subresources might not be allowed. Required.
      withResourcesMixin(resources):: self + if std.type(resources) == 'array' then { resources+: resources } else { resources+: [resources] },
      // scope specifies the scope of this rule. Valid values are "Cluster", "Namespaced", and "*" "Cluster" means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. "Namespaced" means that only namespaced resources will match this rule. "*" means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is "*".
      withScope(scope):: self + { scope: scope },
      mixin:: {},
    },
    // ServiceReference holds a reference to Service.legacy.k8s.io
    serviceReference:: {
      new():: {},
      // `name` is the name of the service. Required
      withName(name):: self + { name: name },
      // `namespace` is the namespace of the service. Required
      withNamespace(namespace):: self + { namespace: namespace },
      // `path` is an optional URL path which will be sent in any request to this service.
      withPath(path):: self + { path: path },
      // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
      withPort(port):: self + { port: port },
      mixin:: {},
    },
    // ValidatingWebhook describes an admission webhook and the resources and operations it applies to.
    validatingWebhook:: {
      new():: {},
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy. Default to `['v1beta1']`.
      withAdmissionReviewVersions(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions: admissionReviewVersions } else { admissionReviewVersions: [admissionReviewVersions] },
      // AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy. Default to `['v1beta1']`.
      withAdmissionReviewVersionsMixin(admissionReviewVersions):: self + if std.type(admissionReviewVersions) == 'array' then { admissionReviewVersions+: admissionReviewVersions } else { admissionReviewVersions+: [admissionReviewVersions] },
      // FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Ignore.
      withFailurePolicy(failurePolicy):: self + { failurePolicy: failurePolicy },
      // matchPolicy defines how the "rules" list is used to match incoming requests. Allowed values are "Exact" or "Equivalent".
      //
      // - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.
      //
      // - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and "rules" only included `apiGroups:["apps"], apiVersions:["v1"], resources: ["deployments"]`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.
      //
      // Defaults to "Exact"
      withMatchPolicy(matchPolicy):: self + { matchPolicy: matchPolicy },
      // The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where "imagepolicy" is the name of the webhook, and kubernetes.io is the name of the organization. Required.
      withName(name):: self + { name: name },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRules(rules):: self + if std.type(rules) == 'array' then { rules: rules } else { rules: [rules] },
      // Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects.
      withRulesMixin(rules):: self + if std.type(rules) == 'array' then { rules+: rules } else { rules+: [rules] },
      rulesType:: hidden.admissionregistration.v1beta1.ruleWithOperations,
      // SideEffects states whether this webhookk has side effects. Acceptable values are: Unknown, None, Some, NoneOnDryRun Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission change and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some. Defaults to Unknown.
      withSideEffects(sideEffects):: self + { sideEffects: sideEffects },
      // TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 30 seconds.
      withTimeoutSeconds(timeoutSeconds):: self + { timeoutSeconds: timeoutSeconds },
      mixin:: {
        // ClientConfig defines how to communicate with the hook. Required
        clientConfig:: {
          local __clientConfigMixin(clientConfig) = { clientConfig+: clientConfig },
          mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
          // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
          withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
          // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
          //
          // If the webhook is running within the cluster, then you should use `service`.
          service:: {
            local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
            mixinInstance(service):: __serviceMixin(service),
            // `name` is the name of the service. Required
            withName(name):: self + __serviceMixin({ name: name }),
            // `namespace` is the namespace of the service. Required
            withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
            // `path` is an optional URL path which will be sent in any request to this service.
            withPath(path):: self + __serviceMixin({ path: path }),
            // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
            withPort(port):: self + __serviceMixin({ port: port }),
          },
          serviceType:: hidden.admissionregistration.v1beta1.serviceReference,
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
        clientConfigType:: hidden.admissionregistration.v1beta1.webhookClientConfig,
        // NamespaceSelector decides whether to run the webhook on an object based on whether the namespace for that object matches the selector. If the object itself is a namespace, the matching is performed on object.metadata.labels. If the object is another cluster scoped resource, it never skips the webhook.
        //
        // For example, to run the webhook on any objects whose namespace is not associated with "runlevel" of "0" or "1";  you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "runlevel",
        // "operator": "NotIn",
        // "values": [
        // "0",
        // "1"
        // ]
        // }
        // ]
        // }
        //
        // If instead you want to only run the webhook on any objects whose namespace is associated with the "environment" of "prod" or "staging"; you will set the selector as follows: "namespaceSelector": {
        // "matchExpressions": [
        // {
        // "key": "environment",
        // "operator": "In",
        // "values": [
        // "prod",
        // "staging"
        // ]
        // }
        // ]
        // }
        //
        // See https://kubernetes.io/docs/concepts/overview/working-with-objects/labels for more examples of label selectors.
        //
        // Default to the empty LabelSelector, which matches everything.
        namespaceSelector:: {
          local __namespaceSelectorMixin(namespaceSelector) = { namespaceSelector+: namespaceSelector },
          mixinInstance(namespaceSelector):: __namespaceSelectorMixin(namespaceSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __namespaceSelectorMixin({ matchExpressions+: matchExpressions }) else __namespaceSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __namespaceSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __namespaceSelectorMixin({ matchLabels+: matchLabels }),
        },
        namespaceSelectorType:: hidden.meta.v1.labelSelector,
        // ObjectSelector decides whether to run the webhook based on if the object has matching labels. objectSelector is evaluated against both the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. Default to the empty LabelSelector, which matches everything.
        objectSelector:: {
          local __objectSelectorMixin(objectSelector) = { objectSelector+: objectSelector },
          mixinInstance(objectSelector):: __objectSelectorMixin(objectSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions: matchExpressions }) else __objectSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __objectSelectorMixin({ matchExpressions+: matchExpressions }) else __objectSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __objectSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __objectSelectorMixin({ matchLabels+: matchLabels }),
        },
        objectSelectorType:: hidden.meta.v1.labelSelector,
      },
    },
    // ValidatingWebhookConfigurationList is a list of ValidatingWebhookConfiguration.
    validatingWebhookConfigurationList:: {
      new():: {},
      // List of ValidatingWebhookConfiguration.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // List of ValidatingWebhookConfiguration.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.admissionregistration.v1beta1.validatingWebhookConfiguration,
      mixin:: {},
    },
    // WebhookClientConfig contains the information to make a TLS connection with the webhook
    webhookClientConfig:: {
      new():: {},
      // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
      withCaBundle(caBundle):: self + { caBundle: caBundle },
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
      withUrl(url):: self + { url: url },
      mixin:: {
        // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
        //
        // If the webhook is running within the cluster, then you should use `service`.
        service:: {
          local __serviceMixin(service) = { service+: service },
          mixinInstance(service):: __serviceMixin(service),
          // `name` is the name of the service. Required
          withName(name):: self + __serviceMixin({ name: name }),
          // `namespace` is the namespace of the service. Required
          withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
          // `path` is an optional URL path which will be sent in any request to this service.
          withPath(path):: self + __serviceMixin({ path: path }),
          // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
          withPort(port):: self + __serviceMixin({ port: port }),
        },
        serviceType:: hidden.admissionregistration.v1beta1.serviceReference,
      },
    },
  },
  v1beta2:: {
    local apiVersion = { apiVersion: 'apps/v1beta2' },
    // ControllerRevisionList is a resource containing a list of ControllerRevision objects.
    controllerRevisionList:: {
      new():: {},
      // Items is the list of ControllerRevisions
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // Items is the list of ControllerRevisions
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.apps.v1beta2.controllerRevision,
      mixin:: {},
    },
    // DaemonSetCondition describes the state of a DaemonSet at a certain point.
    daemonSetCondition:: {
      new():: {},
      // Last time the condition transitioned from one status to another.
      withLastTransitionTime(lastTransitionTime):: self + { lastTransitionTime: lastTransitionTime },
      // A human readable message indicating details about the transition.
      withMessage(message):: self + { message: message },
      // The reason for the condition's last transition.
      withReason(reason):: self + { reason: reason },
      // Status of the condition, one of True, False, Unknown.
      withStatus(status):: self + { status: status },
      // Type of DaemonSet condition.
      withType(type):: self + { type: type },
      mixin:: {},
    },
    // DaemonSetList is a collection of daemon sets.
    daemonSetList:: {
      new():: {},
      // A list of daemon sets.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // A list of daemon sets.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.apps.v1beta2.daemonSet,
      mixin:: {},
    },
    // DaemonSetSpec is the specification of a daemon set.
    daemonSetSpec:: {
      new():: {},
      // The minimum number of seconds for which a newly created DaemonSet pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready).
      withMinReadySeconds(minReadySeconds):: self + { minReadySeconds: minReadySeconds },
      // The number of old history to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
      withRevisionHistoryLimit(revisionHistoryLimit):: self + { revisionHistoryLimit: revisionHistoryLimit },
      mixin:: {
        // A label query over pods that are managed by the daemon set. Must match in order to be controlled. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
          local __templateMixin(template) = { template+: template },
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
                // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                // GMSACredentialSpecName is the name of the GMSA credential spec to use. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. This field is alpha-level and it is only honored by servers that enable the WindowsRunAsUserName feature flag.
                withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
              },
              windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
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
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
            withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
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
          local __updateStrategyMixin(updateStrategy) = { updateStrategy+: updateStrategy },
          mixinInstance(updateStrategy):: __updateStrategyMixin(updateStrategy),
          // Rolling update config params. Present only if type = "RollingUpdate".
          rollingUpdate:: {
            local __rollingUpdateMixin(rollingUpdate) = __updateStrategyMixin({ rollingUpdate+: rollingUpdate }),
            mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
            // The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0. Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
            withMaxUnavailable(maxUnavailable):: self + __rollingUpdateMixin({ maxUnavailable: maxUnavailable }),
          },
          rollingUpdateType:: hidden.apps.v1beta2.rollingUpdateDaemonSet,
          // Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.
          withType(type):: self + __updateStrategyMixin({ type: type }),
        },
        updateStrategyType:: hidden.apps.v1beta2.daemonSetUpdateStrategy,
      },
    },
    // DaemonSetStatus represents the current status of a daemon set.
    daemonSetStatus:: {
      new():: {},
      // Count of hash collisions for the DaemonSet. The DaemonSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
      withCollisionCount(collisionCount):: self + { collisionCount: collisionCount },
      // Represents the latest available observations of a DaemonSet's current state.
      withConditions(conditions):: self + if std.type(conditions) == 'array' then { conditions: conditions } else { conditions: [conditions] },
      // Represents the latest available observations of a DaemonSet's current state.
      withConditionsMixin(conditions):: self + if std.type(conditions) == 'array' then { conditions+: conditions } else { conditions+: [conditions] },
      conditionsType:: hidden.apps.v1beta2.daemonSetCondition,
      // The number of nodes that are running at least 1 daemon pod and are supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
      withCurrentNumberScheduled(currentNumberScheduled):: self + { currentNumberScheduled: currentNumberScheduled },
      // The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod). More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
      withDesiredNumberScheduled(desiredNumberScheduled):: self + { desiredNumberScheduled: desiredNumberScheduled },
      // The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds)
      withNumberAvailable(numberAvailable):: self + { numberAvailable: numberAvailable },
      // The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
      withNumberMisscheduled(numberMisscheduled):: self + { numberMisscheduled: numberMisscheduled },
      // The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.
      withNumberReady(numberReady):: self + { numberReady: numberReady },
      // The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds)
      withNumberUnavailable(numberUnavailable):: self + { numberUnavailable: numberUnavailable },
      // The most recent generation observed by the daemon set controller.
      withObservedGeneration(observedGeneration):: self + { observedGeneration: observedGeneration },
      // The total number of nodes that are running updated daemon pod
      withUpdatedNumberScheduled(updatedNumberScheduled):: self + { updatedNumberScheduled: updatedNumberScheduled },
      mixin:: {},
    },
    // DaemonSetUpdateStrategy is a struct used to control the update strategy for a DaemonSet.
    daemonSetUpdateStrategy:: {
      new():: {},
      // Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.
      withType(type):: self + { type: type },
      mixin:: {
        // Rolling update config params. Present only if type = "RollingUpdate".
        rollingUpdate:: {
          local __rollingUpdateMixin(rollingUpdate) = { rollingUpdate+: rollingUpdate },
          mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
          // The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0. Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
          withMaxUnavailable(maxUnavailable):: self + __rollingUpdateMixin({ maxUnavailable: maxUnavailable }),
        },
        rollingUpdateType:: hidden.apps.v1beta2.rollingUpdateDaemonSet,
      },
    },
    // DeploymentCondition describes the state of a deployment at a certain point.
    deploymentCondition:: {
      new():: {},
      // Last time the condition transitioned from one status to another.
      withLastTransitionTime(lastTransitionTime):: self + { lastTransitionTime: lastTransitionTime },
      // The last time this condition was updated.
      withLastUpdateTime(lastUpdateTime):: self + { lastUpdateTime: lastUpdateTime },
      // A human readable message indicating details about the transition.
      withMessage(message):: self + { message: message },
      // The reason for the condition's last transition.
      withReason(reason):: self + { reason: reason },
      // Status of the condition, one of True, False, Unknown.
      withStatus(status):: self + { status: status },
      // Type of deployment condition.
      withType(type):: self + { type: type },
      mixin:: {},
    },
    // DeploymentList is a list of Deployments.
    deploymentList:: {
      new(items=''):: self.withItems(items),
      // Items is the list of Deployments.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // Items is the list of Deployments.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.apps.v1beta2.deployment,
      mixin:: {},
    },
    // DeploymentSpec is the specification of the desired behavior of the Deployment.
    deploymentSpec:: {
      new():: {},
      // Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
      withMinReadySeconds(minReadySeconds):: self + { minReadySeconds: minReadySeconds },
      // Indicates that the deployment is paused.
      withPaused(paused):: self + { paused: paused },
      // The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s.
      withProgressDeadlineSeconds(progressDeadlineSeconds):: self + { progressDeadlineSeconds: progressDeadlineSeconds },
      // Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
      withReplicas(replicas):: self + { replicas: replicas },
      // The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
      withRevisionHistoryLimit(revisionHistoryLimit):: self + { revisionHistoryLimit: revisionHistoryLimit },
      mixin:: {
        // Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels.
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
          local __strategyMixin(strategy) = { strategy+: strategy },
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
          rollingUpdateType:: hidden.apps.v1beta2.rollingUpdateDeployment,
          // Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
          withType(type):: self + __strategyMixin({ type: type }),
        },
        strategyType:: hidden.apps.v1beta2.deploymentStrategy,
        // Template describes the pods that will be created.
        template:: {
          local __templateMixin(template) = { template+: template },
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
                // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                // GMSACredentialSpecName is the name of the GMSA credential spec to use. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. This field is alpha-level and it is only honored by servers that enable the WindowsRunAsUserName feature flag.
                withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
              },
              windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
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
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
            withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
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
    },
    // DeploymentStatus is the most recently observed status of the Deployment.
    deploymentStatus:: {
      new():: {},
      // Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.
      withAvailableReplicas(availableReplicas):: self + { availableReplicas: availableReplicas },
      // Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet.
      withCollisionCount(collisionCount):: self + { collisionCount: collisionCount },
      // Represents the latest available observations of a deployment's current state.
      withConditions(conditions):: self + if std.type(conditions) == 'array' then { conditions: conditions } else { conditions: [conditions] },
      // Represents the latest available observations of a deployment's current state.
      withConditionsMixin(conditions):: self + if std.type(conditions) == 'array' then { conditions+: conditions } else { conditions+: [conditions] },
      conditionsType:: hidden.apps.v1beta2.deploymentCondition,
      // The generation observed by the deployment controller.
      withObservedGeneration(observedGeneration):: self + { observedGeneration: observedGeneration },
      // Total number of ready pods targeted by this deployment.
      withReadyReplicas(readyReplicas):: self + { readyReplicas: readyReplicas },
      // Total number of non-terminated pods targeted by this deployment (their labels match the selector).
      withReplicas(replicas):: self + { replicas: replicas },
      // Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created.
      withUnavailableReplicas(unavailableReplicas):: self + { unavailableReplicas: unavailableReplicas },
      // Total number of non-terminated pods targeted by this deployment that have the desired template spec.
      withUpdatedReplicas(updatedReplicas):: self + { updatedReplicas: updatedReplicas },
      mixin:: {},
    },
    // DeploymentStrategy describes how to replace existing pods with new ones.
    deploymentStrategy:: {
      new():: {},
      // Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
      withType(type):: self + { type: type },
      mixin:: {
        // Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.
        rollingUpdate:: {
          local __rollingUpdateMixin(rollingUpdate) = { rollingUpdate+: rollingUpdate },
          mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
          // The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods.
          withMaxSurge(maxSurge):: self + __rollingUpdateMixin({ maxSurge: maxSurge }),
          // The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods.
          withMaxUnavailable(maxUnavailable):: self + __rollingUpdateMixin({ maxUnavailable: maxUnavailable }),
        },
        rollingUpdateType:: hidden.apps.v1beta2.rollingUpdateDeployment,
      },
    },
    // ReplicaSetCondition describes the state of a replica set at a certain point.
    replicaSetCondition:: {
      new():: {},
      // The last time the condition transitioned from one status to another.
      withLastTransitionTime(lastTransitionTime):: self + { lastTransitionTime: lastTransitionTime },
      // A human readable message indicating details about the transition.
      withMessage(message):: self + { message: message },
      // The reason for the condition's last transition.
      withReason(reason):: self + { reason: reason },
      // Status of the condition, one of True, False, Unknown.
      withStatus(status):: self + { status: status },
      // Type of replica set condition.
      withType(type):: self + { type: type },
      mixin:: {},
    },
    // ReplicaSetList is a collection of ReplicaSets.
    replicaSetList:: {
      new():: {},
      // List of ReplicaSets. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // List of ReplicaSets. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.apps.v1beta2.replicaSet,
      mixin:: {},
    },
    // ReplicaSetSpec is the specification of a ReplicaSet.
    replicaSetSpec:: {
      new():: {},
      // Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
      withMinReadySeconds(minReadySeconds):: self + { minReadySeconds: minReadySeconds },
      // Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller
      withReplicas(replicas):: self + { replicas: replicas },
      mixin:: {
        // Selector is a label query over pods that should match the replica count. Label keys and values that must match in order to be controlled by this replica set. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
          local __templateMixin(template) = { template+: template },
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
                // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                // GMSACredentialSpecName is the name of the GMSA credential spec to use. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. This field is alpha-level and it is only honored by servers that enable the WindowsRunAsUserName feature flag.
                withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
              },
              windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
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
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
            withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
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
    },
    // ReplicaSetStatus represents the current status of a ReplicaSet.
    replicaSetStatus:: {
      new():: {},
      // The number of available replicas (ready for at least minReadySeconds) for this replica set.
      withAvailableReplicas(availableReplicas):: self + { availableReplicas: availableReplicas },
      // Represents the latest available observations of a replica set's current state.
      withConditions(conditions):: self + if std.type(conditions) == 'array' then { conditions: conditions } else { conditions: [conditions] },
      // Represents the latest available observations of a replica set's current state.
      withConditionsMixin(conditions):: self + if std.type(conditions) == 'array' then { conditions+: conditions } else { conditions+: [conditions] },
      conditionsType:: hidden.apps.v1beta2.replicaSetCondition,
      // The number of pods that have labels matching the labels of the pod template of the replicaset.
      withFullyLabeledReplicas(fullyLabeledReplicas):: self + { fullyLabeledReplicas: fullyLabeledReplicas },
      // ObservedGeneration reflects the generation of the most recently observed ReplicaSet.
      withObservedGeneration(observedGeneration):: self + { observedGeneration: observedGeneration },
      // The number of ready replicas for this replica set.
      withReadyReplicas(readyReplicas):: self + { readyReplicas: readyReplicas },
      // Replicas is the most recently oberved number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller
      withReplicas(replicas):: self + { replicas: replicas },
      mixin:: {},
    },
    // Spec to control the desired behavior of daemon set rolling update.
    rollingUpdateDaemonSet:: {
      new():: {},
      // The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0. Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
      withMaxUnavailable(maxUnavailable):: self + { maxUnavailable: maxUnavailable },
      mixin:: {},
    },
    // Spec to control the desired behavior of rolling update.
    rollingUpdateDeployment:: {
      new():: {},
      // The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods.
      withMaxSurge(maxSurge):: self + { maxSurge: maxSurge },
      // The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods.
      withMaxUnavailable(maxUnavailable):: self + { maxUnavailable: maxUnavailable },
      mixin:: {},
    },
    // RollingUpdateStatefulSetStrategy is used to communicate parameter for RollingUpdateStatefulSetStrategyType.
    rollingUpdateStatefulSetStrategy:: {
      new():: {},
      // Partition indicates the ordinal at which the StatefulSet should be partitioned. Default value is 0.
      withPartition(partition):: self + { partition: partition },
      mixin:: {},
    },
    // ScaleSpec describes the attributes of a scale subresource
    scaleSpec:: {
      new():: {},
      // desired number of instances for the scaled object.
      withReplicas(replicas):: self + { replicas: replicas },
      mixin:: {},
    },
    // ScaleStatus represents the current status of a scale subresource.
    scaleStatus:: {
      new():: {},
      // actual number of observed instances of the scaled object.
      withReplicas(replicas):: self + { replicas: replicas },
      // label query over pods that should match the replicas count. More info: http://kubernetes.io/docs/user-guide/labels#label-selectors
      withSelector(selector):: self + { selector: selector },
      // label query over pods that should match the replicas count. More info: http://kubernetes.io/docs/user-guide/labels#label-selectors
      withSelectorMixin(selector):: self + { selector+: selector },
      // label selector for pods that should match the replicas count. This is a serializated version of both map-based and more expressive set-based selectors. This is done to avoid introspection in the clients. The string will be in the same format as the query-param syntax. If the target type only supports map-based selectors, both this field and map-based selector field are populated. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
      withTargetSelector(targetSelector):: self + { targetSelector: targetSelector },
      mixin:: {},
    },
    // StatefulSetCondition describes the state of a statefulset at a certain point.
    statefulSetCondition:: {
      new():: {},
      // Last time the condition transitioned from one status to another.
      withLastTransitionTime(lastTransitionTime):: self + { lastTransitionTime: lastTransitionTime },
      // A human readable message indicating details about the transition.
      withMessage(message):: self + { message: message },
      // The reason for the condition's last transition.
      withReason(reason):: self + { reason: reason },
      // Status of the condition, one of True, False, Unknown.
      withStatus(status):: self + { status: status },
      // Type of statefulset condition.
      withType(type):: self + { type: type },
      mixin:: {},
    },
    // StatefulSetList is a collection of StatefulSets.
    statefulSetList:: {
      new(items=''):: self.withItems(items),
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.apps.v1beta2.statefulSet,
      mixin:: {},
    },
    // A StatefulSetSpec is the specification of a StatefulSet.
    statefulSetSpec:: {
      new():: {},
      // podManagementPolicy controls how pods are created during initial scale up, when replacing pods on nodes, or when scaling down. The default policy is `OrderedReady`, where pods are created in increasing order (pod-0, then pod-1, etc) and the controller will wait until each pod is ready before continuing. When scaling down, the pods are removed in the opposite order. The alternative policy is `Parallel` which will create pods in parallel to match the desired scale without waiting, and on scale down will delete all pods at once.
      withPodManagementPolicy(podManagementPolicy):: self + { podManagementPolicy: podManagementPolicy },
      // replicas is the desired number of replicas of the given Template. These are replicas in the sense that they are instantiations of the same Template, but individual replicas also have a consistent identity. If unspecified, defaults to 1.
      withReplicas(replicas):: self + { replicas: replicas },
      // revisionHistoryLimit is the maximum number of revisions that will be maintained in the StatefulSet's revision history. The revision history consists of all revisions not represented by a currently applied StatefulSetSpec version. The default value is 10.
      withRevisionHistoryLimit(revisionHistoryLimit):: self + { revisionHistoryLimit: revisionHistoryLimit },
      // serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set. Pods get DNS/hostnames that follow the pattern: pod-specific-string.serviceName.default.svc.cluster.local where "pod-specific-string" is managed by the StatefulSet controller.
      withServiceName(serviceName):: self + { serviceName: serviceName },
      // volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
      withVolumeClaimTemplates(volumeClaimTemplates):: self + if std.type(volumeClaimTemplates) == 'array' then { volumeClaimTemplates: volumeClaimTemplates } else { volumeClaimTemplates: [volumeClaimTemplates] },
      // volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
      withVolumeClaimTemplatesMixin(volumeClaimTemplates):: self + if std.type(volumeClaimTemplates) == 'array' then { volumeClaimTemplates+: volumeClaimTemplates } else { volumeClaimTemplates+: [volumeClaimTemplates] },
      volumeClaimTemplatesType:: hidden.core.v1.persistentVolumeClaim,
      mixin:: {
        // selector is a label query over pods that should match the replica count. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
        // template is the object that describes the pod that will be created if insufficient replicas are detected. Each pod stamped out by the StatefulSet will fulfill this Template, but have a unique identity from the rest of the StatefulSet.
        template:: {
          local __templateMixin(template) = { template+: template },
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
                // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                // GMSACredentialSpecName is the name of the GMSA credential spec to use. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. This field is alpha-level and it is only honored by servers that enable the WindowsRunAsUserName feature flag.
                withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
              },
              windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
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
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
            withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
            // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
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
          local __updateStrategyMixin(updateStrategy) = { updateStrategy+: updateStrategy },
          mixinInstance(updateStrategy):: __updateStrategyMixin(updateStrategy),
          // RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.
          rollingUpdate:: {
            local __rollingUpdateMixin(rollingUpdate) = __updateStrategyMixin({ rollingUpdate+: rollingUpdate }),
            mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
            // Partition indicates the ordinal at which the StatefulSet should be partitioned. Default value is 0.
            withPartition(partition):: self + __rollingUpdateMixin({ partition: partition }),
          },
          rollingUpdateType:: hidden.apps.v1beta2.rollingUpdateStatefulSetStrategy,
          // Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.
          withType(type):: self + __updateStrategyMixin({ type: type }),
        },
        updateStrategyType:: hidden.apps.v1beta2.statefulSetUpdateStrategy,
      },
    },
    // StatefulSetStatus represents the current state of a StatefulSet.
    statefulSetStatus:: {
      new():: {},
      // collisionCount is the count of hash collisions for the StatefulSet. The StatefulSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
      withCollisionCount(collisionCount):: self + { collisionCount: collisionCount },
      // Represents the latest available observations of a statefulset's current state.
      withConditions(conditions):: self + if std.type(conditions) == 'array' then { conditions: conditions } else { conditions: [conditions] },
      // Represents the latest available observations of a statefulset's current state.
      withConditionsMixin(conditions):: self + if std.type(conditions) == 'array' then { conditions+: conditions } else { conditions+: [conditions] },
      conditionsType:: hidden.apps.v1beta2.statefulSetCondition,
      // currentReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.
      withCurrentReplicas(currentReplicas):: self + { currentReplicas: currentReplicas },
      // currentRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [0,currentReplicas).
      withCurrentRevision(currentRevision):: self + { currentRevision: currentRevision },
      // observedGeneration is the most recent generation observed for this StatefulSet. It corresponds to the StatefulSet's generation, which is updated on mutation by the API Server.
      withObservedGeneration(observedGeneration):: self + { observedGeneration: observedGeneration },
      // readyReplicas is the number of Pods created by the StatefulSet controller that have a Ready Condition.
      withReadyReplicas(readyReplicas):: self + { readyReplicas: readyReplicas },
      // replicas is the number of Pods created by the StatefulSet controller.
      withReplicas(replicas):: self + { replicas: replicas },
      // updateRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [replicas-updatedReplicas,replicas)
      withUpdateRevision(updateRevision):: self + { updateRevision: updateRevision },
      // updatedReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.
      withUpdatedReplicas(updatedReplicas):: self + { updatedReplicas: updatedReplicas },
      mixin:: {},
    },
    // StatefulSetUpdateStrategy indicates the strategy that the StatefulSet controller will use to perform updates. It includes any additional parameters necessary to perform the update for the indicated strategy.
    statefulSetUpdateStrategy:: {
      new():: {},
      // Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.
      withType(type):: self + { type: type },
      mixin:: {
        // RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.
        rollingUpdate:: {
          local __rollingUpdateMixin(rollingUpdate) = { rollingUpdate+: rollingUpdate },
          mixinInstance(rollingUpdate):: __rollingUpdateMixin(rollingUpdate),
          // Partition indicates the ordinal at which the StatefulSet should be partitioned. Default value is 0.
          withPartition(partition):: self + __rollingUpdateMixin({ partition: partition }),
        },
        rollingUpdateType:: hidden.apps.v1beta2.rollingUpdateStatefulSetStrategy,
      },
    },
  },
  v1alpha1:: {
    local apiVersion = { apiVersion: 'auditregistration/v1alpha1' },
    // AuditSinkList is a list of AuditSink items.
    auditSinkList:: {
      new():: {},
      // List of audit configurations.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // List of audit configurations.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.auditregistration.v1alpha1.auditSink,
      mixin:: {},
    },
    // AuditSinkSpec holds the spec for the audit sink
    auditSinkSpec:: {
      new():: {},
      mixin:: {
        // Policy defines the policy for selecting which events should be sent to the webhook required
        policy:: {
          local __policyMixin(policy) = { policy+: policy },
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
          local __webhookMixin(webhook) = { webhook+: webhook },
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
            service:: {
              local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
              mixinInstance(service):: __serviceMixin(service),
              // `name` is the name of the service. Required
              withName(name):: self + __serviceMixin({ name: name }),
              // `namespace` is the namespace of the service. Required
              withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
              // `path` is an optional URL path which will be sent in any request to this service.
              withPath(path):: self + __serviceMixin({ path: path }),
              // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
              withPort(port):: self + __serviceMixin({ port: port }),
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
    },
    // Policy defines the configuration of how audit events are logged
    policy:: {
      new():: {},
      // The Level that all requests are recorded at. available options: None, Metadata, Request, RequestResponse required
      withLevel(level):: self + { level: level },
      // Stages is a list of stages for which events are created.
      withStages(stages):: self + if std.type(stages) == 'array' then { stages: stages } else { stages: [stages] },
      // Stages is a list of stages for which events are created.
      withStagesMixin(stages):: self + if std.type(stages) == 'array' then { stages+: stages } else { stages+: [stages] },
      mixin:: {},
    },
    // ServiceReference holds a reference to Service.legacy.k8s.io
    serviceReference:: {
      new():: {},
      // `name` is the name of the service. Required
      withName(name):: self + { name: name },
      // `namespace` is the namespace of the service. Required
      withNamespace(namespace):: self + { namespace: namespace },
      // `path` is an optional URL path which will be sent in any request to this service.
      withPath(path):: self + { path: path },
      // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
      withPort(port):: self + { port: port },
      mixin:: {},
    },
    // Webhook holds the configuration of the webhook
    webhook:: {
      new():: {},
      mixin:: {
        // ClientConfig holds the connection parameters for the webhook required
        clientConfig:: {
          local __clientConfigMixin(clientConfig) = { clientConfig+: clientConfig },
          mixinInstance(clientConfig):: __clientConfigMixin(clientConfig),
          // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
          withCaBundle(caBundle):: self + __clientConfigMixin({ caBundle: caBundle }),
          // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
          //
          // If the webhook is running within the cluster, then you should use `service`.
          service:: {
            local __serviceMixin(service) = __clientConfigMixin({ service+: service }),
            mixinInstance(service):: __serviceMixin(service),
            // `name` is the name of the service. Required
            withName(name):: self + __serviceMixin({ name: name }),
            // `namespace` is the namespace of the service. Required
            withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
            // `path` is an optional URL path which will be sent in any request to this service.
            withPath(path):: self + __serviceMixin({ path: path }),
            // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
            withPort(port):: self + __serviceMixin({ port: port }),
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
          local __throttleMixin(throttle) = { throttle+: throttle },
          mixinInstance(throttle):: __throttleMixin(throttle),
          // ThrottleBurst is the maximum number of events sent at the same moment default 15 QPS
          withBurst(burst):: self + __throttleMixin({ burst: burst }),
          // ThrottleQPS maximum number of batches per second default 10 QPS
          withQps(qps):: self + __throttleMixin({ qps: qps }),
        },
        throttleType:: hidden.auditregistration.v1alpha1.webhookThrottleConfig,
      },
    },
    // WebhookClientConfig contains the information to make a connection with the webhook
    webhookClientConfig:: {
      new():: {},
      // `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
      withCaBundle(caBundle):: self + { caBundle: caBundle },
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
      withUrl(url):: self + { url: url },
      mixin:: {
        // `service` is a reference to the service for this webhook. Either `service` or `url` must be specified.
        //
        // If the webhook is running within the cluster, then you should use `service`.
        service:: {
          local __serviceMixin(service) = { service+: service },
          mixinInstance(service):: __serviceMixin(service),
          // `name` is the name of the service. Required
          withName(name):: self + __serviceMixin({ name: name }),
          // `namespace` is the namespace of the service. Required
          withNamespace(namespace):: self + __serviceMixin({ namespace: namespace }),
          // `path` is an optional URL path which will be sent in any request to this service.
          withPath(path):: self + __serviceMixin({ path: path }),
          // If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).
          withPort(port):: self + __serviceMixin({ port: port }),
        },
        serviceType:: hidden.auditregistration.v1alpha1.serviceReference,
      },
    },
    // WebhookThrottleConfig holds the configuration for throttling events
    webhookThrottleConfig:: {
      new():: {},
      // ThrottleBurst is the maximum number of events sent at the same moment default 15 QPS
      withBurst(burst):: self + { burst: burst },
      // ThrottleQPS maximum number of batches per second default 10 QPS
      withQps(qps):: self + { qps: qps },
      mixin:: {},
    },
  },
  v2beta1:: {
    local apiVersion = { apiVersion: 'autoscaling/v2beta1' },
    // CrossVersionObjectReference contains enough information to let you identify the referred resource.
    crossVersionObjectReference:: {
      new():: {},
      // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
      withKind(kind):: self + { kind: kind },
      // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
      withName(name):: self + { name: name },
      mixin:: {},
    },
    // ExternalMetricSource indicates how to scale on a metric not associated with any Kubernetes object (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster). Exactly one "target" type should be set.
    externalMetricSource:: {
      new():: {},
      // metricName is the name of the metric in question.
      withMetricName(metricName):: self + { metricName: metricName },
      mixin:: {
        // metricSelector is used to identify a specific time series within a given metric.
        metricSelector:: {
          local __metricSelectorMixin(metricSelector) = { metricSelector+: metricSelector },
          mixinInstance(metricSelector):: __metricSelectorMixin(metricSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions: matchExpressions }) else __metricSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions+: matchExpressions }) else __metricSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __metricSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __metricSelectorMixin({ matchLabels+: matchLabels }),
        },
        metricSelectorType:: hidden.meta.v1.labelSelector,
        // targetAverageValue is the target per-pod value of global metric (as a quantity). Mutually exclusive with TargetValue.
        targetAverageValue:: {
          local __targetAverageValueMixin(targetAverageValue) = { targetAverageValue+: targetAverageValue },
          mixinInstance(targetAverageValue):: __targetAverageValueMixin(targetAverageValue),
        },
        targetAverageValueType:: hidden.core.resource.quantity,
        // targetValue is the target value of the metric (as a quantity). Mutually exclusive with TargetAverageValue.
        targetValue:: {
          local __targetValueMixin(targetValue) = { targetValue+: targetValue },
          mixinInstance(targetValue):: __targetValueMixin(targetValue),
        },
        targetValueType:: hidden.core.resource.quantity,
      },
    },
    // ExternalMetricStatus indicates the current value of a global metric not associated with any Kubernetes object.
    externalMetricStatus:: {
      new():: {},
      // metricName is the name of a metric used for autoscaling in metric system.
      withMetricName(metricName):: self + { metricName: metricName },
      mixin:: {
        // currentAverageValue is the current value of metric averaged over autoscaled pods.
        currentAverageValue:: {
          local __currentAverageValueMixin(currentAverageValue) = { currentAverageValue+: currentAverageValue },
          mixinInstance(currentAverageValue):: __currentAverageValueMixin(currentAverageValue),
        },
        currentAverageValueType:: hidden.core.resource.quantity,
        // currentValue is the current value of the metric (as a quantity)
        currentValue:: {
          local __currentValueMixin(currentValue) = { currentValue+: currentValue },
          mixinInstance(currentValue):: __currentValueMixin(currentValue),
        },
        currentValueType:: hidden.core.resource.quantity,
        // metricSelector is used to identify a specific time series within a given metric.
        metricSelector:: {
          local __metricSelectorMixin(metricSelector) = { metricSelector+: metricSelector },
          mixinInstance(metricSelector):: __metricSelectorMixin(metricSelector),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions: matchExpressions }) else __metricSelectorMixin({ matchExpressions: [matchExpressions] }),
          // matchExpressions is a list of label selector requirements. The requirements are ANDed.
          withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions+: matchExpressions }) else __metricSelectorMixin({ matchExpressions+: [matchExpressions] }),
          matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabels(matchLabels):: self + __metricSelectorMixin({ matchLabels: matchLabels }),
          // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
          withMatchLabelsMixin(matchLabels):: self + __metricSelectorMixin({ matchLabels+: matchLabels }),
        },
        metricSelectorType:: hidden.meta.v1.labelSelector,
      },
    },
    // HorizontalPodAutoscalerCondition describes the state of a HorizontalPodAutoscaler at a certain point.
    horizontalPodAutoscalerCondition:: {
      new():: {},
      // lastTransitionTime is the last time the condition transitioned from one status to another
      withLastTransitionTime(lastTransitionTime):: self + { lastTransitionTime: lastTransitionTime },
      // message is a human-readable explanation containing details about the transition
      withMessage(message):: self + { message: message },
      // reason is the reason for the condition's last transition.
      withReason(reason):: self + { reason: reason },
      // status is the status of the condition (True, False, Unknown)
      withStatus(status):: self + { status: status },
      // type describes the current condition
      withType(type):: self + { type: type },
      mixin:: {},
    },
    // HorizontalPodAutoscaler is a list of horizontal pod autoscaler objects.
    horizontalPodAutoscalerList:: {
      new(items=''):: self.withItems(items),
      // items is the list of horizontal pod autoscaler objects.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // items is the list of horizontal pod autoscaler objects.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.autoscaling.v2beta1.horizontalPodAutoscaler,
      mixin:: {},
    },
    // HorizontalPodAutoscalerSpec describes the desired functionality of the HorizontalPodAutoscaler.
    horizontalPodAutoscalerSpec:: {
      new():: {},
      // maxReplicas is the upper limit for the number of replicas to which the autoscaler can scale up. It cannot be less that minReplicas.
      withMaxReplicas(maxReplicas):: self + { maxReplicas: maxReplicas },
      // metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond.
      withMetrics(metrics):: self + if std.type(metrics) == 'array' then { metrics: metrics } else { metrics: [metrics] },
      // metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond.
      withMetricsMixin(metrics):: self + if std.type(metrics) == 'array' then { metrics+: metrics } else { metrics+: [metrics] },
      metricsType:: hidden.autoscaling.v2beta1.metricSpec,
      // minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available.
      withMinReplicas(minReplicas):: self + { minReplicas: minReplicas },
      mixin:: {
        // scaleTargetRef points to the target resource to scale, and is used to the pods for which metrics should be collected, as well as to actually change the replica count.
        scaleTargetRef:: {
          local __scaleTargetRefMixin(scaleTargetRef) = { scaleTargetRef+: scaleTargetRef },
          mixinInstance(scaleTargetRef):: __scaleTargetRefMixin(scaleTargetRef),
          // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
          withKind(kind):: self + __scaleTargetRefMixin({ kind: kind }),
          // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __scaleTargetRefMixin({ name: name }),
        },
        scaleTargetRefType:: hidden.autoscaling.v2beta1.crossVersionObjectReference,
      },
    },
    // HorizontalPodAutoscalerStatus describes the current status of a horizontal pod autoscaler.
    horizontalPodAutoscalerStatus:: {
      new():: {},
      // conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.
      withConditions(conditions):: self + if std.type(conditions) == 'array' then { conditions: conditions } else { conditions: [conditions] },
      // conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.
      withConditionsMixin(conditions):: self + if std.type(conditions) == 'array' then { conditions+: conditions } else { conditions+: [conditions] },
      conditionsType:: hidden.autoscaling.v2beta1.horizontalPodAutoscalerCondition,
      // currentMetrics is the last read state of the metrics used by this autoscaler.
      withCurrentMetrics(currentMetrics):: self + if std.type(currentMetrics) == 'array' then { currentMetrics: currentMetrics } else { currentMetrics: [currentMetrics] },
      // currentMetrics is the last read state of the metrics used by this autoscaler.
      withCurrentMetricsMixin(currentMetrics):: self + if std.type(currentMetrics) == 'array' then { currentMetrics+: currentMetrics } else { currentMetrics+: [currentMetrics] },
      currentMetricsType:: hidden.autoscaling.v2beta1.metricStatus,
      // currentReplicas is current number of replicas of pods managed by this autoscaler, as last seen by the autoscaler.
      withCurrentReplicas(currentReplicas):: self + { currentReplicas: currentReplicas },
      // desiredReplicas is the desired number of replicas of pods managed by this autoscaler, as last calculated by the autoscaler.
      withDesiredReplicas(desiredReplicas):: self + { desiredReplicas: desiredReplicas },
      // lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods, used by the autoscaler to control how often the number of pods is changed.
      withLastScaleTime(lastScaleTime):: self + { lastScaleTime: lastScaleTime },
      // observedGeneration is the most recent generation observed by this autoscaler.
      withObservedGeneration(observedGeneration):: self + { observedGeneration: observedGeneration },
      mixin:: {},
    },
    // MetricSpec specifies how to scale based on a single metric (only `type` and one other matching field should be set at once).
    metricSpec:: {
      new():: {},
      // type is the type of metric source.  It should be one of "Object", "Pods" or "Resource", each mapping to a matching field in the object.
      withType(type):: self + { type: type },
      mixin:: {
        // external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
        external:: {
          local __externalMixin(external) = { external+: external },
          mixinInstance(external):: __externalMixin(external),
          // metricName is the name of the metric in question.
          withMetricName(metricName):: self + __externalMixin({ metricName: metricName }),
          // metricSelector is used to identify a specific time series within a given metric.
          metricSelector:: {
            local __metricSelectorMixin(metricSelector) = __externalMixin({ metricSelector+: metricSelector }),
            mixinInstance(metricSelector):: __metricSelectorMixin(metricSelector),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions: matchExpressions }) else __metricSelectorMixin({ matchExpressions: [matchExpressions] }),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions+: matchExpressions }) else __metricSelectorMixin({ matchExpressions+: [matchExpressions] }),
            matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabels(matchLabels):: self + __metricSelectorMixin({ matchLabels: matchLabels }),
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabelsMixin(matchLabels):: self + __metricSelectorMixin({ matchLabels+: matchLabels }),
          },
          metricSelectorType:: hidden.meta.v1.labelSelector,
          // targetAverageValue is the target per-pod value of global metric (as a quantity). Mutually exclusive with TargetValue.
          targetAverageValue:: {
            local __targetAverageValueMixin(targetAverageValue) = __externalMixin({ targetAverageValue+: targetAverageValue }),
            mixinInstance(targetAverageValue):: __targetAverageValueMixin(targetAverageValue),
          },
          targetAverageValueType:: hidden.core.resource.quantity,
          // targetValue is the target value of the metric (as a quantity). Mutually exclusive with TargetAverageValue.
          targetValue:: {
            local __targetValueMixin(targetValue) = __externalMixin({ targetValue+: targetValue }),
            mixinInstance(targetValue):: __targetValueMixin(targetValue),
          },
          targetValueType:: hidden.core.resource.quantity,
        },
        externalType:: hidden.autoscaling.v2beta1.externalMetricSource,
        // object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
        object:: {
          local __objectMixin(object) = { object+: object },
          mixinInstance(object):: __objectMixin(object),
          // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __objectMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // metricName is the name of the metric in question.
          withMetricName(metricName):: self + __objectMixin({ metricName: metricName }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __objectMixin({ selector+: selector }),
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
          // target is the described Kubernetes object.
          target:: {
            local __targetMixin(target) = __objectMixin({ target+: target }),
            mixinInstance(target):: __targetMixin(target),
            // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
            withKind(kind):: self + __targetMixin({ kind: kind }),
            // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
            withName(name):: self + __targetMixin({ name: name }),
          },
          targetType:: hidden.autoscaling.v2beta1.crossVersionObjectReference,
          // targetValue is the target value of the metric (as a quantity).
          targetValue:: {
            local __targetValueMixin(targetValue) = __objectMixin({ targetValue+: targetValue }),
            mixinInstance(targetValue):: __targetValueMixin(targetValue),
          },
          targetValueType:: hidden.core.resource.quantity,
        },
        objectType:: hidden.autoscaling.v2beta1.objectMetricSource,
        // pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
        pods:: {
          local __podsMixin(pods) = { pods+: pods },
          mixinInstance(pods):: __podsMixin(pods),
          // metricName is the name of the metric in question
          withMetricName(metricName):: self + __podsMixin({ metricName: metricName }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __podsMixin({ selector+: selector }),
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
          // targetAverageValue is the target value of the average of the metric across all relevant pods (as a quantity)
          targetAverageValue:: {
            local __targetAverageValueMixin(targetAverageValue) = __podsMixin({ targetAverageValue+: targetAverageValue }),
            mixinInstance(targetAverageValue):: __targetAverageValueMixin(targetAverageValue),
          },
          targetAverageValueType:: hidden.core.resource.quantity,
        },
        podsType:: hidden.autoscaling.v2beta1.podsMetricSource,
        // resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
        resource:: {
          local __resourceMixin(resource) = { resource+: resource },
          mixinInstance(resource):: __resourceMixin(resource),
          // name is the name of the resource in question.
          withName(name):: self + __resourceMixin({ name: name }),
          // targetAverageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
          withTargetAverageUtilization(targetAverageUtilization):: self + __resourceMixin({ targetAverageUtilization: targetAverageUtilization }),
          // targetAverageValue is the target value of the average of the resource metric across all relevant pods, as a raw value (instead of as a percentage of the request), similar to the "pods" metric source type.
          targetAverageValue:: {
            local __targetAverageValueMixin(targetAverageValue) = __resourceMixin({ targetAverageValue+: targetAverageValue }),
            mixinInstance(targetAverageValue):: __targetAverageValueMixin(targetAverageValue),
          },
          targetAverageValueType:: hidden.core.resource.quantity,
        },
        resourceType:: hidden.autoscaling.v2beta1.resourceMetricSource,
      },
    },
    // MetricStatus describes the last-read state of a single metric.
    metricStatus:: {
      new():: {},
      // type is the type of metric source.  It will be one of "Object", "Pods" or "Resource", each corresponds to a matching field in the object.
      withType(type):: self + { type: type },
      mixin:: {
        // external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
        external:: {
          local __externalMixin(external) = { external+: external },
          mixinInstance(external):: __externalMixin(external),
          // currentAverageValue is the current value of metric averaged over autoscaled pods.
          currentAverageValue:: {
            local __currentAverageValueMixin(currentAverageValue) = __externalMixin({ currentAverageValue+: currentAverageValue }),
            mixinInstance(currentAverageValue):: __currentAverageValueMixin(currentAverageValue),
          },
          currentAverageValueType:: hidden.core.resource.quantity,
          // currentValue is the current value of the metric (as a quantity)
          currentValue:: {
            local __currentValueMixin(currentValue) = __externalMixin({ currentValue+: currentValue }),
            mixinInstance(currentValue):: __currentValueMixin(currentValue),
          },
          currentValueType:: hidden.core.resource.quantity,
          // metricName is the name of a metric used for autoscaling in metric system.
          withMetricName(metricName):: self + __externalMixin({ metricName: metricName }),
          // metricSelector is used to identify a specific time series within a given metric.
          metricSelector:: {
            local __metricSelectorMixin(metricSelector) = __externalMixin({ metricSelector+: metricSelector }),
            mixinInstance(metricSelector):: __metricSelectorMixin(metricSelector),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressions(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions: matchExpressions }) else __metricSelectorMixin({ matchExpressions: [matchExpressions] }),
            // matchExpressions is a list of label selector requirements. The requirements are ANDed.
            withMatchExpressionsMixin(matchExpressions):: self + if std.type(matchExpressions) == 'array' then __metricSelectorMixin({ matchExpressions+: matchExpressions }) else __metricSelectorMixin({ matchExpressions+: [matchExpressions] }),
            matchExpressionsType:: hidden.meta.v1.labelSelectorRequirement,
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabels(matchLabels):: self + __metricSelectorMixin({ matchLabels: matchLabels }),
            // matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
            withMatchLabelsMixin(matchLabels):: self + __metricSelectorMixin({ matchLabels+: matchLabels }),
          },
          metricSelectorType:: hidden.meta.v1.labelSelector,
        },
        externalType:: hidden.autoscaling.v2beta1.externalMetricStatus,
        // object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
        object:: {
          local __objectMixin(object) = { object+: object },
          mixinInstance(object):: __objectMixin(object),
          // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __objectMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // currentValue is the current value of the metric (as a quantity).
          currentValue:: {
            local __currentValueMixin(currentValue) = __objectMixin({ currentValue+: currentValue }),
            mixinInstance(currentValue):: __currentValueMixin(currentValue),
          },
          currentValueType:: hidden.core.resource.quantity,
          // metricName is the name of the metric in question.
          withMetricName(metricName):: self + __objectMixin({ metricName: metricName }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set in the ObjectMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __objectMixin({ selector+: selector }),
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
          // target is the described Kubernetes object.
          target:: {
            local __targetMixin(target) = __objectMixin({ target+: target }),
            mixinInstance(target):: __targetMixin(target),
            // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
            withKind(kind):: self + __targetMixin({ kind: kind }),
            // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
            withName(name):: self + __targetMixin({ name: name }),
          },
          targetType:: hidden.autoscaling.v2beta1.crossVersionObjectReference,
        },
        objectType:: hidden.autoscaling.v2beta1.objectMetricStatus,
        // pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
        pods:: {
          local __podsMixin(pods) = { pods+: pods },
          mixinInstance(pods):: __podsMixin(pods),
          // currentAverageValue is the current value of the average of the metric across all relevant pods (as a quantity)
          currentAverageValue:: {
            local __currentAverageValueMixin(currentAverageValue) = __podsMixin({ currentAverageValue+: currentAverageValue }),
            mixinInstance(currentAverageValue):: __currentAverageValueMixin(currentAverageValue),
          },
          currentAverageValueType:: hidden.core.resource.quantity,
          // metricName is the name of the metric in question
          withMetricName(metricName):: self + __podsMixin({ metricName: metricName }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set in the PodsMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __podsMixin({ selector+: selector }),
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
        },
        podsType:: hidden.autoscaling.v2beta1.podsMetricStatus,
        // resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
        resource:: {
          local __resourceMixin(resource) = { resource+: resource },
          mixinInstance(resource):: __resourceMixin(resource),
          // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.  It will only be present if `targetAverageValue` was set in the corresponding metric specification.
          withCurrentAverageUtilization(currentAverageUtilization):: self + __resourceMixin({ currentAverageUtilization: currentAverageUtilization }),
          // currentAverageValue is the current value of the average of the resource metric across all relevant pods, as a raw value (instead of as a percentage of the request), similar to the "pods" metric source type. It will always be set, regardless of the corresponding metric specification.
          currentAverageValue:: {
            local __currentAverageValueMixin(currentAverageValue) = __resourceMixin({ currentAverageValue+: currentAverageValue }),
            mixinInstance(currentAverageValue):: __currentAverageValueMixin(currentAverageValue),
          },
          currentAverageValueType:: hidden.core.resource.quantity,
          // name is the name of the resource in question.
          withName(name):: self + __resourceMixin({ name: name }),
        },
        resourceType:: hidden.autoscaling.v2beta1.resourceMetricStatus,
      },
    },
    // ObjectMetricSource indicates how to scale on a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
    objectMetricSource:: {
      new():: {},
      // metricName is the name of the metric in question.
      withMetricName(metricName):: self + { metricName: metricName },
      mixin:: {
        // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
        averageValue:: {
          local __averageValueMixin(averageValue) = { averageValue+: averageValue },
          mixinInstance(averageValue):: __averageValueMixin(averageValue),
        },
        averageValueType:: hidden.core.resource.quantity,
        // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping When unset, just the metricName will be used to gather metrics.
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
        // target is the described Kubernetes object.
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
          withKind(kind):: self + __targetMixin({ kind: kind }),
          // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __targetMixin({ name: name }),
        },
        targetType:: hidden.autoscaling.v2beta1.crossVersionObjectReference,
        // targetValue is the target value of the metric (as a quantity).
        targetValue:: {
          local __targetValueMixin(targetValue) = { targetValue+: targetValue },
          mixinInstance(targetValue):: __targetValueMixin(targetValue),
        },
        targetValueType:: hidden.core.resource.quantity,
      },
    },
    // ObjectMetricStatus indicates the current value of a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
    objectMetricStatus:: {
      new():: {},
      // metricName is the name of the metric in question.
      withMetricName(metricName):: self + { metricName: metricName },
      mixin:: {
        // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
        averageValue:: {
          local __averageValueMixin(averageValue) = { averageValue+: averageValue },
          mixinInstance(averageValue):: __averageValueMixin(averageValue),
        },
        averageValueType:: hidden.core.resource.quantity,
        // currentValue is the current value of the metric (as a quantity).
        currentValue:: {
          local __currentValueMixin(currentValue) = { currentValue+: currentValue },
          mixinInstance(currentValue):: __currentValueMixin(currentValue),
        },
        currentValueType:: hidden.core.resource.quantity,
        // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set in the ObjectMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
        // target is the described Kubernetes object.
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
          withKind(kind):: self + __targetMixin({ kind: kind }),
          // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __targetMixin({ name: name }),
        },
        targetType:: hidden.autoscaling.v2beta1.crossVersionObjectReference,
      },
    },
    // PodsMetricSource indicates how to scale on a metric describing each pod in the current scale target (for example, transactions-processed-per-second). The values will be averaged together before being compared to the target value.
    podsMetricSource:: {
      new():: {},
      // metricName is the name of the metric in question
      withMetricName(metricName):: self + { metricName: metricName },
      mixin:: {
        // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping When unset, just the metricName will be used to gather metrics.
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
        // targetAverageValue is the target value of the average of the metric across all relevant pods (as a quantity)
        targetAverageValue:: {
          local __targetAverageValueMixin(targetAverageValue) = { targetAverageValue+: targetAverageValue },
          mixinInstance(targetAverageValue):: __targetAverageValueMixin(targetAverageValue),
        },
        targetAverageValueType:: hidden.core.resource.quantity,
      },
    },
    // PodsMetricStatus indicates the current value of a metric describing each pod in the current scale target (for example, transactions-processed-per-second).
    podsMetricStatus:: {
      new():: {},
      // metricName is the name of the metric in question
      withMetricName(metricName):: self + { metricName: metricName },
      mixin:: {
        // currentAverageValue is the current value of the average of the metric across all relevant pods (as a quantity)
        currentAverageValue:: {
          local __currentAverageValueMixin(currentAverageValue) = { currentAverageValue+: currentAverageValue },
          mixinInstance(currentAverageValue):: __currentAverageValueMixin(currentAverageValue),
        },
        currentAverageValueType:: hidden.core.resource.quantity,
        // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set in the PodsMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
      },
    },
    // ResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.  Only one "target" type should be set.
    resourceMetricSource:: {
      new():: {},
      // name is the name of the resource in question.
      withName(name):: self + { name: name },
      // targetAverageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
      withTargetAverageUtilization(targetAverageUtilization):: self + { targetAverageUtilization: targetAverageUtilization },
      mixin:: {
        // targetAverageValue is the target value of the average of the resource metric across all relevant pods, as a raw value (instead of as a percentage of the request), similar to the "pods" metric source type.
        targetAverageValue:: {
          local __targetAverageValueMixin(targetAverageValue) = { targetAverageValue+: targetAverageValue },
          mixinInstance(targetAverageValue):: __targetAverageValueMixin(targetAverageValue),
        },
        targetAverageValueType:: hidden.core.resource.quantity,
      },
    },
    // ResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    resourceMetricStatus:: {
      new():: {},
      // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.  It will only be present if `targetAverageValue` was set in the corresponding metric specification.
      withCurrentAverageUtilization(currentAverageUtilization):: self + { currentAverageUtilization: currentAverageUtilization },
      // name is the name of the resource in question.
      withName(name):: self + { name: name },
      mixin:: {
        // currentAverageValue is the current value of the average of the resource metric across all relevant pods, as a raw value (instead of as a percentage of the request), similar to the "pods" metric source type. It will always be set, regardless of the corresponding metric specification.
        currentAverageValue:: {
          local __currentAverageValueMixin(currentAverageValue) = { currentAverageValue+: currentAverageValue },
          mixinInstance(currentAverageValue):: __currentAverageValueMixin(currentAverageValue),
        },
        currentAverageValueType:: hidden.core.resource.quantity,
      },
    },
  },
  v2beta2:: {
    local apiVersion = { apiVersion: 'autoscaling/v2beta2' },
    // CrossVersionObjectReference contains enough information to let you identify the referred resource.
    crossVersionObjectReference:: {
      new():: {},
      // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
      withKind(kind):: self + { kind: kind },
      // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
      withName(name):: self + { name: name },
      mixin:: {},
    },
    // ExternalMetricSource indicates how to scale on a metric not associated with any Kubernetes object (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
    externalMetricSource:: {
      new():: {},
      mixin:: {
        // metric identifies the target metric by name and selector
        metric:: {
          local __metricMixin(metric) = { metric+: metric },
          mixinInstance(metric):: __metricMixin(metric),
          // name is the name of the given metric
          withName(name):: self + __metricMixin({ name: name }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
        },
        metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
        // target specifies the target value for the given metric
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
          withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
          // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // type represents whether the metric type is Utilization, Value, or AverageValue
          withType(type):: self + __targetMixin({ type: type }),
          // value is the target value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __targetMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        targetType:: hidden.autoscaling.v2beta2.metricTarget,
      },
    },
    // ExternalMetricStatus indicates the current value of a global metric not associated with any Kubernetes object.
    externalMetricStatus:: {
      new():: {},
      mixin:: {
        // current contains the current value for the given metric
        current:: {
          local __currentMixin(current) = { current+: current },
          mixinInstance(current):: __currentMixin(current),
          // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
          withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
          // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // value is the current value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __currentMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
        // metric identifies the target metric by name and selector
        metric:: {
          local __metricMixin(metric) = { metric+: metric },
          mixinInstance(metric):: __metricMixin(metric),
          // name is the name of the given metric
          withName(name):: self + __metricMixin({ name: name }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
        },
        metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
      },
    },
    // HorizontalPodAutoscalerCondition describes the state of a HorizontalPodAutoscaler at a certain point.
    horizontalPodAutoscalerCondition:: {
      new():: {},
      // lastTransitionTime is the last time the condition transitioned from one status to another
      withLastTransitionTime(lastTransitionTime):: self + { lastTransitionTime: lastTransitionTime },
      // message is a human-readable explanation containing details about the transition
      withMessage(message):: self + { message: message },
      // reason is the reason for the condition's last transition.
      withReason(reason):: self + { reason: reason },
      // status is the status of the condition (True, False, Unknown)
      withStatus(status):: self + { status: status },
      // type describes the current condition
      withType(type):: self + { type: type },
      mixin:: {},
    },
    // HorizontalPodAutoscalerList is a list of horizontal pod autoscaler objects.
    horizontalPodAutoscalerList:: {
      new(items=''):: self.withItems(items),
      // items is the list of horizontal pod autoscaler objects.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // items is the list of horizontal pod autoscaler objects.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.autoscaling.v2beta2.horizontalPodAutoscaler,
      mixin:: {},
    },
    // HorizontalPodAutoscalerSpec describes the desired functionality of the HorizontalPodAutoscaler.
    horizontalPodAutoscalerSpec:: {
      new():: {},
      // maxReplicas is the upper limit for the number of replicas to which the autoscaler can scale up. It cannot be less that minReplicas.
      withMaxReplicas(maxReplicas):: self + { maxReplicas: maxReplicas },
      // metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond. If not set, the default metric will be set to 80% average CPU utilization.
      withMetrics(metrics):: self + if std.type(metrics) == 'array' then { metrics: metrics } else { metrics: [metrics] },
      // metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond. If not set, the default metric will be set to 80% average CPU utilization.
      withMetricsMixin(metrics):: self + if std.type(metrics) == 'array' then { metrics+: metrics } else { metrics+: [metrics] },
      metricsType:: hidden.autoscaling.v2beta2.metricSpec,
      // minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available.
      withMinReplicas(minReplicas):: self + { minReplicas: minReplicas },
      mixin:: {
        // scaleTargetRef points to the target resource to scale, and is used to the pods for which metrics should be collected, as well as to actually change the replica count.
        scaleTargetRef:: {
          local __scaleTargetRefMixin(scaleTargetRef) = { scaleTargetRef+: scaleTargetRef },
          mixinInstance(scaleTargetRef):: __scaleTargetRefMixin(scaleTargetRef),
          // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
          withKind(kind):: self + __scaleTargetRefMixin({ kind: kind }),
          // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __scaleTargetRefMixin({ name: name }),
        },
        scaleTargetRefType:: hidden.autoscaling.v2beta2.crossVersionObjectReference,
      },
    },
    // HorizontalPodAutoscalerStatus describes the current status of a horizontal pod autoscaler.
    horizontalPodAutoscalerStatus:: {
      new():: {},
      // conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.
      withConditions(conditions):: self + if std.type(conditions) == 'array' then { conditions: conditions } else { conditions: [conditions] },
      // conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.
      withConditionsMixin(conditions):: self + if std.type(conditions) == 'array' then { conditions+: conditions } else { conditions+: [conditions] },
      conditionsType:: hidden.autoscaling.v2beta2.horizontalPodAutoscalerCondition,
      // currentMetrics is the last read state of the metrics used by this autoscaler.
      withCurrentMetrics(currentMetrics):: self + if std.type(currentMetrics) == 'array' then { currentMetrics: currentMetrics } else { currentMetrics: [currentMetrics] },
      // currentMetrics is the last read state of the metrics used by this autoscaler.
      withCurrentMetricsMixin(currentMetrics):: self + if std.type(currentMetrics) == 'array' then { currentMetrics+: currentMetrics } else { currentMetrics+: [currentMetrics] },
      currentMetricsType:: hidden.autoscaling.v2beta2.metricStatus,
      // currentReplicas is current number of replicas of pods managed by this autoscaler, as last seen by the autoscaler.
      withCurrentReplicas(currentReplicas):: self + { currentReplicas: currentReplicas },
      // desiredReplicas is the desired number of replicas of pods managed by this autoscaler, as last calculated by the autoscaler.
      withDesiredReplicas(desiredReplicas):: self + { desiredReplicas: desiredReplicas },
      // lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods, used by the autoscaler to control how often the number of pods is changed.
      withLastScaleTime(lastScaleTime):: self + { lastScaleTime: lastScaleTime },
      // observedGeneration is the most recent generation observed by this autoscaler.
      withObservedGeneration(observedGeneration):: self + { observedGeneration: observedGeneration },
      mixin:: {},
    },
    // MetricIdentifier defines the name and optionally selector for a metric
    metricIdentifier:: {
      new():: {},
      // name is the name of the given metric
      withName(name):: self + { name: name },
      mixin:: {
        // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
        selector:: {
          local __selectorMixin(selector) = { selector+: selector },
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
      },
    },
    // MetricSpec specifies how to scale based on a single metric (only `type` and one other matching field should be set at once).
    metricSpec:: {
      new():: {},
      // type is the type of metric source.  It should be one of "Object", "Pods" or "Resource", each mapping to a matching field in the object.
      withType(type):: self + { type: type },
      mixin:: {
        // external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
        external:: {
          local __externalMixin(external) = { external+: external },
          mixinInstance(external):: __externalMixin(external),
          // metric identifies the target metric by name and selector
          metric:: {
            local __metricMixin(metric) = __externalMixin({ metric+: metric }),
            mixinInstance(metric):: __metricMixin(metric),
            // name is the name of the given metric
            withName(name):: self + __metricMixin({ name: name }),
            // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
            selector:: {
              local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
          },
          metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
          // target specifies the target value for the given metric
          target:: {
            local __targetMixin(target) = __externalMixin({ target+: target }),
            mixinInstance(target):: __targetMixin(target),
            // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
            withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
            // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // type represents whether the metric type is Utilization, Value, or AverageValue
            withType(type):: self + __targetMixin({ type: type }),
            // value is the target value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __targetMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          targetType:: hidden.autoscaling.v2beta2.metricTarget,
        },
        externalType:: hidden.autoscaling.v2beta2.externalMetricSource,
        // object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
        object:: {
          local __objectMixin(object) = { object+: object },
          mixinInstance(object):: __objectMixin(object),
          describedObject:: {
            local __describedObjectMixin(describedObject) = __objectMixin({ describedObject+: describedObject }),
            mixinInstance(describedObject):: __describedObjectMixin(describedObject),
            // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
            withKind(kind):: self + __describedObjectMixin({ kind: kind }),
            // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
            withName(name):: self + __describedObjectMixin({ name: name }),
          },
          describedObjectType:: hidden.autoscaling.v2beta2.crossVersionObjectReference,
          // metric identifies the target metric by name and selector
          metric:: {
            local __metricMixin(metric) = __objectMixin({ metric+: metric }),
            mixinInstance(metric):: __metricMixin(metric),
            // name is the name of the given metric
            withName(name):: self + __metricMixin({ name: name }),
            // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
            selector:: {
              local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
          },
          metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
          // target specifies the target value for the given metric
          target:: {
            local __targetMixin(target) = __objectMixin({ target+: target }),
            mixinInstance(target):: __targetMixin(target),
            // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
            withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
            // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // type represents whether the metric type is Utilization, Value, or AverageValue
            withType(type):: self + __targetMixin({ type: type }),
            // value is the target value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __targetMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          targetType:: hidden.autoscaling.v2beta2.metricTarget,
        },
        objectType:: hidden.autoscaling.v2beta2.objectMetricSource,
        // pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
        pods:: {
          local __podsMixin(pods) = { pods+: pods },
          mixinInstance(pods):: __podsMixin(pods),
          // metric identifies the target metric by name and selector
          metric:: {
            local __metricMixin(metric) = __podsMixin({ metric+: metric }),
            mixinInstance(metric):: __metricMixin(metric),
            // name is the name of the given metric
            withName(name):: self + __metricMixin({ name: name }),
            // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
            selector:: {
              local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
          },
          metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
          // target specifies the target value for the given metric
          target:: {
            local __targetMixin(target) = __podsMixin({ target+: target }),
            mixinInstance(target):: __targetMixin(target),
            // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
            withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
            // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // type represents whether the metric type is Utilization, Value, or AverageValue
            withType(type):: self + __targetMixin({ type: type }),
            // value is the target value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __targetMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          targetType:: hidden.autoscaling.v2beta2.metricTarget,
        },
        podsType:: hidden.autoscaling.v2beta2.podsMetricSource,
        // resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
        resource:: {
          local __resourceMixin(resource) = { resource+: resource },
          mixinInstance(resource):: __resourceMixin(resource),
          // name is the name of the resource in question.
          withName(name):: self + __resourceMixin({ name: name }),
          // target specifies the target value for the given metric
          target:: {
            local __targetMixin(target) = __resourceMixin({ target+: target }),
            mixinInstance(target):: __targetMixin(target),
            // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
            withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
            // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // type represents whether the metric type is Utilization, Value, or AverageValue
            withType(type):: self + __targetMixin({ type: type }),
            // value is the target value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __targetMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          targetType:: hidden.autoscaling.v2beta2.metricTarget,
        },
        resourceType:: hidden.autoscaling.v2beta2.resourceMetricSource,
      },
    },
    // MetricStatus describes the last-read state of a single metric.
    metricStatus:: {
      new():: {},
      // type is the type of metric source.  It will be one of "Object", "Pods" or "Resource", each corresponds to a matching field in the object.
      withType(type):: self + { type: type },
      mixin:: {
        // external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
        external:: {
          local __externalMixin(external) = { external+: external },
          mixinInstance(external):: __externalMixin(external),
          // current contains the current value for the given metric
          current:: {
            local __currentMixin(current) = __externalMixin({ current+: current }),
            mixinInstance(current):: __currentMixin(current),
            // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
            withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
            // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // value is the current value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __currentMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
          // metric identifies the target metric by name and selector
          metric:: {
            local __metricMixin(metric) = __externalMixin({ metric+: metric }),
            mixinInstance(metric):: __metricMixin(metric),
            // name is the name of the given metric
            withName(name):: self + __metricMixin({ name: name }),
            // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
            selector:: {
              local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
          },
          metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
        },
        externalType:: hidden.autoscaling.v2beta2.externalMetricStatus,
        // object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
        object:: {
          local __objectMixin(object) = { object+: object },
          mixinInstance(object):: __objectMixin(object),
          // current contains the current value for the given metric
          current:: {
            local __currentMixin(current) = __objectMixin({ current+: current }),
            mixinInstance(current):: __currentMixin(current),
            // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
            withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
            // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // value is the current value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __currentMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
          describedObject:: {
            local __describedObjectMixin(describedObject) = __objectMixin({ describedObject+: describedObject }),
            mixinInstance(describedObject):: __describedObjectMixin(describedObject),
            // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
            withKind(kind):: self + __describedObjectMixin({ kind: kind }),
            // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
            withName(name):: self + __describedObjectMixin({ name: name }),
          },
          describedObjectType:: hidden.autoscaling.v2beta2.crossVersionObjectReference,
          // metric identifies the target metric by name and selector
          metric:: {
            local __metricMixin(metric) = __objectMixin({ metric+: metric }),
            mixinInstance(metric):: __metricMixin(metric),
            // name is the name of the given metric
            withName(name):: self + __metricMixin({ name: name }),
            // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
            selector:: {
              local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
          },
          metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
        },
        objectType:: hidden.autoscaling.v2beta2.objectMetricStatus,
        // pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
        pods:: {
          local __podsMixin(pods) = { pods+: pods },
          mixinInstance(pods):: __podsMixin(pods),
          // current contains the current value for the given metric
          current:: {
            local __currentMixin(current) = __podsMixin({ current+: current }),
            mixinInstance(current):: __currentMixin(current),
            // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
            withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
            // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // value is the current value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __currentMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
          // metric identifies the target metric by name and selector
          metric:: {
            local __metricMixin(metric) = __podsMixin({ metric+: metric }),
            mixinInstance(metric):: __metricMixin(metric),
            // name is the name of the given metric
            withName(name):: self + __metricMixin({ name: name }),
            // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
            selector:: {
              local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
          },
          metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
        },
        podsType:: hidden.autoscaling.v2beta2.podsMetricStatus,
        // resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
        resource:: {
          local __resourceMixin(resource) = { resource+: resource },
          mixinInstance(resource):: __resourceMixin(resource),
          // current contains the current value for the given metric
          current:: {
            local __currentMixin(current) = __resourceMixin({ current+: current }),
            mixinInstance(current):: __currentMixin(current),
            // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
            withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
            // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
            averageValue:: {
              local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
              mixinInstance(averageValue):: __averageValueMixin(averageValue),
            },
            averageValueType:: hidden.core.resource.quantity,
            // value is the current value of the metric (as a quantity).
            value:: {
              local __valueMixin(value) = __currentMixin({ value+: value }),
              mixinInstance(value):: __valueMixin(value),
            },
            valueType:: hidden.core.resource.quantity,
          },
          currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
          // Name is the name of the resource in question.
          withName(name):: self + __resourceMixin({ name: name }),
        },
        resourceType:: hidden.autoscaling.v2beta2.resourceMetricStatus,
      },
    },
    // MetricTarget defines the target value, average value, or average utilization of a specific metric
    metricTarget:: {
      new():: {},
      // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
      withAverageUtilization(averageUtilization):: self + { averageUtilization: averageUtilization },
      // type represents whether the metric type is Utilization, Value, or AverageValue
      withType(type):: self + { type: type },
      mixin:: {
        // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
        averageValue:: {
          local __averageValueMixin(averageValue) = { averageValue+: averageValue },
          mixinInstance(averageValue):: __averageValueMixin(averageValue),
        },
        averageValueType:: hidden.core.resource.quantity,
        // value is the target value of the metric (as a quantity).
        value:: {
          local __valueMixin(value) = { value+: value },
          mixinInstance(value):: __valueMixin(value),
        },
        valueType:: hidden.core.resource.quantity,
      },
    },
    // MetricValueStatus holds the current value for a metric
    metricValueStatus:: {
      new():: {},
      // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
      withAverageUtilization(averageUtilization):: self + { averageUtilization: averageUtilization },
      mixin:: {
        // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
        averageValue:: {
          local __averageValueMixin(averageValue) = { averageValue+: averageValue },
          mixinInstance(averageValue):: __averageValueMixin(averageValue),
        },
        averageValueType:: hidden.core.resource.quantity,
        // value is the current value of the metric (as a quantity).
        value:: {
          local __valueMixin(value) = { value+: value },
          mixinInstance(value):: __valueMixin(value),
        },
        valueType:: hidden.core.resource.quantity,
      },
    },
    // ObjectMetricSource indicates how to scale on a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
    objectMetricSource:: {
      new():: {},
      mixin:: {
        describedObject:: {
          local __describedObjectMixin(describedObject) = { describedObject+: describedObject },
          mixinInstance(describedObject):: __describedObjectMixin(describedObject),
          // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
          withKind(kind):: self + __describedObjectMixin({ kind: kind }),
          // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __describedObjectMixin({ name: name }),
        },
        describedObjectType:: hidden.autoscaling.v2beta2.crossVersionObjectReference,
        // metric identifies the target metric by name and selector
        metric:: {
          local __metricMixin(metric) = { metric+: metric },
          mixinInstance(metric):: __metricMixin(metric),
          // name is the name of the given metric
          withName(name):: self + __metricMixin({ name: name }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
        },
        metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
        // target specifies the target value for the given metric
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
          withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
          // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // type represents whether the metric type is Utilization, Value, or AverageValue
          withType(type):: self + __targetMixin({ type: type }),
          // value is the target value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __targetMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        targetType:: hidden.autoscaling.v2beta2.metricTarget,
      },
    },
    // ObjectMetricStatus indicates the current value of a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
    objectMetricStatus:: {
      new():: {},
      mixin:: {
        // current contains the current value for the given metric
        current:: {
          local __currentMixin(current) = { current+: current },
          mixinInstance(current):: __currentMixin(current),
          // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
          withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
          // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // value is the current value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __currentMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
        describedObject:: {
          local __describedObjectMixin(describedObject) = { describedObject+: describedObject },
          mixinInstance(describedObject):: __describedObjectMixin(describedObject),
          // Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
          withKind(kind):: self + __describedObjectMixin({ kind: kind }),
          // Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
          withName(name):: self + __describedObjectMixin({ name: name }),
        },
        describedObjectType:: hidden.autoscaling.v2beta2.crossVersionObjectReference,
        // metric identifies the target metric by name and selector
        metric:: {
          local __metricMixin(metric) = { metric+: metric },
          mixinInstance(metric):: __metricMixin(metric),
          // name is the name of the given metric
          withName(name):: self + __metricMixin({ name: name }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
        },
        metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
      },
    },
    // PodsMetricSource indicates how to scale on a metric describing each pod in the current scale target (for example, transactions-processed-per-second). The values will be averaged together before being compared to the target value.
    podsMetricSource:: {
      new():: {},
      mixin:: {
        // metric identifies the target metric by name and selector
        metric:: {
          local __metricMixin(metric) = { metric+: metric },
          mixinInstance(metric):: __metricMixin(metric),
          // name is the name of the given metric
          withName(name):: self + __metricMixin({ name: name }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
        },
        metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
        // target specifies the target value for the given metric
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
          withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
          // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // type represents whether the metric type is Utilization, Value, or AverageValue
          withType(type):: self + __targetMixin({ type: type }),
          // value is the target value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __targetMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        targetType:: hidden.autoscaling.v2beta2.metricTarget,
      },
    },
    // PodsMetricStatus indicates the current value of a metric describing each pod in the current scale target (for example, transactions-processed-per-second).
    podsMetricStatus:: {
      new():: {},
      mixin:: {
        // current contains the current value for the given metric
        current:: {
          local __currentMixin(current) = { current+: current },
          mixinInstance(current):: __currentMixin(current),
          // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
          withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
          // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // value is the current value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __currentMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
        // metric identifies the target metric by name and selector
        metric:: {
          local __metricMixin(metric) = { metric+: metric },
          mixinInstance(metric):: __metricMixin(metric),
          // name is the name of the given metric
          withName(name):: self + __metricMixin({ name: name }),
          // selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
          selector:: {
            local __selectorMixin(selector) = __metricMixin({ selector+: selector }),
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
        },
        metricType:: hidden.autoscaling.v2beta2.metricIdentifier,
      },
    },
    // ResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.  Only one "target" type should be set.
    resourceMetricSource:: {
      new():: {},
      // name is the name of the resource in question.
      withName(name):: self + { name: name },
      mixin:: {
        // target specifies the target value for the given metric
        target:: {
          local __targetMixin(target) = { target+: target },
          mixinInstance(target):: __targetMixin(target),
          // averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
          withAverageUtilization(averageUtilization):: self + __targetMixin({ averageUtilization: averageUtilization }),
          // averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __targetMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // type represents whether the metric type is Utilization, Value, or AverageValue
          withType(type):: self + __targetMixin({ type: type }),
          // value is the target value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __targetMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        targetType:: hidden.autoscaling.v2beta2.metricTarget,
      },
    },
    // ResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    resourceMetricStatus:: {
      new():: {},
      // Name is the name of the resource in question.
      withName(name):: self + { name: name },
      mixin:: {
        // current contains the current value for the given metric
        current:: {
          local __currentMixin(current) = { current+: current },
          mixinInstance(current):: __currentMixin(current),
          // currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
          withAverageUtilization(averageUtilization):: self + __currentMixin({ averageUtilization: averageUtilization }),
          // averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
          averageValue:: {
            local __averageValueMixin(averageValue) = __currentMixin({ averageValue+: averageValue }),
            mixinInstance(averageValue):: __averageValueMixin(averageValue),
          },
          averageValueType:: hidden.core.resource.quantity,
          // value is the current value of the metric (as a quantity).
          value:: {
            local __valueMixin(value) = __currentMixin({ value+: value }),
            mixinInstance(value):: __valueMixin(value),
          },
          valueType:: hidden.core.resource.quantity,
        },
        currentType:: hidden.autoscaling.v2beta2.metricValueStatus,
      },
    },
  },
  v2alpha1:: {
    local apiVersion = { apiVersion: 'batch/v2alpha1' },
    // CronJobList is a collection of cron jobs.
    cronJobList:: {
      new(items=''):: self.withItems(items),
      // items is the list of CronJobs.
      withItems(items):: self + if std.type(items) == 'array' then { items: items } else { items: [items] },
      // items is the list of CronJobs.
      withItemsMixin(items):: self + if std.type(items) == 'array' then { items+: items } else { items+: [items] },
      itemsType:: hidden.batch.v2alpha1.cronJob,
      mixin:: {},
    },
    // CronJobSpec describes how the job execution will look like and when it will actually run.
    cronJobSpec:: {
      new():: {},
      // Specifies how to treat concurrent executions of a Job. Valid values are: - "Allow" (default): allows CronJobs to run concurrently; - "Forbid": forbids concurrent runs, skipping next run if previous run hasn't finished yet; - "Replace": cancels currently running job and replaces it with a new one
      withConcurrencyPolicy(concurrencyPolicy):: self + { concurrencyPolicy: concurrencyPolicy },
      // The number of failed finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified.
      withFailedJobsHistoryLimit(failedJobsHistoryLimit):: self + { failedJobsHistoryLimit: failedJobsHistoryLimit },
      // The schedule in Cron format, see https://en.wikipedia.org/wiki/Cron.
      withSchedule(schedule):: self + { schedule: schedule },
      // Optional deadline in seconds for starting the job if it misses scheduled time for any reason.  Missed jobs executions will be counted as failed ones.
      withStartingDeadlineSeconds(startingDeadlineSeconds):: self + { startingDeadlineSeconds: startingDeadlineSeconds },
      // The number of successful finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified.
      withSuccessfulJobsHistoryLimit(successfulJobsHistoryLimit):: self + { successfulJobsHistoryLimit: successfulJobsHistoryLimit },
      // This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.  Defaults to false.
      withSuspend(suspend):: self + { suspend: suspend },
      mixin:: {
        // Specifies the job that will be created when executing a CronJob.
        jobTemplate:: {
          local __jobTemplateMixin(jobTemplate) = { jobTemplate+: jobTemplate },
          mixinInstance(jobTemplate):: __jobTemplateMixin(jobTemplate),
          // Standard object's metadata of the jobs created from this template. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
          metadata:: {
            local __metadataMixin(metadata) = __jobTemplateMixin({ metadata+: metadata }),
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
          // Specification of the desired behavior of the job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
          spec:: {
            local __specMixin(spec) = __jobTemplateMixin({ spec+: spec }),
            mixinInstance(spec):: __specMixin(spec),
            // Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer
            withActiveDeadlineSeconds(activeDeadlineSeconds):: self + __specMixin({ activeDeadlineSeconds: activeDeadlineSeconds }),
            // Specifies the number of retries before marking this job failed. Defaults to 6
            withBackoffLimit(backoffLimit):: self + __specMixin({ backoffLimit: backoffLimit }),
            // Specifies the desired number of successfully finished pods the job should be run with.  Setting to nil means that the success of any pod signals the success of all pods, and allows parallelism to have any positive value.  Setting to 1 means that parallelism is limited to 1 and the success of that pod signals the success of the job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
            withCompletions(completions):: self + __specMixin({ completions: completions }),
            // manualSelector controls generation of pod labels and pod selectors. Leave `manualSelector` unset unless you are certain what you are doing. When false or unset, the system pick labels unique to this job and appends those labels to the pod template.  When true, the user is responsible for picking unique labels and specifying the selector.  Failure to pick a unique label may cause this and other jobs to not function correctly.  However, You may see `manualSelector=true` in jobs that were created with the old `extensions/v1beta1` API. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#specifying-your-own-pod-selector
            withManualSelector(manualSelector):: self + __specMixin({ manualSelector: manualSelector }),
            // Specifies the maximum desired number of pods the job should run at any given time. The actual number of pods running in steady state will be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism), i.e. when the work left to do is less than max parallelism. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
            withParallelism(parallelism):: self + __specMixin({ parallelism: parallelism }),
            // A label query over pods that should match the pod count. Normally, the system sets this field for you. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
            // Describes the pod that will be created when executing a job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
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
                    // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                    withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                    // GMSACredentialSpecName is the name of the GMSA credential spec to use. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                    withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                    // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. This field is alpha-level and it is only honored by servers that enable the WindowsRunAsUserName feature flag.
                    withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
                  },
                  windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
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
                // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
                withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
                // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
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
            // ttlSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes. This field is alpha-level and is only honored by servers that enable the TTLAfterFinished feature.
            withTtlSecondsAfterFinished(ttlSecondsAfterFinished):: self + __specMixin({ ttlSecondsAfterFinished: ttlSecondsAfterFinished }),
          },
          specType:: hidden.batch.v1.jobSpec,
        },
        jobTemplateType:: hidden.batch.v2alpha1.jobTemplateSpec,
      },
    },
    // CronJobStatus represents the current state of a cron job.
    cronJobStatus:: {
      new():: {},
      // A list of pointers to currently running jobs.
      withActive(active):: self + if std.type(active) == 'array' then { active: active } else { active: [active] },
      // A list of pointers to currently running jobs.
      withActiveMixin(active):: self + if std.type(active) == 'array' then { active+: active } else { active+: [active] },
      activeType:: hidden.core.v1.objectReference,
      // Information when was the last time the job was successfully scheduled.
      withLastScheduleTime(lastScheduleTime):: self + { lastScheduleTime: lastScheduleTime },
      mixin:: {},
    },
    // JobTemplateSpec describes the data a Job should have when created from a template
    jobTemplateSpec:: {
      new():: {},
      mixin:: {
        // Standard object's metadata of the jobs created from this template. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
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
        // Specification of the desired behavior of the job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
        spec:: {
          local __specMixin(spec) = { spec+: spec },
          mixinInstance(spec):: __specMixin(spec),
          // Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer
          withActiveDeadlineSeconds(activeDeadlineSeconds):: self + __specMixin({ activeDeadlineSeconds: activeDeadlineSeconds }),
          // Specifies the number of retries before marking this job failed. Defaults to 6
          withBackoffLimit(backoffLimit):: self + __specMixin({ backoffLimit: backoffLimit }),
          // Specifies the desired number of successfully finished pods the job should be run with.  Setting to nil means that the success of any pod signals the success of all pods, and allows parallelism to have any positive value.  Setting to 1 means that parallelism is limited to 1 and the success of that pod signals the success of the job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
          withCompletions(completions):: self + __specMixin({ completions: completions }),
          // manualSelector controls generation of pod labels and pod selectors. Leave `manualSelector` unset unless you are certain what you are doing. When false or unset, the system pick labels unique to this job and appends those labels to the pod template.  When true, the user is responsible for picking unique labels and specifying the selector.  Failure to pick a unique label may cause this and other jobs to not function correctly.  However, You may see `manualSelector=true` in jobs that were created with the old `extensions/v1beta1` API. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#specifying-your-own-pod-selector
          withManualSelector(manualSelector):: self + __specMixin({ manualSelector: manualSelector }),
          // Specifies the maximum desired number of pods the job should run at any given time. The actual number of pods running in steady state will be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism), i.e. when the work left to do is less than max parallelism. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
          withParallelism(parallelism):: self + __specMixin({ parallelism: parallelism }),
          // A label query over pods that should match the pod count. Normally, the system sets this field for you. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
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
          // Describes the pod that will be created when executing a job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
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
                  // GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                  withGmsaCredentialSpec(gmsaCredentialSpec):: self + __windowsOptionsMixin({ gmsaCredentialSpec: gmsaCredentialSpec }),
                  // GMSACredentialSpecName is the name of the GMSA credential spec to use. This field is alpha-level and is only honored by servers that enable the WindowsGMSA feature flag.
                  withGmsaCredentialSpecName(gmsaCredentialSpecName):: self + __windowsOptionsMixin({ gmsaCredentialSpecName: gmsaCredentialSpecName }),
                  // The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. This field is alpha-level and it is only honored by servers that enable the WindowsRunAsUserName feature flag.
                  withRunAsUserName(runAsUserName):: self + __windowsOptionsMixin({ runAsUserName: runAsUserName }),
                },
                windowsOptionsType:: hidden.core.v1.windowsSecurityContextOptions,
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
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
              withTopologySpreadConstraints(topologySpreadConstraints):: self + if std.type(topologySpreadConstraints) == 'array' then __specMixin({ topologySpreadConstraints: topologySpreadConstraints }) else __specMixin({ topologySpreadConstraints: [topologySpreadConstraints] }),
              // TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. This field is alpha-level and is only honored by clusters that enables the EvenPodsSpread feature. All topologySpreadConstraints are ANDed.
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
          // ttlSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes. This field is alpha-level and is only honored by servers that enable the TTLAfterFinished feature.
          withTtlSecondsAfterFinished(ttlSecondsAfterFinished):: self + __specMixin({ ttlSecondsAfterFinished: ttlSecondsAfterFinished }),
        },
        specType:: hidden.batch.v1.jobSpec,
      },
    },
  },
  intstr:: {
    local apiVersion = { apiVersion: 'intstr' },
    // IntOrString is a type that can hold an int32 or a string.  When used in JSON or YAML marshalling and unmarshalling, it produces or consumes the inner type.  This allows you to have, for example, a JSON field that can accept a name or number.
    intOrString:: {
      new():: {},
      mixin:: {},
    },
  },
  resource:: {
    local apiVersion = { apiVersion: 'resource' },
    // Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and AsInt64() accessors.
    //
    // The serialization format is:
    //
    // <quantity>        ::= <signedNumber><suffix>
    // (Note that <suffix> may be empty, from the "" case in <decimalSI>.)
    // <digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= "+" | "-" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei
    // (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)
    // <decimalSI>       ::= m | "" | k | M | G | T | P | E
    // (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)
    // <decimalExponent> ::= "e" <signedNumber> | "E" <signedNumber>
    //
    // No matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.
    //
    // When a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.
    //
    // Before serializing, Quantity will be put in "canonical form". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:
    // a. No precision is lost
    // b. No fractional digits will be emitted
    // c. The exponent (or suffix) is as large as possible.
    // The sign will be omitted unless the number is negative.
    //
    // Examples:
    // 1.5 will be serialized as "1500m"
    // 1.5Gi will be serialized as "1536Mi"
    //
    // Note that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.
    //
    // Non-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)
    //
    // This format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.
    quantity:: {
      new():: {},
      mixin:: {},
    },
  },
}