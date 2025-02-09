# Cloudflare Tunneling (Cloudflared)

## Pre-requisites
1. Cloudflare Account
2. Domain Name
3. EC2 Instance

We will start the Cloudflare tunnel and access the Nginx page.

## Steps
1. SSH to EC2 instance.
2. Run the following commands to install & start the nginx:
  ```sh
  sudo apt update
  sudo apt install -y nginx
  sudo nginx
  ```
3. Run the following commands to install Cloudflared:
  ```sh
  curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
  chmod +x cloudflared
  sudo mv cloudflared /usr/local/bin/
  ```
4. Authenticate Cloudflare Tunnel by running:
  ```sh
  cloudflared tunnel login
  ```
> Copy & paste the browser URL and select the domain name. Thus, the certificate will be installed.
5. Run the following command to create the tunnel and list its *tunnel-id*. Note the *tunnel-id* in the notepad as we will need it in further steps.
  ```sh
  cloudflared tunnel create dev-example
  cloudflared tunnel list
  ```
6. Run the following commands to configure the tunnel:
  ```sh
  mkdir -p ~/.cloudflared
  vim ~/.cloudflared/config.yml
  ```
7. Copy the following configuration in the above-opened vim editor:
  ```yml
  tunnel: <tunnel-id>  # Replace with your tunnel ID
  credentials-file: /home/user/.cloudflared/<tunnel-id>.json
  originRequest: # Top-level configuration
    connectTimeout: 30s

  ingress:
    - hostname: dev.example.com
      service: http://localhost:80  # Change port based on your web server
  ```
> Substitute the <*tunnel-id*> with the above noted **tunnel-id** & <*dev.example.com*> with your domain name.
8. Validate the tunnel ingress rules by running the following:
  ```sh
  cloudflared tunnel ingress validate
  cloudflared tunnel ingress rule https://dev.example.com
  ```
> Replace <*dev.example.com*> with your domain name.
9. Now, run the tunnel:
  ```sh
  cloudflared tunnel run dev-example
  ```
10. Now head to Cloudflare Console and open your domain.
11. Select the **DNS** option from the sidebar
    - Add the DNS Record of *Type* **CNAME**.
    - In *Name*, provide **dev**
    - In *Target* add **<*tunnel-id*>.cfargotunnel.com**
    - Enable the *Proxy status* to **orange cloud** and save the record.
10. Now, try accessing the domain name on the browser and the nginx page will be loaded.
