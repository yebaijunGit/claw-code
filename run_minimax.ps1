# run_minimax.ps1
$ErrorActionPreference = "Stop"

# Fix PATH so claw can find pwsh/powershell tools
$env:PATH += ";C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\PowerShell\7"

# 1. Variables
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 2. Config
if (Test-Path $secretsPath) {
    $json = Get-Content $secretsPath -Raw | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $json.minimax_api_key
    $target = $json.workspace_path
    Write-Host "Loaded config from secrets.json" -ForegroundColor Green
}
else {
    Write-Host "Error: secrets.json not found." -ForegroundColor Red
    Read-Host "Press enter to exit"
    exit
}

# 3. Dir
if ($target -and (Test-Path $target)) {
    cd $target
    Write-Host "Changed working directory to: $target" -ForegroundColor Cyan
}

# 4. Prompt for Session Mode
Write-Host "=============================" -ForegroundColor Yellow
Write-Host "     Select Session Mode:"     -ForegroundColor Yellow
Write-Host "1. RESUME the last session (Default)"
Write-Host "2. Start a NEW session"
Write-Host "=============================" -ForegroundColor Yellow
$choice = Read-Host "Press 1 or 2 (then Enter, default is 1)"

if ($choice -eq "2") {
    Write-Host "Starting Claw (New session)..."
    claw --model "MiniMax-M2.7"
}
else {
    Write-Host "Starting Claw (Resuming latest session)..."
    claw --model "MiniMax-M2.7" --resume latest
}

Write-Host "Process exited."
Read-Host "Press enter to close window"
