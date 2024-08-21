CURRENTTAG:=$(shell git describe --tags --abbrev=0)
NEWTAG ?= $(shell bash -c 'read -p "Please provide a new tag (currnet tag - ${CURRENTTAG}): " newtag; echo $$newtag')
GOFLAGS=-mod=mod

#help: @ List available tasks
help:
	@clear
	@echo "Usage: make COMMAND"
	@echo "Commands :"
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(MAKEFILE_LIST)| tr -d '#' | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[32m%-15s\033[0m - %s\n", $$1, $$2}'

#deps: @ Download and install dependencies
deps:
	go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install -v github.com/go-critic/go-critic/cmd/gocritic@latest
	go install github.com/securego/gosec/v2/cmd/gosec@latest

#lint: @ Run lint
lint:
	golangci-lint run  ./...

#test: @ Run tests
test:
	@export GOFLAGS=$(GOFLAGS); export TZ="UTC"; go test -v ./...

#build: @ Build
build:
	@export GOFLAGS=$(GOFLAGS); export CGO_ENABLED=0; go build -a -o ./main/main ./main/main.go;

#run: @ Run locally
run: build
	@export GOFLAGS=$(GOFLAGS); export TZ="UTC"; go run main.go -env-file .env

#release: @ Create and push a new tag
release: build
	$(eval NT=$(NEWTAG))
	@echo -n "Are you sure to create and push ${NT} tag? [y/N] " && read ans && [ $${ans:-N} = y ]
	@echo ${NT} > ./pkg/api/version.txt
	@git add -A
	@git commit -a -s -m "Cut ${NT} release"
	@git tag ${NT}
	@git push origin ${NT}
	@git push
	@echo "Done."

#update: @ Update dependencies to latest versions
update:
	@export GOFLAGS=$(GOFLAGS); cd main; go get -u; go mod tidy; cd ..

critic:
	gocritic check -enableAll ./...

sec:
	gosec ./...
