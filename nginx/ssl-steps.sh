# Comment the ssl part from nginx.conf
# Run the nginx container/pod

docker exec -it nginx-container bash
kubectl exec into nginx pod

apt update
apt install -y certbot python3-certbot-nginx

# for automatic nginx context configuration
certbot --nginx -d <hostname> -m <email-address> --non-interactive --agree-tos

# for manual nginx context configuration
mkdir -p /var/www/certbot
certbot certonly --webroot -w /var/www/certbot -d <hostname> -m <email-address> --non-interactive --agree-tos

docker cp <nginx-container-name>:/etc/letsencrypt/archive/<hostname>/fullchain1.pem ./fullchain.pem
docker cp <nginx-container-name>:/etc/letsencrypt/archive/<hostname>/privkey1.pem ./privkey.pem

kubectl cp <nginx-pod-name>:/etc/letsencrypt/archive/<hostname>/fullchain1.pem ./fullchain.pem
kubectl cp <nginx-pod-name>:/etc/letsencrypt/archive/<hostname>/privkey1.pem ./privkey.pem
