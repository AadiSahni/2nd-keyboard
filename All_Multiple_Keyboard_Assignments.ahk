#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#InstallKeybdhook
SendMode Input 
SetWorkingDir %A_ScriptDir%

Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something

#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Windows_Functions.ahk

^+4::SendInput {₹}
::resumee::résumé

;chrome tabs and any chromium apps(maybe)
#IfWinActive ahk_class Chrome_WidgetWin_1
	F1::send ^+{tab} ;control shift tab, which goes to the previous tab
	F2::send ^{tab} ;control tab, which goes to the next tab
	F3::send ^w ;control w, which closes a tab
	F4::send ^t ;control t, which opens a new tab
#IfWinActive

#IfWinActive ahk_exe notepad++.exe
	F1::send ^+{tab} ;control shift tab, which goes to the next tab
	F2::send ^{tab} ;control tab, which goes to the previous tab
	F3::send ^w 
	F4::F2 ;this is to regain what I lost when I used F2 and F3 for tab navigation.
#IfWinActive
	
#IfWinActive ahk_class CabinetWClass ; File Explorer
;Ctrl backspace
^Backspace::
Send ^+{Left}{Backspace}
return
;F6
F6::!d
;tilde to go up in directory mod
`::
Sendinput, {alt Down}
sleep 5
sendinput, {up} ; this is the up arrow key ; ALT+UP will go down(or "up?") one folder level in explorer
sleep 5
Sendinput, {alt Up} ;this is just the virtual ALT keystroke going up.
return
;open in new window
Mbutton::
Send {LButton}{LControl down}{Enter}
Sleep 100
Send {LControl up}
return
#IfWinActive

CapsLock & d::WinMinimize, A
CapsLock & c::winClose, A
#WheelUp::Volume_Up
#WheelDown::Volume_Down
#MButton::Media_Play_Pause
#Space::Media_Play_Pause

CapsLock & e::switchToExplorer()
CapsLock & b::switchToChrome()
CapsLock & 1::#1
CapsLock & 2::#2
CapsLock & 3::#3
CapsLock & 4::#4
CapsLock & 5::#5
CapsLock & 6::#6
CapsLock & 7::#7
CapsLock & 8::#8
CapsLock & 9::#9
CapsLock & 0::#0

CapsLock & s::f20

ScrollLock::f19
#z::
Send #b{left}{left}{enter}
return

;script reloader, but it only worKs on this one :(
#IfWinActive ahk_class Notepad++
^r::
send ^s
sleep 10
Soundbeep, 1000, 500
Reload
Return
#IfWinActive