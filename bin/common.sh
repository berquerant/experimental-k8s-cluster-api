d=$(cd $(dirname $0); pwd)

install_binary() {
    name="$1"
    x86_url="$2"
    arm_url="$3"

    # For Intel Macs
    [ "$(uname -m)" = x86_64 ] && wget -O "$name" "$x86_url"
    # For M1 / ARM Macs
    [ "$(uname -m)" = arm64 ] && wget -O "$name" "$arm_url"

    chmod +x "./${name}"
    mv "./${name}" "${d}/../bin/"
}

kind() {
    "${d}/kind" "$@"
}

clusterctl() {
    "${d}/clusterctl" "$@"
}

kubectl() {
    "${d}/kubectl" "$@"
}

kubectl_management() {
    kubectl --kubeconfig "${MANAGEMENT_KUBECONFIG}" "$@"
}

kubectl_workload() {
    kubectl --kubeconfig "${WORKLOAD_KUBECONFIG}" "$@"
}

retry() {
    retry_count=0
    while ! "$@" ; do
        retry_count="$(expr $retry_count + 1)"
        if [ "$retry_count" -ge 10 ] ; then
            echo "Retry[exhausted] $*"
            return 1
        fi
        echo "Retry[${retry_count}] $* after 10 seconds..."
        sleep 10
    done
}
