# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

### Ensure vars.yml is populated manually before running this script (excluded from git)

### Ansible installation
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y

cd ..
git clone https://github.com/epichouse/ansible-roles
cd ansible-dev

if [ ! -f vars.yml ]; then
    echo "vars.yml not found. Please duplicate vars_template.yml and populate vars before running."
    exit
fi

ansible-playbook playbooks/setup.yml --ask-become-pass