#!bin/sh

# Install Docker
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo newgrp docker
sudo systemctl start docker.service

# Install Docker-Compose
sudo yum update
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
