setlocal enabledelayedexpansion
set destination=exe\RA-With-Grade-C12

echo off
echo Checking validations
dir /a /b "exe" 2>nul | findstr . >nul
if not errorlevel 1 (
    REM Folder is not empty ask user to make it empty.
    set /p "prompt=exe folder is not empty would you like to delete it's content? (Y/N) : "
    if /i "!prompt!"=="Y" (
        rmdir /s /q "exe"
        echo "exe folder is cleared proceeding"
        mkdir "exe"
    ) else (
        exit
    )
)

echo Running pyinstaller to build application
PyInstaller -y main.py --icon="software_icon_ico.ico"
echo [PYINSTALLER FINISHED]

echo Copying files to ./exe
xcopy "dist\main" "%destination%" /E /I /H /K
copy /Y "software_icon.png" "%destination%"
copy /Y "configs.json" "%destination%"
copy /Y "subject_code_refer.json" "%destination%"
echo [COPYING FINISHED]

echo Deleting junk
rmdir /s /q "dist"
rmdir /s /q "build"
del "*.spec"
echo [DELETED JUNK]

pause
echo on