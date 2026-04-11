minikube stop
minikube delete
minikube ssh
minikube image rm <image-name:tag>
minikube cp <src-path> <dest-path>
minikube mount <src-path>:<dest-path>
minikube tunnel
minikube service <service-name> -n <namespace-name>
minikube dashboard

# Configure Container Registry
minikube addons list
minikube addons configure registry-creds
minikube addons enable registry-creds
minikube addons enable ingress

# Ingress
minikube addons enable ingress
kubectl get pods -n ingress-nginx
kubectl apply -f ./ingress.yaml
kubectl get ingress

# For Windows/Powershell
minikube start --driver=docker --listen-address=0.0.0.0
minikube docker-env | Invoke-Expression
choco upgrade minikube
minikube version

# For Linux/Shell
minikube start — vm-driver=virtualbox
eval $(minikube docker-env)
