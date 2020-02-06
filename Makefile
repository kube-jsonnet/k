.DEFAULT_GOAL: gen

.PHONY: clean gen
clean:
	rm -r 1.* || true

gen: clean
	go run ./gen.go

