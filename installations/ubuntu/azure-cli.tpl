#!bin/sh

# Install Azure CLI
sudo apt update
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg

sudo mkdir -p /etc/apt/keyrings

curl -sLS https://packages.microsoft.com/keys/microsoft.asc \
| sudo gpg --dearmor \
| sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null

sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_REPO=$(lsb_release -cs)

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] \
https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" \
| sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt update
sudo apt install -y azure-cli

az version
