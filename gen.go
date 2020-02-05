package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
)

func main() {
	log.SetFlags(0)

	data, err := ioutil.ReadFile("versions.json")
	if err != nil {
		log.Fatalln(err)
	}

	vs := make(map[string]string)
	json.Unmarshal(data, &vs)

	for v, swag := range vs {
		log.Println(v)
		if err := sh("go", "run", "./gen", "-version="+v, "-dir="+v, swag); err != nil {
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
