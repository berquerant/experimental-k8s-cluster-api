#!/bin/bash

set -e

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

set -x

echo "Generate workload cluster manifest..."
generate_workload_manifest() {
    clusterctl generate cluster "${WORKLOAD_CLUSTER}" --flavor development \
               --kubernetes-version "$WORKLOAD_K8S_VERSION" \
               --control-plane-machine-count="$WORKLOAD_CONTROL_PLANE" \
               --worker-machine-count="$WORKLOAD_WORKER" \
               > "${WORKLOAD_MANIFEST}"
}
retry generate_workload_manifest

echo "Create workload cluster..."
retry kubectl_management apply -f "${WORKLOAD_MANIFEST}"

retry clusterctl describe cluster "${WORKLOAD_CLUSTER}"

kubectl_management get cluster
kubectl_management get kubeadmcontrolplane

get_workload_kubeconfig() {
    kind get kubeconfig --name "${WORKLOAD_CLUSTER}" > "${WORKLOAD_KUBECONFIG}"
}
retry get_workload_kubeconfig
kubectl_workload get node -owide

echo "Deploy calico..."
# https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#install-calico
retry kubectl_workload create -f "https://raw.githubusercontent.com/projectcalico/calico/${WORKLOAD_CALICO_VERSION}/manifests/tigera-operator.yaml"
retry kubectl_workload create -f "https://raw.githubusercontent.com/projectcalico/calico/${WORKLOAD_CALICO_VERSION}/manifests/custom-resources.yaml"
kubectl_workload -n calico-system wait --timeout=90s --for=condition=available daemonset.apps/calico-node
kubectl_workload -n calico-system wait --timeout=90s --for=condition=available daemonset.apps/csi-node-driver
kubectl_workload -n calico-system get pod -owide
