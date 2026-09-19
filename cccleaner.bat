@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if errorlevel 1 (
    echo ERROR: This cleanup helper must be run from an elevated Administrator Command Prompt.
    echo No cleanup actions were started.
    exit /b 1
)

set "cleaner=%~dp0AdobeCreativeCloudCleanerTool.exe"
if not exist "%cleaner%" (
    echo ERROR: AdobeCreativeCloudCleanerTool.exe was not found next to this script.
    echo No cleanup actions were started.
    exit /b 1
)

set "dry_run=0"
if /i "%~1"=="--dry-run" set "dry_run=1"
if !dry_run! equ 1 echo DRY RUN: no files will be changed and the Adobe cleaner will not be executed.

if !dry_run! equ 0 (
    "%cleaner%"
    if errorlevel 1 (
        echo ERROR: The Adobe Creative Cloud Cleaner Tool could not be started successfully.
        echo No additional cleanup actions were started.
        exit /b 1
    )
)

set /a failures=0

echo Scanning C:\ for Adobe files and folders...

set "folder=C:\"

for /r "%folder%" %%A in (*) do (
    if "%%~nxA"=="adobe" (
        echo [TARGET] File "%%A"
        if !dry_run! equ 0 (
            takeown /f "%%A" >nul 2>&1
            icacls "%%A" /grant administrators:F >nul 2>&1
            del /f /q "%%A" >nul 2>&1
            if errorlevel 1 (
                echo ERROR: Failed to delete file "%%A".
                set /a failures+=1
            ) else (
                echo File "%%A" deleted.
            )
        )
    )
)

for /d /r "%folder%" %%B in (adobe*) do (
    echo [TARGET] Folder "%%B"
    if !dry_run! equ 0 (
        takeown /f "%%B" /r /d y >nul 2>&1
        icacls "%%B" /grant administrators:F /t >nul 2>&1
        rmdir /s /q "%%B" >nul 2>&1
        if errorlevel 1 (
            echo ERROR: Failed to delete folder "%%B".
            set /a failures+=1
        ) else (
            echo Folder "%%B" deleted.
        )
    )
)

if !dry_run! equ 1 (
    echo DRY RUN complete. No files were changed and the Adobe cleaner was not executed.
    pause
    exit /b 0
)

if !failures! gtr 0 (
    echo WARNING: Cleanup completed with !failures! deletion failure^(s^).
) else (
    echo Deletion complete. All requested deletions succeeded.
)

"%cleaner%" --removeAll=ALL
set "cleaner_exit=!errorlevel!"
if not "!cleaner_exit!"=="0" (
    echo ERROR: Adobe Creative Cloud Cleaner Tool reported exit code !cleaner_exit!.
)

if !failures! gtr 0 exit /b 1
if not "!cleaner_exit!"=="0" exit /b !cleaner_exit!

pause
exit /b 0
