#!/bin/bash

d=$(cd $(dirname $0); pwd)
. "${d}/common.sh"

set -x

echo "Destroy clusters..."
kind delete cluster --name "${WORKLOAD_CLUSTER}"
kind delete cluster --name "${MANAGEMENT_CLUSTER}"
rm -rf "${d}/../.kube"
