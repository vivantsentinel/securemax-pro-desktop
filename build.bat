@echo off
echo 🚀 SecureMax Pro - Build Script
echo ================================

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js first.
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] npm is not installed. Please install npm first.
    pause
    exit /b 1
)

echo [INFO] Installing dependencies...
call npm install

if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

echo [SUCCESS] Dependencies installed successfully!

REM Build web version
echo [INFO] Building web version...
call npm run build

if %errorlevel% neq 0 (
    echo [ERROR] Failed to build web version
    pause
    exit /b 1
)

echo [SUCCESS] Web version built successfully!

REM Build Electron (Windows .exe)
echo [INFO] Building Windows executable (.exe)...
call npm run electron:build-win

if %errorlevel% neq 0 (
    echo [WARNING] Failed to build Windows executable
) else (
    echo [SUCCESS] Windows executable built successfully!
    echo [INFO] Location: dist-electron\SecureMax Pro Setup.exe
)

REM Build Android APK
echo [INFO] Building Android APK...
call npx cap sync android

if %errorlevel% neq 0 (
    echo [ERROR] Failed to sync Android project
    pause
    exit /b 1
)

echo [INFO] Android project synced. To build APK:
echo [INFO] 1. Open Android Studio
echo [INFO] 2. Open the 'android' folder
echo [INFO] 3. Build ^> Generate Signed Bundle/APK
echo [INFO] Or run: cd android ^&^& gradlew assembleRelease

echo [SUCCESS] Build process completed!
echo [INFO] Files generated:
echo [INFO] 📁 dist\ - Web version
echo [INFO] 📁 dist-electron\ - Windows executable
echo [INFO] 📁 android\ - Android project (build APK with Android Studio)

echo.
echo 🎉 SecureMax Pro is ready for distribution!
echo ================================
pause