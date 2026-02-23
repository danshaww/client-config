# Core Windows Development Configuration Script

# Variables
$WindowsTerminalConfigPath = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Welcome Message
Write-Host "Core Windows Development Configuration" -ForegroundColor Blue

if ($env:USERNAME -eq "dan") {
    git config --global user.name "Dan"
    git config --global user.email "danshaw509@gmail.com"
    $packages = @(
        "Git.Git",
        "Gitea.tea",
        "Casey.Just",
        "starship.starship",
        "waterlan.dos2unix",
        "DEVCOM.JetBrainsMonoNerdFont",
        "Microsoft.AzureCLI",
        "Microsoft.WindowsTerminal"
    )
}else {
    $packages = @(
        "Git.Git",
        "starship.starship",
        "DEVCOM.JetBrainsMonoNerdFont",
        "Microsoft.AzureCLI",
        "Microsoft.WindowsTerminal"
    )
}

# VS Code with context menu integration
winget install Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

# Other utilities
winget install $packages

#PATH Reload for System & User
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Git Configuration
git config --global credential.helper store
git config --global core.autocrlf false

# Create Git Repository Dir
if (-not (Test-Path "~\Git" )) {
    New-Item -Path "~\Git" -ItemType "Directory"
}

# Copy Windows Terminal Configuration
copy-Item scripts/files/windows_terminal.json $WindowsTerminalConfigPath

# Copy Powershell Profile
copy-Item scripts/files/powershell_profile.ps1 $PROFILE -Force

# End - Re-Evaluate Powershell Profile
. $PROFILE