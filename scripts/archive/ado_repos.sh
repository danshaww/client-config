#!/usr/bin/env bash
# Clone all repositories from an Azure DevOps project

# Check for file containing pat token
if [ ! -f ~/.config/pat-token ]; then
    printf "\033[0;31m~/.config/pat-token not found. Populate file before running\n"
    exit
fi

# ==== CONFIGURATION ====
ORG_URL="https://dev.azure.com/epichouse-azure"
PROJECT="private"
PAT=$(cat ~/.config/pat-token)
DEST_DIR="${HOME}/git/${PROJECT}"

# ==== SCRIPT ====
mkdir -p "$DEST_DIR"
cd "$DEST_DIR" || exit 1

echo "Fetching repository list from project '$PROJECT'..."

# Get repository list from Azure DevOps REST API
response=$(curl -s -u ":$PAT" \
  "${ORG_URL}/${PROJECT}/_apis/git/repositories?api-version=7.0")

# Check for errors
if [ "$(echo "$response" | jq -r '.count')" == "null" ]; then
  echo "❌ Failed to fetch repositories. Check your PAT, organization, or project name."
  exit 1
fi

# Extract clone URLs and repo names
count=$(echo "$response" | jq -r '.count')
echo "Found $count repositories."

# Loop through repositories and clone them
echo "$response" | jq -r '.value[] | [.name, .sshUrl, .webUrl] | @tsv' | while IFS=$'\t' read -r name ssh_url web_url; do
  echo "----------------------------------------"
  echo "📦 Repository: $name 🌐 URL: $web_url"
  
  # Prefer SSH if available, otherwise use HTTPS
  clone_url=$(echo "$response" | jq -r ".value[] | select(.name==\"$name\") | .sshUrl // .remoteUrl")

  if [ -d "$name" ]; then
    cd $name
    git pull
    cd ..
  else
    echo "🔽 Cloning..."
    git clone "$clone_url" "$name"
  fi
done

echo "----------------------------------------"
echo "✅ All repositories cloned into: $DEST_DIR"
echo "----------------------------------------"
