package main

import (
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"github.com/pkg/errors"

	"github.com/kube-jsonnet/k/gen/ksonnet"
)

const (
	k8s = "k8s.libsonnet"
	k   = "k.libsonnet"
)

func main() {
	var outputDir = "."

	lib, err := ksonnet.GenerateLib(os.Args[1])
	if err != nil {
		log.Fatalln("generate lib", err)
	}

	if err := writeFile(filepath.Join(outputDir, k8s), lib.K8s); err != nil {
		log.Fatalln("k8s.libsonnet:", err)
	}
	if err := writeFile(filepath.Join(outputDir, k), lib.Extensions); err != nil {
		log.Fatalln("k.libsonnet", err)
	}
}

func writeFile(path string, b []byte) error {
	err := ioutil.WriteFile(path, b, 0644)
	return errors.Wrapf(err, "write %q", path)
}
