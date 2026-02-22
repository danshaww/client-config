using namespace System.Management.Automation
# SSH Autocomplete using known hosts
Register-ArgumentCompleter -CommandName ssh,scp,sftp -Native -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    $knownHosts = Get-Content ${Env:HOMEPATH}\.ssh\known_hosts `
    | ForEach-Object { ([string]$_).Split(' ')[0] } `
    | ForEach-Object { $_.Split(',') } `
    | Sort-Object -Unique

    # For now just assume it's a hostname.
    $textToComplete = $wordToComplete
    $generateCompletionText = {
        param($x)
        $x
    }
    if ($wordToComplete -match "^(?<user>[-\w/\\]+)@(?<host>[-.\w]+)$") {
        $textToComplete = $Matches["host"]
        $generateCompletionText = {
            param($hostname)
            $Matches["user"] + "@" + $hostname
        }
    }

    $knownHosts `
    | Where-Object { $_ -like "${textToComplete}*" } `
    | ForEach-Object { [CompletionResult]::new((&$generateCompletionText($_)), $_, [CompletionResultType]::ParameterValue, $_) }
}

Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)
Remove-Item Alias:gcm -Force

# Git Commit Function
function gcm {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Message
    )

    $msg = $Message -join " "
    git add .
    git commit -m "$msg"
    if ($LASTEXITCODE -ne 0) { return }
    git push
}

# Git New Branch Function
function gnb {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Branch
    )

    git switch main
    git pull
    git branch $Branch
    git switch $Branch
}

# Git Main Branch Function
function gmb {
    git switch main
    git pull
}