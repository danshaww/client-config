set shell := ["powershell.exe", "-c"]

default:
	just --list

# Run Full Provisioning
[no-cd]
run:
	scripts/setup-wsl.sh
	scripts/repositories.sh
	powershell.exe set-executionpolicy unrestricted -scope CurrentUser
	powershell.exe scripts/windows_configuration.ps1

# Run WSL provisioning script
# [no-cd]
wsl:
	dos2unix scripts/setup_wsl.sh
	wsl scripts/setup_wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/windows_repositories.ps1
# scripts/gitea_repositories.sh

# Clone/Pull ADO Repos
[no-cd]
ado:
	scripts/devops_repositories.sh

# Execute Windows Powershell script (via WSL)
windows:
	scripts/windows_configuration.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.internal.epichouse.co.uk/dan/client-config
