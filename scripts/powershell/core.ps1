# Core Windows Development Configuration Script

# Variables
$SSHKeyPublic = "https://files.epichouse.co.uk/SSH/id_rsa.pub"
$SSHKeyPrivate = "https://files.epichouse.co.uk/SSH/id_rsa"
$WindowsTerminalConfigPath = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
# $GitName  = git config --global user.name  2>$null
# $GitEmail = git config --global user.email 2>$null
$QuickAccessPinnedItems = @(
    "$env:USERPROFILE"
    # "$env:USERPROFILE\Git"
)

# Welcome Message
Write-Host "Core Windows Development Configuration" -ForegroundColor Blue

if ($env:USERNAME -eq "dan") {
    # SSH Config
    if (-not (Test-Path "$env:USERPROFILE\.ssh" )) {
        New-Item -Path "$env:USERPROFILE\.ssh" -ItemType "Directory"
    }
    copy-Item scripts/powershell/files/ssh_config $env:USERPROFILE\.ssh\config
    # Invoke-WebRequest -Uri $SSHKeyPrivate -OutFile $env:USERPROFILE\.ssh\id_rsa
    # Invoke-WebRequest -Uri $SSHKeyPublic -OutFile $env:USERPROFILE\.ssh\id_rsa.pub

    # Disable UAC
    Start-Process powershell -Verb RunAs -ArgumentList "-Command `"Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
`""

    # Package list for personal devices
    $packages = @(
        # "Git.Git",
        # "Gitea.tea",
        # "Casey.Just",
        "starship.starship",
        # "waterlan.dos2unix",
        "DEVCOM.JetBrainsMonoNerdFont",
        # "Microsoft.AzureCLI",
        "Microsoft.WindowsTerminal"
    )
}else {


    # Package list for non personal devices
    $packages = @(
        # "Git.Git",
        "starship.starship",
        "DEVCOM.JetBrainsMonoNerdFont",
        # "Microsoft.AzureCLI",
        "Microsoft.WindowsTerminal"
    )
}

# VS Code with context menu integration
winget install Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

# Other utilities
winget install $packages

#PATH Reload for System & User
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# File Explorer Configuration
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseCompactMode" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0

# Git Configuration
# git config --global credential.helper store
# git config --global core.autocrlf false
# if (-not $GitName) {
#     Write-Host "Git name not configured." -ForegroundColor Red
#     $GitName = Read-Host "Enter Git Name"
#     git config --global user.name $GitName
# }
# if (-not $GitEmail) {
#     Write-Host "Git email not configured." -ForegroundColor Red
#     $GitEmail = Read-Host "Enter Git Email"
#     git config --global user.email $GitEmail
# }

# Create Git Repository Dir
# if (-not (Test-Path "~\Git" )) {
#     New-Item -Path "~\Git" -ItemType "Directory"
# }

# Pin folders to Quick Access
$shell = New-Object -ComObject Shell.Application
$quickAccess = $shell.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}")
$currentPinned = @()
foreach ($item in $quickAccess.Items()) {
    try { $currentPinned += $item.Path } catch {}
}
foreach ($PathToPin in $QuickAccessPinnedItems) {
    if (!(Test-Path $PathToPin)) {
        Write-Warning "$PathToPin does not exist. Skipping Quick Access pinning." -ForegroundColor Red
        continue
    }
    $resolvedPath = (Resolve-Path $PathToPin).Path
    if ($currentPinned -contains $resolvedPath) {
        Write-Host "$resolvedPath already pinned to Quick Access." -ForegroundColor Blue
        continue
    }
    $parent = Split-Path $resolvedPath
    $leaf   = Split-Path $resolvedPath -Leaf
    $folder = $shell.Namespace($parent)
    $item   = $folder.ParseName($leaf)
    if ($item) {
        $item.InvokeVerb("pintohome")
        Write-Host "$resolvedPath pinned  to Quick Access successfully." -ForegroundColor Blue
    }
}

# Copy Windows Terminal Configuration
copy-Item scripts/powershell/files/windows_terminal.json $WindowsTerminalConfigPath

# Copy Powershell Profile
if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
}
copy-Item scripts/powershell/files/powershell_profile.ps1 $PROFILE -Force

# Write-Host "Git name is configured as $GitName" -ForegroundColor Blue
# Write-Host "Git email is configured as $GitEmail" -ForegroundColor Blue

# End - Re-Evaluate Powershell Profile
. $PROFILE