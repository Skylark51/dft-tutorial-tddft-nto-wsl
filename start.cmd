@echo off
setlocal
where wsl.exe >nul 2>nul
if errorlevel 1 (
    echo Enable Windows Subsystem for Linux, restart Windows, and run this command again.
    exit /b 1
)
wsl.exe -d Ubuntu -- true >nul 2>nul
if errorlevel 1 (
    echo Installing Ubuntu for WSL...
    wsl.exe --install -d Ubuntu
    if errorlevel 1 (
        echo Complete the WSL installation, restart Windows if requested, then run this command again.
        exit /b 1
    )
    wsl.exe -d Ubuntu -- true
    if errorlevel 1 exit /b 1
)
wsl.exe -d Ubuntu -- bash -lc "set -euo pipefail; if ! command -v curl >/dev/null; then sudo apt-get update; sudo apt-get install -y curl; fi; curl -fsSL --retry 3 https://raw.githubusercontent.com/Skylark51/dft-tutorial-tddft-nto-wsl/main/start.sh | bash"
exit /b %errorlevel%
