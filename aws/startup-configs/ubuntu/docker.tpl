#!bin/sh

# Install Docker
sudo apt install -y docker.io
sudo usermod -aG docker ubuntu
newgrp docker
sudo systemctl start docker.service

# Install Docker-Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
