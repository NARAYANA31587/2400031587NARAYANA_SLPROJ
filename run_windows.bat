@echo off
setlocal
cd /d "%~dp0"

echo ==========================================
echo       SmartAttendAI - Windows Launcher
echo ==========================================

where py >nul 2>nul
if errorlevel 1 (
    echo Python Launcher was not found.
    echo Install Python 3.11 or 3.12 from https://www.python.org/downloads/windows/
    echo During installation, enable "Add Python to PATH".
    pause
    exit /b 1
)

if not exist ".venv\Scripts\python.exe" (
    echo Creating virtual environment...
    py -3.11 -m venv .venv
    if errorlevel 1 (
        echo Python 3.11 was not found. Trying Python 3.12...
        py -3.12 -m venv .venv
    )
    if errorlevel 1 (
        echo Could not create the virtual environment.
        echo Install Python 3.11 or 3.12 and try again.
        pause
        exit /b 1
    )
)

echo Activating virtual environment...
call ".venv\Scripts\activate.bat"

echo Updating pip...
python -m pip install --upgrade pip
if errorlevel 1 goto install_error

echo Installing project requirements...
python -m pip install -r requirements.txt
if errorlevel 1 goto install_error

echo.
echo Starting SmartAttendAI...
echo Open http://127.0.0.1:5001 in your browser.
echo Press CTRL+C to stop the server.
echo.
python app.py
goto end

:install_error
echo.
echo Dependency installation failed. Check your internet connection and Python version.
pause
exit /b 1

:end
pause
endlocal
