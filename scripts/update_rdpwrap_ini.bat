@echo off
:: RDP Wrapper Configuration Update Script
:: Purpose: Automatically update RDP Wrapper configuration file and restart services

:: Set UTF-8 encoding to ensure proper character display
chcp 65001 >nul

:: Set script title
title RDP Wrapper Update Script

:: Ensure script runs with administrative privileges
:: If not run as admin, restart with elevated permissions
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: Display start message
echo Starting RDP Wrapper configuration update...

:: Download the latest RDP Wrapper configuration file
:: Uses PowerShell to download from GitHub mirror for reliability
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/sebaxakerhtc/rdpwrap.ini/master/rdpwrap.ini' -OutFile '%temp%\rdpwrap.ini'"

:: Create a backup of the existing configuration file
:: Suppresses error output if backup fails (e.g., first-time run)
echo Creating backup of existing configuration...
copy "C:\Program Files\RDP Wrapper\rdpwrap.ini" "C:\Program Files\RDP Wrapper\rdpwrap.ini.bak" 2>nul

:: Replace the existing configuration file with the downloaded version
:: /Y switch suppresses confirmation prompt
echo Updating configuration file...
copy "%temp%\rdpwrap.ini" "C:\Program Files\RDP Wrapper\rdpwrap.ini" /Y

:: Stop Remote Desktop Services
:: /y switch automatically confirms stopping dependent services
echo Stopping Remote Desktop Services...
net stop TermService /y

:: Restart Remote Desktop Services
echo Restarting Remote Desktop Services...
net start TermService

:: Completion message
echo RDP Wrapper configuration update completed successfully!

:: Pause to view results
pause