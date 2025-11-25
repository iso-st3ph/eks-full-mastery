helm upgrade --install metrics-server metrics-server/metrics-server \
  -n kube-system

kubectl get deployment metrics-server -n kube-system
