@echo off
REM This program navigates to the specified directory and archives all files/folders
REM Exception are "bin" and "obj" folders, as well as ".txt", hidden files and folders
REM Archive is created at the source location

REM Prompt User for Source Directory
set /p sourcedir="Enter the full path of the source directory to copy: "

REM Find the Name of the Last Folder in Source Directory
set fullpath=%sourcedir%
for %%F in ("%fullpath%\.") do set "foldername=%%~nxF"
if "%foldername%"=="" (
  for %%F in ("%fullpath%\..\.") do set "foldername=%%~nxF"
)

REM Set Archive Name to Last Folder Name Without .zip Extension
set archivename=%foldername%

REM Set Destination Path to Source Directory
set destpath=%sourcedir%

REM Set Destination Path to Desktop
REM set destpath=%USERPROFILE%\Desktop

REM Create a Temporary Directory for Exclusion file
set tempdir=%temp%\%random%
mkdir "%tempdir%"

REM Create a Temporary Directory for Copy
set tempdir_copy=%temp%\%random%
mkdir "%tempdir_copy%"

REM Create exclude.txt File in Temp Directory
echo /hid> "%tempdir%\exclude.txt"
echo bin>> "%tempdir%\exclude.txt"
echo obj>> "%tempdir%\exclude.txt"
echo .vs>> "%tempdir%\exclude.txt"
echo .zip>> "%tempdir%\exclude.txt"
echo Migrations>> "%tempdir%\exclude.txt"

REM Copy Files From Source Directory to Temp Directory
xcopy "%sourcedir%" "%tempdir_copy%" /EXCLUDE:%tempdir%\exclude.txt /Y /E /Q

REM If Older Archive Exists -> Delete 
if exist "%destpath%\%archivename%.zip" (
	del /F "%destpath%\%archivename%.zip"
)
REM Create zip Archive at Specified Path (Integrated Windows ZipFile)
powershell -command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('%tempdir_copy%', '%destpath%\%archivename%.zip', [System.IO.Compression.CompressionLevel]::Optimal, $false)"

REM Create zip Archive at Specified Path (7-Zip)
REM "C:\Program Files\7-Zip\7z.exe" a -tzip -mx9 -mfb258 -mpass=15 "%destpath%\%archivename%.zip" "%tempdir_copy%\*.*"

REM Delete Temporary Directory for Copy
rmdir /S /Q "%tempdir_copy%"

REM Delete exclude.txt File
del "%tempdir%\exclude.txt"

REM Delete Temporary Directory for Exclusion file
rmdir /S /Q "%tempdir%"

REM Pause to See Output
echo.
@echo Archive is created and is located at %destpath%\%archivename%.zip
pause