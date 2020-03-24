## prometheus-operator
# https://github.com/helm/charts/tree/master/stable/prometheus-operator
helm install --generate-name stable/prometheus-operator \
    --set alertmanager.ingress.enabled=true \
    --set alertmanager.ingress.hosts={"alertmanager.domain.com"} \
    --set alertmanager.ingress.paths={"/"} \
    --set alertmanager.ingress.tls\[0\].secretName="alertmanager-general-tls" \
    --set alertmanager.ingress.tls\[0\].hosts={"alertmanager.domain.com"} \
    --set grafana.ingress.enabled=true \
    --set grafana.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set grafana.ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set grafana.ingress.hosts={"grafana.domain.com"} \
    --set grafana.ingress.path=/ \
    --set grafana.ingress.tls\[0\].secretName="grafana-general-tls" \
    --set grafana.ingress.tls\[0\].hosts={"grafana.domain.com"} \
    --set prometheus.ingress.enabled=true \
    --set prometheus.ingress.hosts={"prometheus.domain.com"} \
    --set prometheus.ingress.paths={"/"} \
    --set prometheus.ingress.tls\[0\].secretName="prometheus-general-tls" \
    --set prometheus.ingress.tls\[0\].hosts={"prometheus.domain.com"}

## prometheus
# https://github.com/helm/charts/tree/master/stable/prometheus
helm install --generate-name stable/prometheus \
    --set alertmanager.ingress.enabled=true \
    --set alertmanager.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set alertmanager.ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set alertmanager.ingress.hosts={"alertmanager.domain.com"} \
    --set alertmanager.ingress.tls\[0\].secretName="alertmanager-general-tls" \
    --set alertmanager.ingress.tls\[0\].hosts={"alertmanager.domain.com"} \
    --set kubeStateMetrics.enabled=false \
    --set nodeExporter.enabled=false \
    --set server.ingress.enabled=true \
    --set server.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set server.ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set server.ingress.hosts={"prometheus.domain.com"} \
    --set server.ingress.tls\[0\].secretName="prometheus-general-tls" \
    --set server.ingress.tls\[0\].hosts={"prometheus.domain.com"} \
    --set pushgateway.ingress.enabled=true \
    --set pushgateway.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set pushgateway.ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set pushgateway.ingress.hosts={"pushgateway.domain.com"} \
    --set pushgateway.ingress.tls\[0\].secretName="pushgateway-general-tls" \
    --set pushgateway.ingress.tls\[0\].hosts={"pushgateway.domain.com"}

## prometheus-adapter
# https://github.com/helm/charts/tree/master/stable/prometheus-adapter
helm install --generate-name stable/prometheus-adapter \
    --set prometheus.url="prometheus.domain.com"
