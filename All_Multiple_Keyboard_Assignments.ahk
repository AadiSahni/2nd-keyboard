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
	CapsLock & q::
	F1::
	send ^+{tab} ;control shift tab, which goes to the previous tab
	return
	
	CapsLock & e::
	F2::
	send ^{tab} ;control tab, which goes to the next tab
	return
	
	CapsLock & w::
	F3::
	send ^w ;control w, which closes a tab
	return
	
	CapsLock & r::
	F4::
	send ^t ;control t, which opens a new tab
	return
#IfWinActive

#IfWinActive ahk_exe notepad++.exe
	CapsLock & q::
	F1::
	send ^+{tab} ;control shift tab, which goes to the next tab
	return
	
	CapsLock & e::
	F2::
	send ^{tab} ;control tab, which goes to the previous tab
	return
	
	CapsLock & w::
	F3::
	send ^w 
	return
	
	CapsLock & r::
	F4::
	send {F2} ;this is to regain what I lost when I used F2 and F3 for tab navigation.
	return
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
	;navigation
#IfWinActive

CapsLock & d::WinMinimize, A
CapsLock & c::winClose, A
#WheelUp::Volume_Up
#WheelDown::Volume_Down
#MButton::Media_Play_Pause
#Space::Media_Play_Pause

CapsLock & 1::switchToExplorer()
CapsLock & 2::switchToChrome()
CapsLock & 3::switchToPremiere()
CapsLock & 4::switchToVivaldi()
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


;;---------------- ALL STANDARD FUNCTION KEYS IN PREMIERE --------------------
;;;PREMIEREKEYS;;; <--for easy searching

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Ripple delete clip at playhead!! This was the first AHK script I ever wrote, I think!
F1::
Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
sleep 1
Send ^+!d ;ctrl alt shift d  is [ripple delete]
sleep 1
return

;F2 is set in premiere to the [GAIN] panel.

;F3 is set in premiere to the [MODIFY CLIP] panel.

;; instant cut at cursor (UPON KEY RELEASE) -- super useful! even respects snapping!
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
F4::
send, b ;This is my Premiere shortcut for the RAZOR tool. You can use another shortcut if you like, but you have to use that shortcut here.
send, {shift down} ;makes the blade tool affect all (unlocked) tracks
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton} ;makes a CUT
send, {shift up}
sleep 10
send, v ;This is my Premiere shortcut for the SELECTION tool. again, you can use whatever shortcut you like.
return

F5::clickTransformIcon2()
F6::cropClick()

;F7:: is export frame (to .png)

;F8:: IS FREE. I had it on "selection follows playhead" but that's not useful enough.


;;DELETE SINGLE CLIP AT CURSOR
F9::
prFocus("timeline") ;This will bring focus to the timeline. ; you can't just send ^+!3 because it'll change the sequence if you alkready have the timeline in focus. You have to go to the effect controls first. That is what this function does.
send, ^!d ;ctrl alt d is my Premiere shortcut for DESELECT. This shortcut only works if the timeline is in focus, which is why we did that on the previous line!! And you need to deselect all the timeline clips becuase otherwise, those clips will also get deleted later. I think.
send, v ;This is my Premiere shortcut for the SELECTION tool.
send, {alt down}
send, {lbutton}
send, {alt up}
send, c ;I have C assigned to "CLEAR" in Premiere's shortcuts panel.
return

#IfWinActive

;script reloader, but it only worKs on this one :(
#IfWinActive ahk_class Notepad++
^r::
send ^s
sleep 10
Soundbeep, 1000, 500
Reload
Return
#IfWinActive