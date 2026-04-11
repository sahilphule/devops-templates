sudo yum install -y nodejs npm
sudo npm install -g pm2

sudo pm2 start build/index.js --name "sveltekit-app"
sudo pm2 status
sudo pm2 list
sudo pm2 show <name>
sudo pm2 logs <name>
sudo pm2 stop <name>
sudo pm2 stop <pid>
sudo pm2 stop all
sudo pm2 kill
sudo pm2 save
sudo pm2 startup
sudo pm2 resurrect
