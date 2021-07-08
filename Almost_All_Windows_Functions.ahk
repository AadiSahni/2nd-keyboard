﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

GroupAdd, ExplorerGroup, ahk_class #32770 ;This is for all the Explorer-based "save" and "load" boxes, from any program!
GroupAdd, ExplorerGroup, ahk_class CabinetWClass ;Regular Explorer window 

; MouseIsOver
; MouseIsOver is a simple function that allows me to do an action using #If when the mouse is over a certain window
MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}



; INSTANT APPLICATION SWITCHER+++++++++++++++++++++++++
switchToExplorer(){
sleep 11 ;this is to avoid the stuck modifiers bug
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

switchToChrome()
{
IfWinNotExist, ahk_exe chrome.exe
	Run, C:\Program Files\Google\Chrome\Application\chrome.exe

if WinActive("ahk_exe chrome.exe")
	WinActivateBottom ahk_exe chrome.exe
else
	WinActivate ahk_exe chrome.exe

sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}

switchToBrave()
{
IfWinNotExist, ahk_exe brave.exe
	Run, C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe

if WinActive("ahk_exe brave.exe")
	WinActivateBottom ahk_exe brave.exe
else
	WinActivate ahk_exe brave.exe

sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}

switchToPremiere(){
IfWinNotExist, ahk_class Premiere Pro
	{
	; Run, Adobe Premiere Pro.exe
	tooltip, Premiere isn't running!!!!
	tooltip
	return
	}
if WinActive("ahk_class Premiere Pro")
	{
	WinActivate ahk_class Premiere Pro
	}
else
	WinActivate ahk_class Premiere Pro
}

switchToWhatsApp()
{
IfWinNotExist, ahk_exe WhatsApp.exe
	Run, C:\Users\Sahni\AppData\Local\WhatsApp\WhatsApp.exe

if WinActive("ahk_exe WhatsApp.exe")
	WinMinimize
else
	WinActivate ahk_exe WhatsApp.exe

sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}


switchToDiscord()
{
IfWinNotExist, ahk_exe Discord.exe
	Run, "C:\Users\Sahni\AppData\Local\Discord\Update.exe" --processStart Discord.exe 

if WinActive("ahk_exe Discord.exe")
	WinMinimize
else
	WinActivate ahk_exe Discord.exe
}


back()
{

;tooltip, back
;sendinput, {ctrl up}
If GetKeystate(Lctrl, "P")
        Send {Lctrl Up}
If GetKeystate(Rctrl, "P")
        Send {Rctrl Up}

if WinActive("ahk_exe firefox.exe")
	Send !{Left}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send !{Left}
if WinActive("ahk_class Notepad++")
	Send ^+{tab}
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	Send ^!+b ;ctrl alt shift B  is my shortcut in premiere for "go back"(in bins)(the project panel)
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
if WinActive("ahk_class OpusApp")
	sendinput, {F2} ;"go to previous comment" in Word.
}

winRestoreMaximize() {
	WinGetActiveTitle, title
	WinGet, maximized, MinMax, %title%
	if (maximized)
		WinRestore, %title%
	else
		WinMaximize, %title%
	return
}

newItemX = 545
newItemY = 65 ; used for newItemExplorer(), these are the coordinated of where the new item button is roughly on my screen

newItemExplorer() {
	; newItemExplorer clicks the new item menu so you can select a format
	; for me weird usages, I just have it set to select a text file and the ctrl a so I can type the file exntension my self
	; for this to work you must always have the ribbon menu pinned, although use the next line to use this without pinnin the ribbon
	; send, !h 
	MouseGetPos, xpos, ypos
	ImageSearch, FoundX, FoundY, newItemX, newItemY, newItemX+1, newItemY+1, \support_files\NEW_ITEM_Home.png
}


#IfWinActive