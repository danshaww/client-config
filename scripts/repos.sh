#!/bin/bash

usage() {
    printf "Usage: %s [--login LOGIN]\n" "$0"
    printf "Select a configured tea CLI login for repository search.\n"
}

tea_login=""
tea_login_args=()
while [ "$#" -gt 0 ]; do
    case "$1" in
        --login|-l)
            if [ "$#" -lt 2 ] || [ -z "$2" ]; then
                printf "Error: %s requires a login name.\n" "$1" >&2
                usage >&2
                exit 2
            fi
            tea_login="$2"
            tea_login_args=(--login "$tea_login")
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            printf "Error: unknown option: %s\n" "$1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

# Script to set up local repositories from Gitea instance
git_directory=~/git
tea_login_check_args=()
if [ -n "$tea_login" ]; then
    tea_login_check_args=("$tea_login")
fi

blue="\033[0;34m"
white="\033[0m"

# Welcome Message
printf "${blue}\nWelcome to Dan's Git Repo Cloning Utility\n\nAll repositories listed in the script will be cloned/updated\n\n${white}"

# Create specified Git Root Path
if [ -d "$path" ]; then
    mkdir $path
fi

# Check for tea cli login
if command_output=$(tea login "${tea_login_check_args[@]}") && echo "$command_output" | grep -q "https"; then
    echo "Tea login found, proceeding."
else
    echo "No tea login found, please login using 'tea login add'"
    exit 1
fi

# Fetch repositories using the selected tea login, if provided
if ! git_repos=$(tea repo search --archived=false -f url -o simple "${tea_login_args[@]}"); then
    echo "Failed to fetch repositories from the selected tea login." >&2
    exit 1
fi

# Change into base git directory
cd "$git_directory" || exit 1

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
