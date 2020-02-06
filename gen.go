package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"strings"
)

const LDFLAGS = `-ldflags=-X main.Version=%s`

func main() {
	log.SetFlags(0)

	data, err := ioutil.ReadFile("versions.json")
	if err != nil {
		log.Fatalln(err)
	}

	vs := make(map[string]string)
	json.Unmarshal(data, &vs)

	if err := sh("go", "build", "-o=kgen", fmt.Sprintf(LDFLAGS, version()), "./gen"); err != nil {
		log.Fatalln("Building generator")
	}
	defer os.Remove("kgen")

	for v, swag := range vs {
		log.Println(v)
		if err := sh("./kgen", "-version="+v, "-dir="+v, swag); err != nil {
			log.Fatalf("Generating %s: %v", v, err)
		}
	}
}

func sh(c string, args ...string) error {
	cmd := exec.Command(c, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}

func version() string {
	cmd := exec.Command("git", "describe", "--tags", "--dirty", "--always")
	buf := bytes.Buffer{}
	cmd.Stdout = &buf
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalln(err)
	}

	return strings.TrimSuffix(buf.String(), "\n")
}
