# run_minimax.ps1
$ErrorActionPreference = "Stop"

# 1. Init
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
$env:OPENAI_BASE_URL = "https://api.minimaxi.com/v1"
$env:OPENAI_API_KEY = $null
$env:ANTHROPIC_API_KEY = $null
$env:ANTHROPIC_BASE_URL = $null

# 2. Load Config
if (Test-Path $secretsPath) {
    $json = Get-Content $secretsPath -Raw | ConvertFrom-Json
    $env:OPENAI_API_KEY = $json.minimax_api_key
    Write-Host "Config loaded."
}
else {
    Write-Host "Error: secrets.json not found."
    Read-Host "Press Enter to exit"
    exit
}

# 3. Stay in script directory
cd $PSScriptRoot

# 4. Start with a Non-Reasoning model (M2) to test speed
Write-Host "Starting Claw with MiniMax-M2 (No Thinking lag)..."
claw --model "openai/MiniMax-M2-highspeed"

Write-Host "Process finished."
Read-Host "Press Enter to close..."
