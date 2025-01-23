# Bash script to install Ansible, clone other required repositories and execute Ansible WSL playbook.

### Ensure vars.yml is populated manually before running this script (excluded from git)

# Vars
repo="https://github.com/epichouse/ansible-roles"

### Ansible installation
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y

# Ansible roles clone/pull step.
cd ..
if [ -d "$repo" ]; then
        cd $repo && git pull && cd ..
    else
        git clone $repourl
    fi
    ); done
cd ansible-dev

# Check for required vars file
if [ ! -f vars.yml ]; then
    echo "vars.yml not found. Please duplicate vars_template.yml and populate vars before running."
    exit
fi

# Execute Ansible Playbook
ansible-playbook playbooks/setup.yml --ask-become-pass