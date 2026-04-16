# run_minimax.ps1
$ErrorActionPreference = "Stop"

# 1. 变量准备
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 2. 读取配置 (从 secrets.json 获取你最新填写的 Key)
if (Test-Path $secretsPath) {
    $json = Get-Content $secretsPath -Raw | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $json.minimax_api_key
    $target = $json.workspace_path
    Write-Host "配置已加载，成功读取 secrets.json 中的 Key。" -ForegroundColor Green
}
else {
    Write-Host "错误: 找不到 secrets.json" -ForegroundColor Red
    Read-Host "按回车退出"
    exit
}

# 3. 切换目录
if ($target -and (Test-Path $target)) {
    cd $target
    Write-Host "已切换工作目录: $target" -ForegroundColor Cyan
}

# 4. 运行
Write-Host "正在启动 Claw 并连接 MiniMax..."
claw --model "MiniMax-M2.7"

Write-Host "运行结束。"
Read-Host "按回车关闭窗口..."
