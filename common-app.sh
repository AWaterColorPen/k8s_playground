## k8s playground bash

## switchhosts
# https://github.com/oldj/SwitchHosts
brew install switchhosts

## helm
# https://helm.sh/docs/intro/install/
brew install helm

## ingress
# https://artifacthub.io/packages/helm/nginx/nginx-ingress
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install --generate-name nginx-stable/nginx-ingress

## cert-manager
# https://cert-manager.io/docs/installation/helm/#installing-with-helm
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install --generate-name jetstack/cert-manager

## kubeapps
# https://artifacthub.io/packages/helm/bitnami/kubeapps
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install --generate-name bitnami/kubeapps \
    --set ingress.enabled=true \
    --set ingress.certManager=true \
    --set ingress.hostname="kubeapps.domain.com" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx

# https://github.com/vmware-tanzu/kubeapps/blob/main/site/content/docs/latest/tutorials/getting-started.md#step-2-create-a-demo-credential-with-which-to-access-kubeapps-and-kubernetes
kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kubeapps-operator-token
  namespace: default
  annotations:
    kubernetes.io/service-account.name: kubeapps-operator
type: kubernetes.io/service-account-token
EOF
kubectl get secret kubeapps-operator-token -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
