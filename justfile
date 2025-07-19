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
[no-cd]
wsl:
	scripts/setup-wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/repositories.sh

# Execute Windows Powershell script (via WSL)
windows:
	powershell.exe set-executionpolicy unrestricted -scope CurrentUser
	powershell.exe scripts/windows_configuration.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin git@gitea:dan/client-config
