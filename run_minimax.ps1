# run_minimax.ps1
# 读取本地密钥文件
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
if (Test-Path $secretsPath) {
    $secrets = Get-Content $secretsPath | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $secrets.minimax_api_key
}
else {
    Write-Host "错误: 找不到 secrets.json 文件！" -ForegroundColor Red
    exit
}

# 设置 MiniMax 环境
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 切换到脚本所在目录并启动
Push-Location $PSScriptRoot
claw --model "MiniMax-M2.7"
