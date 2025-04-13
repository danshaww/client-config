default:
	just --list

# Run Full Provisioning
[no-cd]
run:
	/home/$(whoami)/git/client-config/scripts/setup-wsl.sh && /home/$(whoami)/git/client-config/scripts/repositories.sh

# Run WSL provisioning script
[no-cd]
wsl:
	/home/$(whoami)/git/client-config/scripts/setup-wsl.sh

# Run Git provisioning script
[no-cd]
git:
	/home/$(whoami)/git/client-config/scripts/repositories.sh
