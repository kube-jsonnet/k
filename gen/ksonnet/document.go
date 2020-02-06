package ksonnet

import (
	"sort"

	"github.com/pkg/errors"

	"github.com/kube-jsonnet/k/gen/log"
	nm "github.com/kube-jsonnet/k/gen/nodemaker"
)

type renderNodeFn func(c *Catalog, a *APIObject) (*nm.Object, error)

// Document represents a ksonnet lib document.
type Document struct {
	catalog *Catalog

	// these are defined to aid testing Document
	typesFn            func() ([]Type, error)
	fieldsFn           func() ([]Field, error)
	renderFn           func(fn renderNodeFn, c *Catalog, o *nm.Object, group Group) error
	renderGroups       func(doc *Document) (map[string]nm.Noder, error)
	renderHiddenGroups func(doc *Document, container *nm.Object) error
	objectNodeFn       func(c *Catalog, a *APIObject) (*nm.Object, error)
}

// NewDocument creates an instance of Document.
func NewDocument(catalog *Catalog) (*Document, error) {
	if catalog == nil {
		return nil, errors.New("catalog is nil")
	}

	return &Document{
		catalog:            catalog,
		typesFn:            catalog.Types,
		fieldsFn:           catalog.Fields,
		renderFn:           render,
		renderGroups:       renderGroups,
		renderHiddenGroups: renderHiddenGroups,
		objectNodeFn:       apiObjectNode,
	}, nil
}

// Groups returns an alphabetically sorted list of groups.
func (d *Document) Groups() ([]Group, error) {
	resources, err := d.typesFn()
	if err != nil {
		return nil, errors.Wrap(err, "retrieve resources")
	}

	var nodeObjects []Object
	for _, resource := range resources {
		res := resource
		nodeObjects = append(nodeObjects, &res)
	}

	return d.groups(nodeObjects)
}

// HiddenGroups returns an alphabetically sorted list of hidden groups.
func (d *Document) HiddenGroups() ([]Group, error) {
	resources, err := d.fieldsFn()
	if err != nil {
		return nil, errors.Wrap(err, "retrieve types")
	}

	var nodeObjects []Object
	for _, resource := range resources {
		res := resource
		nodeObjects = append(nodeObjects, &res)
	}

	return d.groups(nodeObjects)
}

func (d *Document) groups(resources []Object) ([]Group, error) {
	gMap := make(map[string]*Group)

	for i := range resources {
		res := resources[i]
		name := res.Group()

		g, ok := gMap[name]
		if !ok {
			g = NewGroup(name)
			gMap[name] = g
		}

		g.AddResource(res)
		gMap[name] = g
	}

	var groupNames []string

	for name := range gMap {
		groupNames = append(groupNames, name)
	}

	sort.Strings(groupNames)

	var groups []Group

	for _, name := range groupNames {
		g := gMap[name]
		groups = append(groups, *g)
	}

	return groups, nil
}

// Node converts a document to a node.
func (d *Document) Nodes() (map[string]nm.Noder, error) {
	main := nm.NewObject()

	metadata := map[string]interface{}{
		"kubernetesVersion": d.catalog.Version(),
		"checksum":          d.catalog.Checksum(),
	}
	metadataObj, err := nm.KVFromMap(metadata)
	if err != nil {
		return nil, errors.Wrap(err, "create metadata key")
	}
	main.Set(nm.InheritedKey("__ksonnet"), metadataObj)

	groups, err := d.renderGroups(d)
	if err != nil {
		return nil, err
	}

	hidden := nm.NewObject()
	if err := d.renderHiddenGroups(d, hidden); err != nil {
		return nil, err
	}
	main.Set(nm.LocalKey("hidden"), hidden)

	nodes := make([]nm.Noder, 0, len(groups))
	for name := range groups {
		nodes = append(nodes, nm.NewImport(name+".libsonnet"))
	}
	nodes = append(nodes, main)

	groups["k8s"] = add(nodes...)
	return groups, nil
}

func add(nodes ...nm.Noder) *nm.Binary {
	b := nm.NewBigBinary(nodes[0], nodes[1], nm.BopPlus)

	for _, n := range nodes[2:] {
		b = nm.NewBigBinary(b, n, nm.BopPlus)
	}

	return b
}

func render(fn renderNodeFn, catalog *Catalog, o *nm.Object, group Group) error {
	groupNode := group.Node()

	log.Debugln(group.Name())
	for _, version := range group.Versions() {
		versionNode := version.Node()

		log.Debugln(" ", version.Name())
		for _, apiObject := range version.APIObjects() {

			log.Debugln("   ", apiObject.Kind())
			objectNode, err := fn(catalog, &apiObject)
			if err != nil {
				return errors.Wrapf(err, "create node %s", apiObject.Kind())
			}

			versionNode.Set(
				nm.NewKey(apiObject.Kind(), nm.KeyOptComment(apiObject.Description())),
				objectNode)
		}

		groupNode.Set(nm.NewKey(version.Name()), versionNode)
	}

	o.Set(nm.NewKey(group.Name()), groupNode)
	return nil
}

func renderGroups(d *Document) (map[string]nm.Noder, error) {
	out := make(map[string]nm.Noder)

	groups, err := d.Groups()
	if err != nil {
		return nil, errors.Wrap(err, "retrieve groups")
	}

	for _, g := range groups {
		o := nm.NewObject()

		if err = d.renderFn(d.objectNodeFn, d.catalog, o, g); err != nil {
			return nil, errors.Wrap(err, "render groups")
		}

		out[g.Name()] = o
	}

	return out, nil
}

func renderHiddenGroups(d *Document, container *nm.Object) error {
	groups, err := d.HiddenGroups()
	if err != nil {
		return errors.Wrap(err, "retrieve hidden groups")
	}

	for _, g := range groups {
		if err = d.renderFn(d.objectNodeFn, d.catalog, container, g); err != nil {
			return errors.Wrap(err, "render hidden groups")
		}
	}

	return nil
}
