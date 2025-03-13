# Client Configuration Repository
  
This repository contains a scripts & Ansible playbooks used for WSL configuration & batch cloning of Git repositories.  
  
**Please execute 'scripts/setup-wsl.sh' to execute WSL Provisioning, this script ensures all dependancies are met ahead of running the Ansible playbook.**
  
**Please execute 'scripts/setup-git.sh' to execute Git provisioning, ensure appropriete GitHub organisation is specified before running.**  
  
For the Ansible playbook to succeed, you must first duplicate the vars_template.yml as vars.yml in the Ansible sub-directory, and populate the vars found in the template with the appropriete values.  
  
![Ansible](https://www.developer-tech.com/wp-content/uploads/2021/10/windows-subsystem-for-linux-wsl-microsoft.png)

