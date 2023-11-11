#!/bin/bash

set -e

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

set -x

echo "Create management cluster..."
if ! kind get clusters | grep -q "${MANAGEMENT_CLUSTER}" ; then
    kind create cluster --name "${MANAGEMENT_CLUSTER}" --image="kindest/node:${KIND_NODE_VERSION}" --config "${d}/kind-cluster-config.yaml"
fi
mkdir -p "${d}/../.kube"
kind get kubeconfig --name "${MANAGEMENT_CLUSTER}" > "${MANAGEMENT_KUBECONFIG}"

echo "Init management cluster..."
clusterctl init --infrastructure docker --kubeconfig "${MANAGEMENT_KUBECONFIG}"
kubectl_management get node -owide
kubectl_management get pod -A -owide
