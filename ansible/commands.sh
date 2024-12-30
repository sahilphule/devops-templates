sudo apt update && sudo apt upgrade -y
sudo apt install ansible -y
ansible --version

ansible-inventory --list -y
ansible all -m ping