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

function Invoke-GitPushWithRetry {
    param(
        [int]$MaxRetries = 3,
        [int]$DelaySeconds = 3
    )

    for ($attempt = 1; $attempt -le $MaxRetries; $attempt++) {
        Write-Host "Attempt $attempt of $MaxRetries..." -ForegroundColor Cyan

        git push
        $exitCode = $LASTEXITCODE

        if ($exitCode -eq 0) {
            Write-Host "Push succeeded." -ForegroundColor Green
            return
        }

        if ($attempt -lt $MaxRetries) {
            Write-Host "Push failed. Retrying in $DelaySeconds seconds..." -ForegroundColor Yellow
            Start-Sleep -Seconds $DelaySeconds
        }
        else {
            Write-Host "Push failed after $MaxRetries attempts." -ForegroundColor Red
            exit $exitCode
        }
    }
}



# Git Commit Function
Remove-Item Alias:gcm -Force -ErrorAction SilentlyContinue
function gcm {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Message
    )

    $msg = $Message -join " "
    git add .
    git commit -m "$msg"
    if ($LASTEXITCODE -ne 0) { return }
    Invoke-GitPushWithRetry -MaxRetries 5 -DelaySeconds 10
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
# Git Status
function gs {
    git status
}

# Quit Function
function q {
    exit
}

function phigh {
    powercfg.exe /setactive SCHEME_MIN
}

function pmid {
    powercfg.exe /setactive SCHEME_BALANCED
}

function plow {
    powercfg.exe /setactive SCHEME_MAX
}

function pget {
    powercfg.exe /getactivescheme
}

# General Aliases
Set-Alias -Name c -Value clear
Set-Alias -Name j -Value just
Set-Alias -Name ll -Value ls

# CD into Git if in standard terminal
function cdgit {
    $homePath = $env:USERPROFILE
    $currentPath = (Get-Location).Path
    if ($currentPath -eq $homePath) {
        $gitPath = Join-Path $homePath "git"
        Set-Location $gitPath
    }
}

# Call CD Function
cdgit

Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)
