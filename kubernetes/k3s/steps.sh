#!bin/sh
sudo apt update

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Setup kubeconfig
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# Install kubectx/kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx

# Install AWS CLI
sudo apt install unzip curl -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

aws configure

kubectl create secret docker-registry regcred \
  --docker-server=<your-account-id>.dkr.ecr.<your-region>.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region <your-region>) \
  --docker-email=you@example.com
