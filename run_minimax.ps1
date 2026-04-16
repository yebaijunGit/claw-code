# run_minimax.ps1
$ErrorActionPreference = "Stop"

# 1. Init
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 2. Load Config
if (Test-Path $secretsPath) {
    $json = Get-Content $secretsPath -Raw | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $json.minimax_api_key
    $target = $json.workspace_path
    Write-Host "Config loaded."
}
else {
    Write-Host "Error: secrets.json not found."
    Read-Host "Press Enter to exit"
    exit
}

# 3. Change Dir
if ($target -and (Test-Path $target)) {
    cd $target
    Write-Host "Workspace: $target"
}

# 4. Start
Write-Host "Starting Claw..."
claw --model "MiniMax-M2.7-highspeed"

Write-Host "Process finished."
Read-Host "Press Enter to close..."
