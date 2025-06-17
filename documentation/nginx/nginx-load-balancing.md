# Nginx Load Balancing with AWS EC2 and Docker

## Overview

Nginx is a powerful web server capable of serving static files and functioning as a **load balancer**. Load balancing distributes incoming traffic across multiple backend servers, preventing any single server from being overwhelmed, thereby improving reliability and performance.

---

## What is Load Balancing?

Load balancing ensures that incoming requests are distributed across multiple application instances. This:
- Prevents individual instances from overloading
- Reduces latency
- Minimizes downtime due to crashes
- Improves scalability

---

## AWS EC2 Configuration

#### Launch EC2 Instances

1. Log into your AWS Console**.
2. Navigate to **EC2 > Instances** and click **Launch Instance**.
3. Choose:
   - Name for the instance
   - Amazon Linux AMI
   - Create and download a `.pem` key
   - New security group allowing `port 80` from `0.0.0.0/0`
4. Launch the instance.
5. Repeat the steps to launch a **second instance**, which will serve as an additional backend for load balancing.

---

### 1. Connect to Your First EC2 Instance

SSH into the **first EC2 instance** where Nginx will run:

```bash
chmod 400 <your-key>.pem
ssh -i <your-key>.pem ec2-user@<first-ec2-public-ip>
```

---

### 2. Install Docker, Docker Compose

```bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $(whoami)
newgrp docker

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

---

### 3. Create the Nginx Configuration File

Create and open the `default.conf` file:

```bash
vim default.conf
```

Paste the following configuration:

```nginx
log_format upstreamlog '$server_name to: $upstream_addr [$request] '
    'upstream_response_time $upstream_response_time '
    'msec $msec request_time $request_time';

upstream app {
    server apache-server-container weight=1;                         # Local container
    server <second-ec2-public-ip>:80 weight=2;                       # Second EC2 instance
}

server {
    listen 80;
    access_log /var/log/nginx/access.log upstreamlog;

    location / {
        proxy_pass http://app;
    }
}
```

> Replace `<second-ec2-public-ip>` with the **public IPv4 address of the second EC2 instance** running your application.

---

### 4. Create the Docker Compose file

Create and open the `docker-compose.yml` file:

```bash
vim docker-compose.yml
```

Paste the following configuration:

```yml
services:
  nginx:
    container_name: nginx-container
    image: nginx:latest
    ports:
      - 80:80
    networks:
      - loadbalancer

  apache-server:
    container_name: apache-server-container
    image: httpd
    ports:
      - 8080:80
    networks:
      - loadbalancer

networks:
  loadbalancer:
    driver: bridge
```

### 5. Deploy Docker Compose and Copy Nginx Config File

Copy the config inside the container:

```bash
docker-compose up -d
docker cp ./default.conf nginx-container:/etc/nginx/conf.d/default.conf
docker exec nginx-container nginx -s reload
```

---

### 6. Connect to Your Second EC2 Instance

SSH into the **second EC2 instance** by running:

```bash
chmod 400 <your-key>.pem
ssh -i <your-key>.pem ec2-user@<second-ec2-public-ip>
```

### 7. Install Docker and Deploy Nginx Container to Your Second EC2 Instance

```bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $(whoami)
newgrp docker
docker run -d --name nginx-container -p 80:80 nginx
```

---

### 8. Test Load Balancing

1. Open a browser and enter the **public IP of the first EC2 instance** (where Nginx is running).
2. Refresh the page multiple times.
3. The Apache default page says: "It works!", and Nginx default page says: "Welcome to nginx!" so alternating between responses helps verify the load balancer is switching between instances.
4. In the SSH terminal of first EC2 Instance and run:

```bash
docker logs nginx-container
```

You should see log entries routing requests to different upstream servers:

```
 to: apache-server-container [...]
 to: <second-ec2-public-ip>:80 [...]
```

---

##  Validation with Access Logs

To monitor request distribution, we configured a custom `log_format` named `upstreamlog`. The logs include:

- Targeted upstream server
- Response time
- Total request time

This helps verify traffic is balanced as expected.

---
