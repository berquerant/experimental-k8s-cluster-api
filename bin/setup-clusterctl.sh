#!/bin/bash

set -e

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

install_binary \
    clusterctl \
    "https://github.com/kubernetes-sigs/cluster-api/releases/download/${CLUSTERCTL_VERSION}/clusterctl-darwin-amd64" \
    "https://github.com/kubernetes-sigs/cluster-api/releases/download/${CLUSTERCTL_VERSION}/clusterctl-darwin-arm64"
./bin/clusterctl version
