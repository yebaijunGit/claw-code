# run_minimax.ps1
# 1. 设置 MiniMax 提供的 Anthropic 专用端点
$env:ANTHROPIC_BASE_URL = "https://api.minimaxi.com/anthropic"
# 2. 设置 API Key (使用 ANTHROPIC 变量名)
$env:ANTHROPIC_API_KEY = "sk-cp-ERj9Ba2_SDk4EJcNgPRFm8Tyxfq3V6gEhUsK-PW8IPOvSRAmzP1I6gk86sdWOhddawcWGETHvxA9pCq8yTsWTF6pllDp7lc8rCwQ3iq9k167dyM_epXGfR8"
# 3. 清理之前的 OpenAI 变量防止冲突
$env:OPENAI_API_KEY = $null
$env:OPENAI_BASE_URL = $null
# 切换到脚本所在目录，确保 .claw.json 被正确加载
Push-Location $PSScriptRoot

# 启动 claw 并指定 minimax 2.7 别名（已在 .claw.json 中配置）
claw --model m27

# 如果进程意外退出，保持窗口开启以查看错误
Write-Host "`n[Script finished/interrupted]"
Read-Host "Press Enter to close window..."
