# k8s playground

## command

### dashboard

```shell
kubectl port-forward kubernetes-dashboard-669f9bbd46-6c94c 8443:8443 --namespace=kube-system
```

```shell
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'
```
