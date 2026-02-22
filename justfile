set shell := ["powershell.exe", "-c"]

default:
	just --list

# Run WSL provisioning script
wsl:
	dos2unix scripts/setup_wsl.sh
	wsl scripts/setup_wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/windows_repositories.ps1

# Run Windows provisioning script (via WSL)
windows:
	scripts/windows_configuration.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.epichouse.co.uk/dan/client-config
