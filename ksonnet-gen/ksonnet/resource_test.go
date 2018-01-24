package ksonnet_test

import (
	"testing"

	"github.com/ksonnet/ksonnet-lib/ksonnet-gen/ksonnet"
	"github.com/stretchr/testify/assert"
)

func TestResource(t *testing.T) {
	props := make(map[string]ksonnet.Field)
	props["foo"] = ksonnet.NewLiteralField("name", "integer", "desc", "ref")

	c := ksonnet.Component{
		Group:   "group2",
		Version: "ver",
		Kind:    "kind",
	}

	r := ksonnet.NewResource("id", "desc", "group1", c, props)

	assert.Equal(t, "id", r.Identifier())
	assert.Equal(t, "desc", r.Description())
	assert.Equal(t, "group1", r.Group())
	assert.Equal(t, "ver", r.Version())
	assert.Equal(t, "kind", r.Kind())
	assert.Equal(t, "group2", r.QualifiedGroup())
	assert.True(t, r.IsResource())

	assert.Len(t, r.Properties(), 1)
}

func TestResource_no_group(t *testing.T) {
	props := make(map[string]ksonnet.Field)
	props["foo"] = ksonnet.NewLiteralField("name", "integer", "desc", "ref")

	c := ksonnet.Component{
		Group:   "group2",
		Version: "ver",
		Kind:    "kind",
	}

	r := ksonnet.NewResource("id", "desc", "", c, props)

	assert.Equal(t, "core", r.Group())
	assert.Equal(t, "group2", r.QualifiedGroup())

}
