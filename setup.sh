# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

### Ensure vars.yml is populated manually before running this script (excluded from git)

# Vars
repourl="https://github.com/epichouse/ansible-roles"
repo=$(basename "$repourl" .git)

### Ansible installation
if ! which ansible > /dev/null; then
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible -y
fi

# Ansible roles clone/pull step.
cd ..
if [ -d "$repo" ]; then
    cd $repo && git pull && cd ..
else
    git clone $repourl
fi
cd ansible-setup

# Check for required vars file
if [ ! -f vars.yml ]; then
    echo "vars.yml not found. Please duplicate vars_template.yml and populate vars before running."
    exit
fi

# Execute Ansible Playbook
ansible-playbook playbooks/setup.yml --ask-become-pass