default:
	just --list

# Run Full Provisioning
full:
	scripts/core.sh
	powershell scripts/powershell/core.ps1
	powershell scripts/powershell/extended.ps1

# Run WSL provisioning script
wsl:
	scripts/core.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/repos.sh

# Run Core Windows Provisioning
core:
	scripts/core.sh
	powershell scripts/powershell/core.ps1

# Run Extended Windows Provisioning script
extended:
	powershell scripts/powershell/extended.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.epichouse.co.uk/dan/client-config
