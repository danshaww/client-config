# Script to clone Gitea repositories

# this is to be expanded to automatically get all repos at a later date

$git_directory="~/git"
$git_repos= @(
    "ansible-core",
    "ansible-dev",
    "ansible-roles",
    "ansible-vault",
    "bash-scripts",
    "client-config",
    "code-snippets",
    "docker-dev",
    "documentation",
    "homelab",
    "homelab-dns",
    "homelab-docker",
    "homelab-general",
    "homelab-global",
    "homelab-mgmt",
    "homelab-monitoring",
    "packer-dev",
    "powershell-scripts",
    "python-dev",
    "software-licensing",
    "terraform-dev",
    "terraform-modules",
    "web"
)

cd $git_directory
foreach ($repo in $git_repos) {

    if (-not (Test-Path "$repo" )) {
        git clone https://gitea.internal.epichouse.co.uk/dan/$repo
    }
    else {
        cd $repo
        git pull
        cd ..
    }

}
cd client-config