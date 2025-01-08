nginx
nginx -t
nginx -s reload

sudo cp nginx/default.conf /etc/nginx/conf.d/default.conf
sudo yum install -y certbot python3-certbot-nginx
sudo certbot --nginx -d dev.example.com
sudo certbot renew --dry-run
