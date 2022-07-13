@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
    cd /d "%~dp0"
    powershell.exe -ExecutionPolicy Unrestricted -Command ".\update_ini.ps1"
) else (
    echo "You need to run it as administrator!"
)
pause
