default:
	just --list

# Run Full Provisioning
[no-cd]
run:
	scripts/setup-wsl.sh
	scripts/gitea_repositories.sh
	powershell.exe set-executionpolicy unrestricted -scope CurrentUser
	powershell.exe -File scripts/windows_configuration.ps1

# Run WSL provisioning script
wsl:
	scripts/setup_wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/gitea_repositories.sh

# Run Windows provisioning script (via WSL)
windows:
	powershell.exe -File scripts/windows_configuration.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.internal.epichouse.co.uk/dan/client-config
