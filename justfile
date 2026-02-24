default:
	just --list

# Run Full Provisioning
full:
	scripts/core.sh
	echo r | powershell.exe scripts/powershell/core.ps1
	echo r | powershell.exe scripts/powershell/extended.ps1

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
	echo r | powershell.exe scripts/powershell/core.ps1

# Run Extended Windows Provisioning script
extended:
	echo r | powershell.exe scripts/powershell/extended.ps1

# Update origin to Gitea
set-origin:
	git remote set-url origin https://gitea.epichouse.co.uk/dan/client-config
