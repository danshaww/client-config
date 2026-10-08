#!/bin/bash

# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

echo "Pulling changes before execution"
# git pull

### Ansible installation
if ! which ansible > /dev/null; then
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible -y
fi

# Execute Ansible Playbook

cd ansible

ansible-playbook playbooks/core_config.yml -e pwd=$sudo_password --ask-become-pass

cd ../

# Final Output
echo "Current Git identity:"
git config --global --get user.name
git config --global --get user.email