## etcd
# https://github.com/bitnami/charts/tree/master/bitnami/etcd
helm install --generate-name bitnami/etcd \
    --set statefulset.replicaCount=3 \
    --set auth.rbac.enabled=false \
    --set metrics.enabled=true \
    --set persistence.enabled=false

## zookeeper
# https://github.com/bitnami/charts/tree/master/bitnami/zookeeper
helm install --generate-name bitnami/zookeeper \
    --set replicaCount=3 \
    --set metrics.enabled=true