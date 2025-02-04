# Steps to install Ansible on WSL
# Open Powershell Window
wsl --install
# Ubuntu terminal will start
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y
ansible --version

ansible-inventory --list -y

# Ensure ssh key is present in local ansible machine
# It should only have READ permissions
chmod 400 /home/user/.ssh/key-1.pem

# Ping servers
ansible -i inventory -m ping all -u <username>
ansible all -m ping

# Run playbooks
ansible-playbook -i inventory <playbook>.yml
