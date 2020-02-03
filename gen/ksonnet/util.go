package ksonnet

import (
	"github.com/kube-jsonnet/k/gen/kubespec"
)

var (
	specialProperties = map[kubespec.PropertyName]kubespec.PropertyName{
		"apiVersion": "apiVersion",
		"kind":       "kind",
	}

	specialPropertiesList []string
)

func init() {
	for k := range specialProperties {
		specialPropertiesList = append(specialPropertiesList, string(k))
	}
}
