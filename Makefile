# Get the source directory for this project
ISTIOIO_GO := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
export ISTIOIO_GO
SHELL := /bin/bash -o pipefail

# Environment for tests, the directory containing istio and deps binaries.
# Typically same as GOPATH/bin, so tests work seemlessly with IDEs.

export REPO_ROOT := $(shell git rev-parse --show-toplevel)

ISTIO_SERVE_DOMAIN ?= localhost
export ISTIO_SERVE_DOMAIN

ifeq ($(CONTEXT),production)
baseurl := "$(URL)"
endif

prepare:
	@npm install -y

site:
	@scripts/gen_site.sh

build: site
	@scripts/build_site.sh ""

build_nominify: site
	@scripts/build_site.sh "" -no_minify

build_with_archive: site
	@scripts/gen_site.sh
	@scripts/build_site.sh "/latest"
	@scripts/include_archive_site.sh

serve: site
	@hugo serve --baseURL "http://${ISTIO_SERVE_DOMAIN}:1313/latest/" --bind 0.0.0.0 --disableFastRender
