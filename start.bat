@echo off
setlocal EnableDelayedExpansion

cd paperless
docker compose -p "paperless_%USERNAME%" up -d

echo Waiting for Paperless to start... (This might take 2-5 minutes initially.)
set attempt=1
:wait
for /f "usebackq delims=" %%J in (`docker ps --filter "name=paperless_%USERNAME%-webserver-1" --format json`) do (
    set "JSON=%%J"
	echo %JSON%
    echo %JSON% | findstr /i "healthy" >nul
    if not errorlevel 1 goto open_browser
    set /a attempt+=1
    echo Still waiting... [Attempt %attempt% of 50]
    timeout /t 5 >nul
    goto wait
)

:open_browser
echo Paperless is up and running. Opening in browser...
start http://127.0.0.1:8000
timeout /t 2 >nul
exit
