# Install Cloudflare Tunnel on your host
curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/

cloudflared --version

# Temporary Tunnel
cloudflared tunnel --url http://localhost:3000

# Host token installation
sudo cloudflared service install <token>

# Authenticate Cloudflare Tunnel
cloudflared tunnel login

# Create new Cloudflare Tunnel
cloudflared tunnel create dev-example

# Find Tunnel ID
cloudflared tunnel list

# Create Cloudflare Tunnel configuration file
mkdir -p ~/.cloudflared

cp cloudflared/config.yml ~/.cloudflared/config.yml
# or
vim ~/.cloudflared/config.yml

# Validate ingress rules
cloudflared tunnel ingress validate

# Test ingress rules
# This checks a URL against every rule, from first to last, and shows the first rule that matches
cloudflared tunnel ingress rule <https://foo.example.com>

# Run the Tunnel
cloudflared tunnel run dev-example

# Update Cloudflare DNS
Go to Cloudflare Dashboard → DNS Settings
Delete any existing A/CNAME records for dev.example.com
Add a CNAME Record:
    Type: CNAME
    Name: dev.example.com
    Target: <TUNNEL_ID>.cfargotunnel.com
    Proxy Status: Proxied (Orange Cloud ☁️)



# Enable service in ec2 to start on reboot
sudo cp cloudflared/cloudflared.service /etc/systemd/system/cloudflared.service
# or
sudo vim /etc/systemd/system/cloudflared.service

sudo systemctl daemon-reload
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
sudo systemctl status cloudflared

# If needed check logs
sudo journalctl -u cloudflared -f

# Stop the prcess
pkill cloudflared
