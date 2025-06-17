# nginx commands
nginx
nginx -t
nginx -s reload

sudo nginx -T | grep "server_name"
sudo nginx -T | grep gzip
curl -H "Accept-Encoding: gzip" -I http://dev.example.com
sudo lsof -i :<port>

sudo pkill -f nginx & wait $!
sudo systemctl start nginx
sudo systemctl restart nginx

# for linux
sudo yum install -y nginx certbot python3-certbot-nginx
sudo cp nginx/default.conf /etc/nginx/conf.d/default.conf

# for ubuntu
sudo apt update
sudo apt install nginx python3-certbot-nginx -y
sudo cp nginx/default.conf /etc/nginx/sites-available/inflection-website.conf
sudo ln -sf /etc/nginx/sites-available/inflection-website.conf /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo mv /usr/share/nginx/html /usr/share/nginx/html.bak

# common
sudo nginx -t
sudo systemctl reload nginx

sudo certbot --nginx -d dev.example.com
sudo certbot renew --dry-run

# remove nginx
sudo apt-get purge nginx nginx-common -y
sudo apt-get autoremove -y
