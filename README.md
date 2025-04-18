# Client Configuration Repository
  
This repository contains a scripts & Ansible playbooks used for WSL configuration & batch cloning of Git repositories.  
  
**Please execute 'scripts/setup-wsl.sh' to execute WSL Provisioning, this script ensures all dependancies are met ahead of running the Ansible playbook.**
  
**Please execute 'scripts/setup-git.sh' to execute Git provisioning, ensure appropriete GitHub organisation is specified before running.**  
  
For the Ansible playbook to succeed, you must first duplicate the vars_template.yml as vars.yml in the Ansible sub-directory, and populate the vars found in the template with the appropriete values.  

<img src="https://store-images.s-microsoft.com/image/apps.61786.14131597032361940.38d2a067-3798-455f-934a-f69935156b3d.eb49d3ac-e311-4e6f-b89b-f1fe8db9d73b?h=464" alt="drawing" width="100" align="left"/>