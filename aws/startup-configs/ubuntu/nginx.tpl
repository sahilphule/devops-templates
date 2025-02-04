#!bin/sh
sudo apt install -y nginx
sudo cp nginx/default.conf /etc/nginx/conf.d/default.conf
sudo systemctl restart nginx
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d dev.example.com
sudo certbot renew --dry-run
