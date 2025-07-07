@REM REM AutoGit
@REM 	REM AHK
@REM 		cd "C:\AHK\2nd-keyboard"
@REM 		git add --all
@REM 		git commit -m "AutoCommit %date:~10,4% %date:~4,2% %date:~7,2% %time:~0,2% %time:~3,2% %time:~6,2%
@REM 		git push
@REM 	REM Logos
@REM 		cd "E:\1. Aadi Sahni\4. Logos"
@REM 		git add --all
@REM 		git commit -m "AutoCommit %date:~10,4% %date:~4,2% %date:~7,2% %time:~0,2% %time:~3,2% %time:~6,2%
@REM 		git push
@REM 	REM AadiSahniTheme
@REM 		cd "E:\1. Aadi Sahni\2. Assets\OBS Themes\TheAadiSahniTheme"
@REM 		git add --all
@REM 		git commit -m "AutoCommit %date:~10,4% %date:~4,2% %date:~7,2% %time:~0,2% %time:~3,2% %time:~6,2%
@REM 		git push


@REM DON'T THINK GITHUB WORKS NOW, NO POINT BOTHERING 

REM AutoCopy
	REM Notepad++ Style(stylers.xml)
		cd "%appdata%\Notepad++\"
		copy stylers.xml "C:\AHK\2nd-keyboard\settings_and_shortcuts"
		cd "C:\AHK\2nd-keyboard\settings_and_shortcuts" 
		rename stylers.xml Notepad++_Styles.xml
	REM AutoExecute.bat
		cd "%userprofile%\OneDrive\Documents\"
		copy AutoExecute.bat "C:\AHK\2nd-keyboard\settings_and_shortcuts"
		
REM Logging AutoExecute ran
	cd "%userprofile\OneDrive\Documents\"
	type nul > AutoExecuteLog.txt
exit