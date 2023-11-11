#!/bin/bash

set -e

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

set -x

if ! kubectl_workload get ns | grep -q "${WORKLOAD_TEST_NAMESPACE}" ; then
    kubectl_workload create ns "${WORKLOAD_TEST_NAMESPACE}"
fi

app_manifest="${d}/../app/nginx.yml"

kubectl_test() {
    kubectl_workload -n "${WORKLOAD_TEST_NAMESPACE}" "$@"
}

echo "Deploy sample manifest..."
kubectl_test apply -f "${app_manifest}"
kubectl_test wait --timeout=90s --for=condition=available deployment/nginx
kubectl_test get pod -owide

echo "Connectivity test..."
first_pod_name="$(kubectl_test get pod -owide | awk 'NR==2{print $1}')"
second_pod_ip="$(kubectl_test get pod -owide | awk 'NR==3{print $6}')"
kubectl_test exec "${first_pod_name}" -- curl "${second_pod_ip}"
