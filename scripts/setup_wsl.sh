# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

### Ensure ~/.config/client-config.yml is populated manually before running this script (excluded from git)

git pull

# Check for required vars file

if [ ! -f ~/.config/client-config.yml ]; then
    # Check for legacy vars.yml in ansible dir
    if [ -f ansible/vars.yml ]; then
        printf "\033[0;31mMigrating legacy vars to ~/.config/client-config.yml\n"
        cp ansible/vars.yml ~/.config/client-config.yml
        rm ansible/vars.yml
    # Create config if not exists
    else
        printf "\033[0;31m~/.config/client-config.yml not found. vars_template.yml has been duplicated, populate vars before running this script again\n"
        cp ansible/.vars_template.yml ~/.config/client-config.yml
        exit
    fi
fi

# Create symbolic link to client-config.yml
if [ ! -f client-config.yml ]; then
    # Check for legacy vars.yml in ansible dir
    ln ~/.config/client-config.yml client-config.yml
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
