cd paperless
docker compose up -d

echo Waiting for the service to become healthy...
:wait
for /f "tokens=1,2" %%a in ('docker compose ps --format json') do (
    echo %%b | findstr /i "healthy" >nul
    if not errorlevel 1 goto open_browser
    echo Service not healthy yet, waiting...
    timeout /t 5 >nul
    goto wait
)

:open_browser
start http://127.0.0.1:8000