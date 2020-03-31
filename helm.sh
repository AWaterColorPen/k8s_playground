# chartmuseum
http://mirror.azure.cn/kubernetes/charts/chartmuseum-2.9.0.tgz
--set persistence.enabled=true

http://mirror.azure.cn/kubernetes/charts-incubator/

# prometheus
http://mirror.azure.cn/kubernetes/charts/prometheus-11.0.3.tgz
--set kubeStateMetrics.enabled=false
--set nodeExporter.enabled=false
--set alertmanager.baseURL="http://0.0.0.0:8080"
--set alertmanager.statefulSet.enabled=true
--set alertmanager.replicaCount=2
--set server.baseURL="https://0.0.0.0:8080/prometheus"
--set server.statefulSet.enabled=true
--set server.replicaCount=2
--set pushgateway.replicaCount=2
--set pushgateway.service.servicePort=8080


helm package /Users/slyao/src/charts/incubator/druid -u 

http://9.146.94.88:8080/charts/druid-0.2.0.tgz

- zookeeper
    image: pipcoo/k8szk:v3

-