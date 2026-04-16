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
    Set-Location $target
    Write-Host "Changed working directory to: $target" -ForegroundColor Cyan
}

# 4. Tip
Write-Host ""
Write-Host "Tip: Type /resume latest to load your last session." -ForegroundColor DarkGray
Write-Host ""

# 5. Start (interactive mode - no --resume flag)
claw --model "MiniMax-M2.7"

Write-Host "Process exited."
Read-Host "Press enter to close window"
