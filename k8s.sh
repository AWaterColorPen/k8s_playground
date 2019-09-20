## k8s playground bash

## switchhosts
# https://github.com/oldj/SwitchHosts
brew cask install switchhosts

## helm
# https://helm.sh/docs/using_helm/#installing-helm
brew install kubernetes-helm
helm init

## ingress
# https://github.com/helm/charts/tree/master/stable/nginx-ingress
helm install stable/nginx-ingress \
    --set controller.metrics.enabled=true

## cert-manager
# https://docs.cert-manager.io/en/latest/getting-started/install/kubernetes.html
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.10/deploy/manifests/00-crds.yaml
kubectl label namespace default certmanager.k8s.io/disable-validation=true
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install jetstack/cert-manager

## kubeapps
# https://github.com/kubeapps/kubeapps/tree/master/chart/kubeapps
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install bitnami/kubeapps \
    --set ingress.enabled=true \
    --set ingress.certManager=true

kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.token}' | base64 --decode && echo

## kubernetes-dashboard
# https://github.com/helm/charts/tree/master/stable/kubernetes-dashboard
helm install stable/kubernetes-dashboard \
    --set enableSkipLogin=true \
    --set ingress.enabled=true \
    --set ingress.hosts[0]=kubernetes-dashboard.local \
    --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set ingress.annotations."kubernetes\.io/tls-acme"="true" \
    --set ingress.annotations."nginx\.ingress\.kubernetes\.io/backend-protocol"="HTTPS" \
    --set ingress.tls[0].secretName=kubernetes-dashboard-tls \
    --set ingress.tls[0].hosts[0]=kubernetes-dashboard.local \
    --set rbac.clusterAdminRole=true

## prometheus-operator
# https://github.com/helm/charts/tree/master/stable/prometheus-operator
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/alertmanager.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheus.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheusrule.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/servicemonitor.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/podmonitor.crd.yaml
helm install stable/prometheus-operator \
    --set alertmanager.ingress.enabled=true \
    --set alertmanager.ingress.hosts[0]=alertmanager.local \
    --set alertmanager.ingress.paths[0]=/ \
    --set alertmanager.ingress.tls[0].secretName=alertmanager-general-tls \
    --set alertmanager.ingress.tls[0].hosts[0]=alertmanager.local \
    --set grafana.ingress.enabled=true \
    --set grafana.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set grafana.ingress.annotations."kubernetes\.io/tls-acme"="true" \
    --set grafana.ingress.hosts[0]=grafana.local \
    --set grafana.ingress.path=/ \
    --set grafana.ingress.tls[0].secretName=grafana-general-tls \
    --set grafana.ingress.tls[0].hosts[0]=grafana.local \
    --set prometheus.ingress.enabled=true \
    --set prometheus.ingress.hosts[0]=prometheus.local \
    --set prometheus.ingress.paths[0]=/ \
    --set prometheus.ingress.tls[0].secretName=prometheus-general-tls \
    --set prometheus.ingress.tls[0].hosts[0]=prometheus.local

## consul
# https://github.com/helm/charts/tree/master/stable/consul
helm install stable/consul \
    --set uiService.type="ClusterIP" \
    --set uiIngress.enabled=true \
    --set uiIngress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set uiIngress.annotations."kubernetes\.io/tls-acme"="true" \
    --set uiIngress.hosts[0]=consul.local \
    --set uiIngress.tls[0].secretName=consul-tls \
    --set uiIngress.tls[0].hosts[0]=consul.local 
