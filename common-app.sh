## k8s playground bash

## switchhosts
# https://github.com/oldj/SwitchHosts
brew cask install switchhosts

## helm
# https://helm.sh/docs/intro/install/
brew install helm

## initialize a helm chart repository
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

## ingress
# https://github.com/helm/charts/tree/master/stable/nginx-ingress
helm install --generate-name stable/nginx-ingress \
    --set controller.metrics.enabled=true

## cert-manager
# https://cert-manager.io/docs/installation/kubernetes/
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.1/deploy/manifests/00-crds.yaml
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install --generate-name jetstack/cert-manager \
    --namespace cert-manager

## kubeapps
# https://github.com/kubeapps/kubeapps/blob/master/docs/user/getting-started.md
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install --generate-name bitnami/kubeapps \
    --set ingress.enabled=true \
    --set ingress.certManager=true \
    --set useHelm3=true

kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo

## kubernetes-dashboard
# https://github.com/helm/charts/tree/master/stable/kubernetes-dashboard
helm install --generate-name stable/kubernetes-dashboard \
    --set enableSkipLogin=true \
    --set ingress.enabled=true \
    --set ingress.hosts={"kubernetes-dashboard.domain.com"} \
    --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set ingress.annotations."nginx\.ingress\.kubernetes\.io/backend-protocol"=HTTPS \
    --set ingress.tls\[0\].secretName="kubernetes-dashboard-tls" \
    --set ingress.tls\[0\].hosts={"kubernetes-dashboard.domain.com"} \
    --set rbac.clusterAdminRole=true

## chartmuseum
# https://github.com/helm/charts/tree/master/stable/chartmuseum
helm install --generate-name stable/chartmuseum \
    --set persistence.enabled=true