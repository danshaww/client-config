# Script to make initial configuration changes to a Windows system & install software


$packages = @(
    "Git.Git",
    "Gitea.tea",
    "Casey.Just",
    "waterlan.dos2unix"
)
# Set the execution policy to allow script execution
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted


# VS Code with context menu integration
winget install Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

# Other utilities
foreach ($package in $packages) {
    Write-Output "Installing $package..."
    winget install --id $package --accept-source-agreements --accept-package-agreements
}


#PATH Reload for System & User
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Git Configuration
git config --global user.name dan
git config --global user.email "danshaw509@gmail.com"
git config --global credential.helper store

if (-not (Test-Path "~\Git" )) {
    New-Item -Path "~\Git" -ItemType "Directory"
}
