#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#InstallKeybdhook
SendMode Input 
SetWorkingDir %A_ScriptDir%\support_files

Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something

#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Windows_Functions.ahk
; This line is here to remove syntax highlighting glitch

;;; Searching Terms
; UNIVERSALKEYS
; Premiere Keys

#IfWinNotActive ahk_class Premiere Pro
^+NumpadMult::×
^+NumpadDiv::÷
#IfWinNotActive

#IfWinActive ahk_class CabinetWClass
	; copy to path hotkey
	
	; new item hotkey
	^t::^n
	; ^n::newItemExplorer()
	^n::
	MouseMove, newItemX, newItemY
	return
#IfWinActive


#IfWinActive ahk_group ExplorerGroup ; File Explorer
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

#IfWinActive ahk_class #32770
	/::!n ; alt n is the shortcut to bring focus to the  file name input box
#IfWinActive

; ; CapsLock Assigments++++++++++++++++++++++++++++++++++++++++++++++
ScrollLock::f19 ; f19 is mute in discord because using alt makes the modifiers stuck 
#z::
Send #b{left}{left}{enter}
return

;+++++++++ SHORTCUTS THAT WORK IN ALL PROGRAMS +++++++++

;chrome tabs and any chromium apps
#IfWinActive ahk_class Chrome_WidgetWin_1  ; Since most chromium based apps (browsers and electron apps) use Chrome_WidgetWin_1 for their class(atleast the ones that I've checked), using that allows me to IfWinActive on many places at once
	!h::!home
	F1::
	send ^+{tab} ;control shift tab, which goes to the previous tab
	return
	
	F2::
	send ^{tab} ;control tab, which goes to the next tab
	return
	
	F3::
	send ^w ;control w, which closes a tab
	return
	
	F4::
	send ^t ;control t, which opens a new tab
	return
#IfWinActive

#IfWinActive ahk_exe notepad++.exe
	F1::
	send ^+{tab} ;control shift tab, which goes to the next tab
	return
	
	F2::
	send ^{tab} ;control tab, which goes to the previous tab
	return
	
	F3::
	send ^w 
	return
	
	F4::
	send ^t ;this is to regain what I lost when I used F2 and F3 for tab navigation.
	return
#IfWinActive

;;-----BEGIN KEYS PAIRED WITH CAPS LOCK--------
; UNIVERSALKEYS

; Number Keys
CapsLock & 1::switchToExplorer()
; CapsLock & 2::switchToChrome()
CapsLock & 2::switchToBrave() ; I switched to brave, it's faster
CapsLock & 3::switchToPremiere()
CapsLock & 4::switchToWhatsApp()
CapsLock & 5::switchToDiscord()
CapsLock & 6::#9
CapsLock & 7::#0
CapsLock & 8::return
CapsLock & 9::return
CapsLock & 0::return


CapsLock & Backspace::Delete

; Top Row
CapsLock & q::return
CapsLock & w::Up
CapsLock & e::return
CapsLock & r::winRestoreMaximize()
CapsLock & t::return
CapsLock & y::PgUp
CapsLock & u::Home
CapsLock & i::Up
CapsLock & o::End
CapsLock & p::return

; Home Row
CapsLock & a::Left
CapsLock & s::Down
CapsLock & d::Right
CapsLock & f::f20
CapsLock & g::return
CapsLock & h::PgDn
CapsLock & j::Left
CapsLock & k::Down
CapsLock & l::Right

; Bottom Row
CapsLock & z::return
CapsLock & x::WinMinimize, A
CapsLock & c::WinClose, A
CapsLock & v::return
CapsLock & b::Delete
CapsLock & n::return
CapsLock & m::return

; Extra keys
CapsLock & Space::Enter
;;----END OF INSTANT APP SWITCHER

;;------END OF CAPS LOCK KEYS----------


;;-----BEGIN KEYS PAIRED WITH ALT--------


!b::back()


;;------END OF ALT KEYS----------

;;-----BEGIN KEYS PAIRED WITH WINDOWS--------
#WheelUp::Volume_Up
#WheelDown::Volume_Down
#MButton::Media_Play_Pause
#Space::Media_Play_Pause
#c::#+v
#x::
send #+v
send +{Delete}
return

#f6::Volume_Mute
#f7::Volume_Down
#f8::Volume_Up
#f5::Media_Play_Pause

;;------END OF ALT KEYS----------

;;---------------- ALL STANDARD FUNCTION KEYS IN PREMIERE --------------------
;;;PREMIEREKEYS;;; <--for easy searching

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Ripple delete clip at playhead!! 
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

; F10:: IS FREE, but it was "effect controls" for awhile to debug a stuck modifiers issue.
;;NOTE that F10 will induce menu acceleration if you DON'T have it assigned to anything, so you gotta make sure to avoid that.

;F11:: is Toggle Full Screen

;F12:: is Enable Transmit. This displays a copy of the program monitor onto another, even more accurate monitor. Sadly, it does suffer from screen tearing...


;;;;;;----------------------------------------;;;;;;;;;;;;;


;============== CURRENT TOOL REMEMBERER ================

;IMPORTANT - these are MY keyboard assignments for tools
;Your own assignments will probably be different!
~v::
~t::
~r::
~y::
~b::
~x::
~h::
~p::
currentTool = %A_thishotkey% ;so, %currentTool% might become r or y or v. Whatever the last tool is that I selected.
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