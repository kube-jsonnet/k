package main

import (
	"flag"
	"fmt"
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
	log.SetFlags(0)

	outputDir := flag.String("dir", ".", "output directory")

	flag.Usage = func() {
		fmt.Println("gen transforms a Kubernetes swagger.json into a Jsonnet library")
		fmt.Println("\nUsage:")
		fmt.Println(" ", filepath.Base(os.Args[0]), "<openapi-spec> [flags]")
		fmt.Println("\nFlags:")
		flag.PrintDefaults()
	}
	flag.Parse()

	swag := flag.Arg(0)
	if swag == "" {
		log.Fatalln("argument <openapi-spec> required")
	}

	lib, err := ksonnet.GenerateLib(swag)
	if err != nil {
		log.Fatalln("generate lib:", err)
	}

	if err := os.MkdirAll(*outputDir, os.ModePerm); err != nil {
		log.Fatalln(err)
	}
	if err := writeFile(filepath.Join(*outputDir, k8s), lib.K8s); err != nil {
		log.Fatalln("k8s.libsonnet:", err)
	}
	if err := writeFile(filepath.Join(*outputDir, k), lib.Extensions); err != nil {
		log.Fatalln("k.libsonnet:", err)
	}
}

func writeFile(path string, b []byte) error {
	err := ioutil.WriteFile(path, b, 0644)
	return errors.Wrapf(err, "write %q", path)
}
