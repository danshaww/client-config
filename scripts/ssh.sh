#!/bin/bash

# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

echo "Pulling changes before execution"
git pull

### Ansible installation
if ! which ansible > /dev/null; then
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible -y
fi

# Execute Ansible Playbook
cd ansible
read -s -p "Enter files web service password: " files_password
echo ""
ansible-playbook playbook.yml -e files_password=$files_password

cd ../
