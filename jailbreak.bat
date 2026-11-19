@echo off
title Jailbreak Hermes Full
cd /d "%~dp0"
where python >nul 2>nul
if %errorlevel%==0 (
  python jailbreak_hermes.py %*
) else (
  py -3 jailbreak_hermes.py %*
)
echo.
pause
