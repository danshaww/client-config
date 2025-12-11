# Script to make initial configuration changes to a Windows system & install software


$packages = @(
    "Microsoft.Office",
    "Microsoft.Powertoys",
    "Microsoft.SQLServerManagementStudio.21",
    "MartiCliment.UniGetUI",
    "Oracle.MySQLWorkbench",
    "MongoDB.Compass.Community",
    "Obsidian.Obsidian",
    "Doist.Todoist",
    "CPUID.HWMonitor",
    "JanDeDobbeleer.OhMyPosh",
    "KeePassXCTeam.KeePassXC",
    "Spotify.Spotify",
    "WinSCP.WinSCP",
    "Git.Git"
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

oh-my-posh font install meslo

# Git Configuration
git config --global user.name dan
git config --global user.email "danshaw509@gmail.com"
git config --global credential.helper store
New-Item -Path "~\" -Name "Git" -ItemType "Directory"
