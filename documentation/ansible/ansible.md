# Ansible on WSL (Windows Subsystem for Linux)

- Ansible is an open-source automation tool that helps in configuration management, application deployment, and task automation.
- This guide will walk you through installing and using Ansible on Windows Subsystem for Linux (WSL).

---

## Prerequisites
- Windows 10 or 11 with WSL enabled
- Ubuntu (or another supported Linux distribution) installed via WSL

---

## Install Ubuntu on WSL

## Steps
1. Open **PowerShell** as Administrator and install Ubuntu on WSL:
```sh
wsl --install -d Ubuntu
```

2. It will ask you to create user & set password.
3. Ubuntu session will be started.

---

## Install Ansible

## Steps
1. Run the following commands in the Ubuntu terminal to update package lists:
```sh
sudo apt update && sudo apt upgrade -y
```

2. Install dependencies:
```sh
sudo apt install -y software-properties-common
```

3. Add Ansible’s official repository:
```sh
sudo add-apt-repository --yes --update ppa:ansible/ansible
```

4. Install Ansible:
```sh
sudo apt install -y ansible
```

5. Verify installation:
```sh
ansible --version
```

## Configure Ansible

## Steps
### Define Inventory File
1. Create an *inventory* file in your home directory:
```sh
mkdir ~/ansible && cd ~/ansible
vim inventory
```

2. Add the following content (replace with actual server IPs):
```ini
[webservers]
192.168.1.100
192.168.1.101

[dbservers]
192.168.1.200
```

### Configure SSH Access
1. Ensure your WSL instance can connect to remote hosts via SSH by copying the SSH Private Key file inside Ubuntu in **.ssh** folder.
2. Test the connection:
```sh
ansible -i inventory -m ping all
```

### Configure Nginx on the Remote Host
1. Create a nginx-playbook by running:
```sh
vim nginx-playbook.yml
```

2. Copy and Paste the following nginx playbook:
```yml
- name: Install and start nginx
  hosts: ubuntu
  become: yes
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
        upgrade: yes

    - name: Install Nginx
      apt:
        name: nginx
        state: latest

    - name: Start and enable Nginx service
      service:
        name: nginx
        state: started
        enabled: yes

    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

3. Run the Playbook:
```sh
ansible-playbook -i inventory nginx-playbook.yml
```

---

## Conclusion
- You have successfully installed and configured Ansible on WSL.
- You can now automate system configurations, deployments, and management tasks efficiently. 🚀

---