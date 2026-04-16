# run_minimax.ps1
Write-Host "[1] 脚本已启动..." -ForegroundColor Cyan

# 第一步：读取文件
$secretsPath = Join-Path $PSScriptRoot "secrets.json"
Write-Host "[2] 查找配置文件: $secretsPath"
if (!(Test-Path $secretsPath)) {
    Write-Host "错误: 找不到 secrets.json！" -ForegroundColor Red
    Read-Host "按回车退出"
    exit
}

# 第二步：转换 JSON
try {
    $content = Get-Content $secretsPath -Raw
    $secrets = $content | ConvertFrom-Json
    $env:ANTHROPIC_API_KEY = $secrets.minimax_api_key
    $targetDir = $secrets.workspace_path
    Write-Host "[3] 密钥加载成功。" -ForegroundColor Green
}
catch {
    Write-Host "错误: secrets.json 格式不对！" -ForegroundColor Red
    Write-Host $_.Exception.Message
    Read-Host "按回车退出"
    exit
}

# 第三步：设置环境
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null

# 第四步：切换目录
if ($targetDir -and (Test-Path $targetDir)) {
    Set-Location $targetDir
    Write-Host "[4] 已切换到工作目录: $targetDir"
}

# 第五步：启动程序
Write-Host "[5] 准备启动 claw..."
try {
    & "claw" --model "MiniMax-M2.7-highspeed"
}
catch {
    Write-Host "错误: 无法启动 claw 程序！" -ForegroundColor Red
    Write-Host "请确认 D:\ClaudeCode\claw.exe 是否在 PATH 中。"
    Write-Host $_.Exception.Message
}

Write-Host "`n[6] 脚本运行结束。"
Read-Host "请按回车键关闭该窗口..."
