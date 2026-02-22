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
    "packer-dev",
    "powershell-scripts",
    "python-dev",
    "software-licensing",
    "terraform-dev"
)

cd $git_directory
foreach ($repo in $git_repos) {

    if (-not (Test-Path "$repo" )) {
        git clone https://gitea.epichouse.co.uk/dan/$repo
    }
    else {
        cd $repo
        git pull
        cd ..
    }

}
cd client-config