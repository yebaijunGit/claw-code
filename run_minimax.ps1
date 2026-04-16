# run_minimax.ps1
# 读取本地密钥和配置
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
if (Test-Path $secretsPath) {
    $secrets = Get-Content $secretsPath | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $secrets.minimax_api_key
    $targetDir = $secrets.workspace_path
}
else {
    Write-Host "错误: 找不到 secrets.json 文件！" -ForegroundColor Red
    exit
}

# 设置 MiniMax 环境
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 切换到指定的工作目录
if ($targetDir -and (Test-Path $targetDir)) {
    Write-Host "正在切换到工作目录: $targetDir" -ForegroundColor Cyan
    Set-Location $targetDir
}
else {
    Write-Host "正在当前目录启动: $PSScriptRoot" -ForegroundColor Cyan
    Set-Location $PSScriptRoot
}

# 启动 claw 并指定模型
claw --model "MiniMax-M2.7"

# 如果进程意外退出，保持窗口开启以查看错误
Write-Host "`n[进程已结束]"
Read-Host "按回车键关闭窗口..."
