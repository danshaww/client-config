# Extended Windows Configuration Script

# Welcome Message
Write-Host "Extended Windows Configuration" -ForegroundColor Blue

if ($env:USERNAME -eq "dan") {
    $packages = @(
        "Microsoft.Azure.DataStudio",
        "Microsoft.SQLServerManagementStudio.22",
        "Microsoft.Powertoys",
        "Obsidian.Obsidian",
        "Doist.Todoist",
        "WinSCP.WinSCP",
        "KeePassXCTeam.KeePassXC",
        "Bitwarden.Bitwarden",
        "CrystalDewWorld.CrystalDiskMark",
        "CrystalDewWorld.CrystalDiskInfo",
        "Oracle.MySQLWorkbench",
        "Rufus.Rufus",
        "7zip.7zip",
        "CPUID.HWMonitor"
    )
}else {
    $packages = @(
        "Microsoft.Azure.DataStudio",
        "Microsoft.SQLServerManagementStudio.22",
        "Obsidian.Obsidian",
        "KeePassXCTeam.KeePassXC"
    )
}

# Install utilities
winget install $packages