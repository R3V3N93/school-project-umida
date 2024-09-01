@echo off
setlocal

REM Specify the folder name and the desired zip file name
set folderName=Umida
set zipFileName=Umida.zip
set renamedZipFileName=Umida.ipk3

REM Check if the folder exists
if not exist "%folderName%" (
    echo Folder "%folderName%" does not exist.
    exit /b 1
)

REM Remove existing Umida.ipk3 if it exists
if exist "%renamedZipFileName%" (
    echo Removing existing file "%renamedZipFileName%".
    del "%renamedZipFileName%"
    
    REM Check if the deletion was successful
    if exist "%renamedZipFileName%" (
        echo Failed to remove the existing file "%renamedZipFileName%".
        exit /b 1
    )
)

REM Zip the folder using PowerShell
powershell -command "Compress-Archive -Path '%folderName%\*' -DestinationPath '%zipFileName%'"

REM Check if the zip operation was successful
if errorlevel 1 (
    echo Failed to zip the folder.
    exit /b 1
)

REM Rename the zip file
rename "%zipFileName%" "%renamedZipFileName%"

REM Check if the rename operation was successful
if errorlevel 1 (
    echo Failed to rename the zip file.
    exit /b 1
)

echo Folder "%folderName%" has been successfully zipped and renamed to "%renamedZipFileName%".

C:\GZDOOM\gzdoom.exe -iwad Umida.ipk3 +logfile log.txt

endlocal
exit /b 0