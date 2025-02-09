sudo yum install -y nginx
sudo yum install -y certbot python3-certbot-nginx

nginx
nginx -t
nginx -s reload

sudo certbot --nginx -d dev.example.com
sudo certbot renew --dry-run

sudo cp nginx/default.conf /etc/nginx/conf.d/default.conf

sudo cp nginx/default.conf /etc/nginx/sites-available/inflection-website.conf
sudo ln -s /etc/nginx/sites-available/inflection-website.conf /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo mv /usr/share/nginx/html /usr/share/nginx/html.bak
sudo nginx -t
sudo systemctl restart nginx

sudo nginx -T | grep "server_name"
sudo nginx -T | grep gzip
curl -H "Accept-Encoding: gzip" -I http://dev.codecoords.com
sudo lsof -i :<port>

sudo pkill -f nginx & wait $!
sudo systemctl start nginx

sudo apt-get purge nginx nginx-common -y
sudo apt-get autoremove -y
