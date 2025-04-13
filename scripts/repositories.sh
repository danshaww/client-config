#!/bin/bash

# Script to set up local repositories
git_directory=~/git
git_repos=(
    git@gitea:dan/ansible-core
    git@gitea:dan/ansible-roles
)

# Change into base git directory
cd $git_directory

# Clone repo's or pull if they already exist
for repourl in ${git_repos[@]}; do
(
    repo=$(basename "$repourl" .git)
    echo $repo
    if [ -d "$repo" ]; then
        cd $repo && git pull && cd ..
    else
        git clone $repourl
    fi
    ); done
