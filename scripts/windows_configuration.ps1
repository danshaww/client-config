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
git config --global credential.helper store
# git config --global core.autocrlf false
# git config --global core.text eol=lf
# git config --global core.eol = lf


if (-not (Test-Path "~\Git" )) {
    New-Item -Path "~\Git" -ItemType "Directory"
}

copy-Item files/powershell_profile.ps1 $PROFILE -Force

. $PROFILE