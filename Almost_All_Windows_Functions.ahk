#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

GroupAdd, ExplorerGroup, ahk_class #32770 ;This is for all the Explorer-based "save" and "load" boxes, from any program!












; INSTANT APPLICATION SWITCHER+++++++++++++++++++++++++
switchToExplorer(){
sleep 11 ;this is to avoid the stuck modifiers bug
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	WinMinimize
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

switchToChrome()
{
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe

if WinActive("ahk_exe chrome.exe")
	WinMinimize
else
	WinActivate ahk_exe chrome.exe
	
sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}

switchToPremiere(){
IfWinNotExist, ahk_class Premiere Pro
	{
	;Run, Adobe Premiere Pro.exe
	;Adobe Premiere Pro CC 2017
	; Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2017\Adobe Premiere Pro.exe ;if you have more than one version instlaled, you'll have to specify exactly which one you want to open.
	Run, Adobe Premiere Pro.exe
	}

if WinActive("ahk_class Premiere Pro")
	{
	IfWinNotExist, ahk_exe notepad++.exe
		{
		Run, notepad++.exe
		sleep 200
		}
	WinActivate ahk_exe notepad++.exe ;so I have this here as a workaround to a bug. Sometimes Premeire becomes unresponsive to keyboard input. (especially after timeline scrolling, especially with a playing video.) Switching to any other application and back will solve this problem. So I just hit the premiere button again, in those cases.g
	sleep 10
	WinActivate ahk_class Premiere Pro
	}
else
	WinActivate ahk_class Premiere Pro
}

switchToVivaldi()
{
IfWinNotExist, ahk_exe vivaldi.exe
	Run, vivaldi.exe

if WinActive("ahk_exe vivaldi.exe")
	WinMinimize
else
	WinActivate ahk_exe vivaldi.exe
	
sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}








