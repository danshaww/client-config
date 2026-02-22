$TargetDirectory = "$env:USERPROFILE/Git"
$GiteaUrl = "https://gitea.epichouse.co.uk"
# --- Check if tea CLI exists ---
if (-not (Get-Command tea -ErrorAction SilentlyContinue)) {
    Write-Error "tea CLI is not installed or not in PATH."
    exit 1
}

# --- Ensure target directory exists ---
if (-not (Test-Path $TargetDirectory)) {
    New-Item -ItemType Directory -Path $TargetDirectory | Out-Null
}

Set-Location $TargetDirectory

# --- Check login status ---
$loginCheck = tea whoami 2>$null

if (-not $loginCheck) {
    Write-Host "Not logged in to Gitea. Starting login..." -ForegroundColor Yellow
    tea login add --name gitea --url $GiteaUrl
}

# --- Get all repos (JSON output) ---
Write-Host "Fetching repositories..." -ForegroundColor Cyan
$reposJson = tea repos ls --limit 1000 --output json
$repos = $reposJson | ConvertFrom-Json

if (-not $repos) {
    Write-Host "No repositories found."
    exit
}

# --- Clone repos ---
foreach ($repo in $repos) {
    # $cloneUrl = $repo.clone_url  # change to clone_url for HTTPS
    $repoName = $repo.name
    $repoOwner = $repo.owner
    if (Test-Path $repoName) {
        Write-Host "Pulling changes for $repoName..." -ForegroundColor DarkYellow
        cd $repoName
        git pull
        cd ../
        continue
    }
    # write-host $repo
    Write-Host "Cloning $repoName..." -ForegroundColor Green
    git clone $GiteaUrl/$repoOwner/$repoName
}

Write-Host "`nAll repositories processed." -ForegroundColor Cyan
cd client-config