# run_minimax.ps1
$ErrorActionPreference = "Stop"

# 1. 变量准备
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 2. 读取配置
if (Test-Path $secretsPath) {
    $json = Get-Content $secretsPath -Raw | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $json.minimax_api_key
    $target = $json.workspace_path
    Write-Host "配置已加载。"
}
else {
    Write-Host "错误: 找不到 secrets.json"
    Read-Host "按回车退出"
    exit
}

# 3. 切换目录
if ($target -and (Test-Path $target)) {
    cd $target
    Write-Host "切换到: $target"
}

# 4. 运行
Write-Host "正在启动..."
claw --model "MiniMax-M2.7-highspeed"

Write-Host "运行结束。"
Read-Host "按回车关闭窗口..."
