## druid
# https://github.com/helm/charts/tree/master/incubator/druid
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm install --generate-name incubator/druid \
    --set coordinator.ingress.enabled=true \
    --set coordinator.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set coordinator.ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set coordinator.ingress.hosts={"druid.coordinator.domain.com"} \
    --set coordinator.ingress.path=/ \
    --set coordinator.ingress.tls\[0\].secretName="druid-coordinator-general-tls" \
    --set coordinator.ingress.tls\[0\].hosts={"druid.coordinator.domain.com"} \
    --set overlord.ingress.enabled=true \
    --set overlord.ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set overlord.ingress.annotations."kubernetes\.io/tls-acme"=\"true\" \
    --set overlord.ingress.hosts={"druid.overlord.domain.com"} \
    --set overlord.ingress.path=/ \
    --set overlord.ingress.tls\[0\].secretName="druid-overlord-general-tls" \
    --set overlord.ingress.tls\[0\].hosts={"druid.overlord.domain.com"} \
