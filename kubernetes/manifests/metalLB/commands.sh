minikube start --driver=docker --listen-address=0.0.0.0
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml
kubectl get pods -n metallb-system
kubectl apply -f metallb-config.yaml
