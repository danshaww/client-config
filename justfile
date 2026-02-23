set shell := ["powershell.exe", "-c"]

default:
	just --list

# Run WSL provisioning script
wsl:
	wsl scripts/bash/setup_wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/repos.ps1

# Run Core Windows provisioning script (via WSL)
core:
	scripts/core.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.epichouse.co.uk/dan/client-config
