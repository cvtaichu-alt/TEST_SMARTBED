@echo off
REM Smart Bed RND Analysis - Windows Batch Script

echo.
echo ============================================================
echo Smart Bed Sensor Analysis - Windows Launcher
echo ============================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/
    pause
    exit /b 1
)

REM Check if requirements are installed
cd src
python -c "import pandas, numpy, scipy, matplotlib" >nul 2>&1
if errorlevel 1 (
    echo Installing required packages...
    cd ..
    pip install -r requirements.txt
    cd src
)

REM Run the main script
echo Running Smart Bed Analysis Pipeline...
echo.

python main.py

if errorlevel 1 (
    echo.
    echo Error occurred during execution!
    pause
    exit /b 1
)

echo.
echo Analysis completed successfully!
pause
