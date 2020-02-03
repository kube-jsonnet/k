# `gen`: Library generator

This folder contains the generator, responsible for transforming the
`swagger.json` into the Jsonnet library.

## Building

This project uses `go.mod`, so make sure to be outside of `$GOPATH`.

```bash
$ go build .
```

## Usage

From the project root:

```bash
$ go run ./gen -dir=1.14 https://raw.githubusercontent.com/kubernetes/kubernetes/release-1.14/api/openapi-spec/swagger.json
```
