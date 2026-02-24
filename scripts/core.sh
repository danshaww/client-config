# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

echo "Pulling changes before execution"
git pull

# Remove legacy config files
if [ -f client-config.yml ]; then
    rm client-config.yml
    echo "Removed Client Config ln"
fi
if [ -f ~/.config/client-config.yml ]; then
    rm ~/.config/client-config.yml
    echo "Removed Client Config file"
fi

### Git Configuration
if ! git config --global user.name >/dev/null; then
    read -rp "Enter your Git Name: " git_name
    git config --global user.name "$git_name"
fi
if ! git config --global user.email >/dev/null; then
    read -rp "Enter your Git Email: " git_email
    git config --global user.email "$git_email"
fi

### Ansible installation
if ! which ansible > /dev/null; then
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible -y
fi

# Execute Ansible Playbook
cd ansible
ansible-playbook playbook.yml # --ask-become-pass
cd ../

# Final Output
echo "Current Git identity:"
git config --global --get user.name
git config --global --get user.email