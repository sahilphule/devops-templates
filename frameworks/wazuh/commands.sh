sudo systemctl status wazuh-agent
sudo systemctl stop wazuh-agent
sudo apt remove --purge wazuh-agent -y
sudo rm -rf /var/ossec /etc/ossec-init.conf /etc/systemd/system/wazuh-agent.service
sudo apt autoremove -y

sudo apt update
sudo apt upgrade
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent_4.12.0-1_amd64.deb && sudo WAZUH_MANAGER='<wazuh-manager-ip>' dpkg -i ./wazuh-agent_4.12.0-1_amd64.deb
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent

# Default Wazuh communication ports
# - 1514/tcp or udp -> agent-to-manager communication
# - 1515/tcp -> agent enrollment
# - 55000/tcp -> wazuh api

# Ports to allow if ufw is enabled
# Manager configuration
sudo ufw allow from <agent-ip> port 1514 proto tcp
sudo ufw allow from <agent-ip> port 1515 proto tcp
sudo ufw allow from <agent-ip> port 55000 proto tcp # Only if needed

# Agent configuration
sudo ufw allow out to <manager-ip> port 1514 proto tcp
sudo ufw allow out to <manager-ip> port 1515 proto tcp
sudo ufw allow out to <manager-ip> port 55000 proto tcp # Only if needed
