#!bin/sh

# Install Nodejs & PM2
sudo yum install -y nodejs npm
sudo npm install -g pm2
sudo npm install @sveltejs/adapter-node
