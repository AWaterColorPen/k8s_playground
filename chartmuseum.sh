## chartmuseum
# https://github.com/helm/charts/tree/master/stable/chartmuseum
helm install --generate-name stable/chartmuseum \
    --set env.open.DISABLE_API=false \
    --set persistence.enabled=true
