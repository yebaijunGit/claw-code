@echo off
title MiniMax Claw Code Starter
cd /d "%~dp0"
echo [LOG] 正在请求 PowerShell 启动 AI 助手...
powershell -NoProfile -ExecutionPolicy Bypass -File "run_minimax.ps1"
echo.
echo [LOG] 程序已退出。
pause
