#!/bin/bash

org="epichouse"
git_path="/home/$(whoami)/git"
blue="\033[0;34m"
white="\033[0m"

# Welcome Message
printf "${blue}\nDan's Git Repo Cloning Utility\n\nAll active repositories of the selected organisation will be cloned/updated\nSelected organisation is $org\n\n${white}"


# Install GH CLI
if [ -d "/usr/bin/gh" ]; then
    sudo apt update && sudo apt install gh -y
fi

# Login to GitHub
if [ -d "/home/$(whoami)/.config/gh/hosts.yml" ]; then
    gh auth login
else
    gh auth status | grep "Logged in to github.com"
fi

# Create specified Git Root Path
if [ -d "$path" ]; then
    mkdir $path
fi

printf "\n"

# Clone all organisation repo's into subdirectory of Git Root Path
cd $git_path
gh repo list $org --no-archived | while read -r repo _; do
(
    if [ -d "$git_path/$repo" ]; then
        echo "Pulling changes for $repo >> $(cd "$repo" && git pull && cd $path)"
        
    else
        gh repo clone "$repo" "$repo"
    fi
); done

printf "${blue}\nScript Complete\n${white}"
