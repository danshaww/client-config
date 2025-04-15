default:
	just --list

# Run Full Provisioning
[no-cd]
run:
	scripts/setup-wsl.sh
	scripts/repositories.sh

# Run WSL provisioning script
[no-cd]
wsl:
	scripts/setup-wsl.sh

# Run Git provisioning script
[no-cd]
git:
	scripts/repositories.sh
