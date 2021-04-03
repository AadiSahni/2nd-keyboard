SetWorkingDir, C:\AHK\2nd-keyboard\support_files

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe Adobe Premiere Pro.exe





;Effects panel
#IfWinActive ahk_exe Adobe Premiere Pro.exe
F6::
Sendinput, ^!+7
Sendinput, ^!b
Sendinput, +{backspace}
return
;end of effects panel



;script reloader, but it only worKs on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
Soundbeep, 1000, 500
Reload
Return
#ifwinactive