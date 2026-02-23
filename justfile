set shell := ["powershell.exe", "-c"]

default:
	just --list

# Run Full Provisioning
full:
	scripts/core.ps1
	scripts/extended.ps1
	wsl scripts/bash/setup_wsl.sh

# Run WSL provisioning script
wsl:
	wsl scripts/bash/setup_wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/repos.ps1

# Run Core Windows Provisioning
core:
	scripts/core.ps1

# Run Extended Windows Provisioning script
extended:
	scripts/extended.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.epichouse.co.uk/dan/client-config
