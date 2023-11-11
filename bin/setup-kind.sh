#!/bin/bash

set -e

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

install_binary \
    kind \
    "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-darwin-amd64" \
    "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-darwin-arm64"

bin/kind version
