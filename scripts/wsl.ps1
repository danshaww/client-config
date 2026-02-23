# Core Windows Development Configuration Script

# Variables
$SSHKeyPublic = "https://files.epichouse.co.uk/SSH/id_rsa.pub"
$SSHKeyPrivate = "https://files.epichouse.co.uk/SSH/id_rsa"

# Welcome Message
Write-Host "Core WSL Development Configuration" -ForegroundColor Blue

# Install Ansible
wsl scripts/bash/install_ansible.sh

# Execute Ansible Playbook
Set-Location ansible
wsl ansible-playbook playbook.yml
Set-Location ../