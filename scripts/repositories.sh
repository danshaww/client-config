#!/bin/bash

# Script to set up local repositories
git_directory=~/git
git_repos=(
    git@gitea:dan/ansible-core
    git@gitea:dan/ansible-roles
    git@gitea:dan/ansible-vault
    git@gitea:dan/ansible-dev
    git@gitea:dan/terraform-modules
    git@gitea:dan/terraform-deployment
    git@gitea:dan/client-config
    git@gitea:dan/software-licensing
    git@gitea:dan/code-snippets
    git@gitea:dan/bash-scripts
    git@gitea:dan/powershell-scripts
    git@gitea:dan/python-dev
    git@gitea:dan/docker-dev
    git@gitea:dan/homelab-mgmt
)


blue="\033[0;34m"
white="\033[0m"

# Welcome Message
printf "${blue}\nWelcome to Dan's Git Repo Cloning Utility\n\nAll repositories listed in the script will be cloned/updated\n\n${white}"

# Change into base git directory
cd $git_directory

# Clone repo's or pull if they already exist
for repourl in ${git_repos[@]}; do
(
    repo=$(basename "$repourl" .git)
    if [ -d "$repo" ]; then
        echo "Pulling changes for $repo >> $(cd "$repo" && git pull && cd $git_directory)"
    else
        git clone $repourl
    fi
    ); done

# Exit Message
printf "${blue}\nScript Complete\n\n${white}"
