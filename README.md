# ZipForJudge

### Creates an archive file of your CSharp project with ".zip" file extension

#### 
By default the script is set to use Windows' built-in tools and it will create the archive in the same directory as the project.  
If an archive with the same name already exists in the folder, it will be overwritten.

### How to use
All you need to do is run the ".bat" file and once asked paste the path of the project in the command pannel.  
You should give the main path that you wish to archive, for example:

![path example](https://cdn.discordapp.com/attachments/659853809165533186/1082233713724760154/image.png)

Once you have done that paste it in the cmd window, like this:

![paste example](https://cdn.discordapp.com/attachments/659853809165533186/1082234104197693500/image.png)

Press `Enter` and wait for the script to execute! Once its done you can close the cmd window.

### Available Settings
- If you wish to change the archive path from `Project Directory` to your `Desktop`, you can comment out line 20 and uncomment line 23, just like this:
```bat
REM Set Destination Path to Source Directory
REM set destpath=%sourcedir%

REM Set Destination Path to Desktop
set destpath=%USERPROFILE%\Desktop
```
- If you wish to use `7-Zip` instead of the `built-in Windows archiving tool`, you need to comment out line 49 and uncomment line 52, just like this:
```bat
REM Create zip Archive at Specified Path (Integrated Windows ZipFile)
REM powershell -command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('%tempdir_copy%', '%destpath%\%archivename%.zip', [System.IO.Compression.CompressionLevel]::Optimal, $false)"

REM Create zip Archive at Specified Path (7-Zip)
"C:\Program Files\7-Zip\7z.exe" a -tzip -mx9 -mfb258 -mpass=15 "%destpath%\%archivename%.zip" "%tempdir_copy%\*.*"
```
### OBS! 
Make sure you have installed `7-Zip` in the default directory, otherwise you need to change the first string argument of the command as well, the string should point to the `7-Zip` installation path!

### Credits
Credit to Mokgul for this script idea!  
[![GitHub](https://img.shields.io/badge/-mokgul-000000?style=flat-square&logo=Github&logoColor=white)](https://github.com/mokgul) 
