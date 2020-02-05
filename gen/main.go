package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"regexp"

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
	target := flag.String("target", "", "<optional> regex pattern to filter apiGroup")

	name := flag.String("name", "Kubernetes", "name of the generated library")
	version := flag.String("version", "", "<optional> version of the generated library (defaults to specified in swagger.json)")

	flag.Usage = func() {
		fmt.Println("gen transforms a Kubernetes swagger.json into a Jsonnet library")
		fmt.Println("\nUsage:")
		fmt.Println(" ", filepath.Base(os.Args[0]), "[flags] <openapi-spec>")
		fmt.Println("\nFlags:")
		flag.PrintDefaults()
	}
	flag.Parse()

	if len(flag.Args()) == 0 {
		flag.Usage()
		os.Exit(0)
	}

	if err := gen(ksonnet.GenOpts{
		OpenAPI: flag.Arg(0),
		Target:  regexp.MustCompile(*target),
		Name:    *name,
		Version: *version,
	}, *outputDir); err != nil {
		log.Fatalln(err)
	}

}

func gen(opts ksonnet.GenOpts, dir string) error {
	lib, err := ksonnet.GenerateLib(opts)
	if err != nil {
		return err
	}

	if err := os.MkdirAll(dir, os.ModePerm); err != nil {
		return err
	}
	if err := writeFile(filepath.Join(dir, k8s), lib.K8s); err != nil {
		return fmt.Errorf("k8s.libsonnet: %w", err)
	}
	if err := writeFile(filepath.Join(dir, k), lib.Extensions); err != nil {
		return fmt.Errorf("k.libsonnet: %w", err)
	}
	return nil
}

func writeFile(path string, b []byte) error {
	err := ioutil.WriteFile(path, b, 0644)
	return errors.Wrapf(err, "write %q", path)
}
