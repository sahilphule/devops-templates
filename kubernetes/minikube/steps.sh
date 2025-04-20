#!bin/sh
sudo apt update

# Install Docker
sudo apt install -y docker.io
sudo usermod -a -G docker ubuntu
newgrp docker
sudo systemctl start docker.service

# Install Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube addons configure registry-creds
minikube addons enable registry-creds
kubectl get secrets -n kube-system

minikube addons enable ingress
kubectl get pods -n ingress-nginx
kubectl apply -f ./ingress.yaml
kubectl get ingress
