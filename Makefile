setup:
	./bin/setup-kind.sh
	./bin/setup-kubectl.sh
	./bin/setup-clusterctl.sh

cluster: management-cluster workload-cluster

management-cluster:
	./bin/setup-management-cluster.sh

workload-cluster:
	./bin/setup-workload-cluster.sh

test:
	./bin/test.sh

clean:
	./bin/destroy.sh
