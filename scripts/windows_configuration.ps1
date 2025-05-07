# Script to make initial configuration changes to a Windows system & install software


$packages = @(
    "Microsoft.Office",
    "Obsidian.Obsidian",
    "Doist.Todoist",
    "HwMonitor"
)
# Set the execution policy to allow script execution
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted


# VS Code with context menu integration
winget install Microsoft.VisualStudioCode --accept-package-agreements --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

# Other utilities
foreach ($package in $packages) {
    Write-Output "Installing $package..."
    winget install --id $package --accept-source-agreements --accept-package-agreements
}
