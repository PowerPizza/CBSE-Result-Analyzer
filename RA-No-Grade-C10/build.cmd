set destination=exe\RA-No-Grade-C10

echo off
echo Checking validations
dir /a /b "exe" >nul 2>&1
if errorlevel 1 (
    set /p prompt=`exe` folder is not empty would you like to delete it's content?
    if /i "%prompt%"=="y" (
        rmdir /s /q "exe"
        echo "exe folder is cleared proceeding"
    )
    else (
        exit
    )
)

echo Running pyinstaller to build application
PyInstaller -y main.py --icon="software_icon_coloured_ico.ico"
echo [PYINSTALLER FINISHED]

echo Copying files to ./exe
xcopy "dist\main" "%destination%" /E /I /H /K
copy /Y "software_icon_coloured.png" "%destination%\software_icon.png"
copy /Y "configs.json" "%destination%"
copy /Y "subject_code_refer.json" "%destination%"
echo [COPYING FINISHED]

pause
echo on