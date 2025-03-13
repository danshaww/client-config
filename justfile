default:
	just --list

# Run Full Provisioning
[no-cd]
full:
	/home/$(whoami)/git/epichouse/client-config/scripts/setup-wsl.sh && /home/$(whoami)/git/epichouse/client-config/scripts/setup-git.sh

# Run WSL provisioning script
[no-cd]
wsl:
	/home/$(whoami)/git/epichouse/client-config/scripts/setup-wsl.sh

# Run Git provisioning script
[no-cd]
git:
	/home/$(whoami)/git/epichouse/client-config/scripts/setup-git.sh
