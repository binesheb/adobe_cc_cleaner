@echo off
setlocal enabledelayedexpansion

echo Deleting Adobe files and subfolders...

set "folder=C:\"

for /r "%folder%" %%A in (*) do (
    if "%%~nxA"=="adobe" (
        echo Deleting "%%A"...
        takeown /f "%%A" >nul 2>&1
        icacls "%%A" /grant administrators:F >nul 2>&1
        del /f /q "%%A" >nul 2>&1
        echo File "%%A" deleted.
    )
)

for /d /r "%folder%" %%B in (adobe*) do (
    echo Deleting "%%B"...
    takeown /f "%%B" /r /d y >nul 2>&1
    icacls "%%B" /grant administrators:F /t >nul 2>&1
    rmdir /s /q "%%B" >nul 2>&1
    echo Folder "%%B" deleted.
)

echo Deletion complete.
pause
