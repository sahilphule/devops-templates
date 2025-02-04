sudo yum install -y nginx

nginx
nginx -t
nginx -s reload

sudo cp nginx/default.conf /etc/nginx/conf.d/default.conf
sudo yum install -y certbot python3-certbot-nginx
sudo certbot --nginx -d dev.example.com
sudo certbot renew --dry-run

sudo pkill -f nginx & wait $!
sudo systemctl start nginx


sudo lsof -i :<port>