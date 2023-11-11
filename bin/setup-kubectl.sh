#!/bin/bash

set -e

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

install_binary \
    kubectl \
    "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/darwin/amd64/kubectl" \
    "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/darwin/arm64/kubectl"
