minikube addons configure registry-creds
minikube addons enable registry-creds
kubectl get secrets -n kube-system
