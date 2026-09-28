@echo off
npm install
npx cap sync android
cd android
gradlew.bat assembleDebug
echo.
echo APK: android\app\build\outputs\apk\debug\app-debug.apk
pause
