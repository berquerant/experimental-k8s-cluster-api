# experimental-k8s-cluster-api

https://cluster-api.sigs.k8s.io/user/quick-start.html by docker, calico, on macOS.

# Requirements

- [docker](https://www.docker.com/)
- [direnv](https://github.com/direnv/direnv)

# Usage

Install tools.

``` shell
direnv allow
make setup
```

Create management cluster and workload cluster.

``` shell
make cluster
```

Test connectivity between pods.

``` shell
make test
```

Destroy clusters.

``` shell
make clean
```
