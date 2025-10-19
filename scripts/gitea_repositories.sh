#!/bin/bash

# Script to set up local repositories from Gitea instance
git_directory=~/git
git_repos=$(tea repo -f url -o simple)

blue="\033[0;34m"
white="\033[0m"

# Welcome Message
printf "${blue}\nWelcome to Dan's Git Repo Cloning Utility\n\nAll repositories listed in the script will be cloned/updated\n\n${white}"

# Check for tea cli login
if command_output=$(tea login) && echo "$command_output" | grep -q "https"; then
    echo "Tea login found, proceeding."
else
    echo "No tea login found, please login using 'tea login add'"
    exit
fi

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
