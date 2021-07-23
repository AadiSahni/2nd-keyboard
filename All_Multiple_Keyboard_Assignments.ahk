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
; PremiereKeys

; +++++++++++++++++++++Begin Explorer Assignments++++++++++++++++++++++++++

#IfWinActive ahk_group ExplorerGroup ; File Explorer
;Ctrl backspace
^Backspace::
Send ^+{Left}{Backspace}
return

F1::return ; f1 is help, you don't need help do you.
; actually if you know ahk, you need help
; f2 is rename, very useful
F3::^w ; close active explorer(only works if you use groupy to add tabs) f3 by default is the search box, which is meh, I don't use windows search enough for it to have a place on my function keys, i'd just use ctrl f
F4::^n ; new window. f4 is a weird address bar highlight, which you can do by alt d(or f6 is you followed my assignment) and then arrow down
; never mind, you can't bring it up by pressing down
F6::!d ; brings up address bar. by default it does something that i don't know, check it out maybe


;tilde to go up in directory mod
`::
Sendinput, {alt Down}
sleep 5
sendinput, {up} ; this is the up arrow key ; ALT+UP will go down(or "up?") one folder level in explorer
sleep 5
Sendinput, {alt Up} ;this is just the virtual ALT keystroke going up.
return


; copy to path hotkey
^+c::copyPathExplorer() 

; new item hotkey
^t::^n
^n::newItemExplorer()
return

; Open With
CapsLock & LButton::
CapsLock & Enter::
^+o::
Click left
Send, {AppsKey}
sleep 50
Send, {h}{c}
return
#IfWinActive

#IfWinActive ahk_class #32770
/::!n ; alt n is the shortcut to bring focus to the file name input box
; although i'm not sure i'd use it a lot, there are no problems with typing /, since for paths \ is used, and / can't be used in file names
#IfWinActive

#if MouseIsOver("ahk_exe GroupyCtrl.exe")
	MButton::MButton
	return
	
	
#if MouseIsOver("ahk_class CabinetWClass") ; checking to see if explorer is active rather than whether my mouse is over it can cause problems for A. closing tabs by middle clicking in groupy B. middle clicking to open another instance in taskbar
	Mbutton:: ;open in new window
	; Send {LButton}
	; Sleep 10
	; Send {LControl down}
	; Sleep 10
	; Send {Enter}
	; Sleep 10
	; Send {LControl up}
	; Sleep 10
	; return
	; the above piece of hotkeys are not necessary since it is unreilable as hell, just use context menu
	click left
	Send {AppsKey}
	sleep 0 ; context menu takes a little longer to appear than once thought. If pressing middle mouse button(scroll click) makes the windows sound or selects something that starts with e, increase the sleep
	Send {e}
	return

#IfWinActive
; ++++++++++++++++++++++++++End Explorer Assignments++++++++++++++++++++++++++++++++++++++++++


; ++++++++++++++SHORTCUTS FOR NAVIGATION, EXCEPT THE ONES THAT AREN'T HERE++++++++++++++

;chrome tabs and any chromium apps
GroupAdd, browserGroup, ahk_class Chrome_WidgetWin_1
GroupAdd, browserGroup, ahk_class MozillaWindowClass
; #IfWinActive ahk_class Chrome_WidgetWin_1  ; Since most chromium based apps (browsers and electron apps) use Chrome_WidgetWin_1 for their class(atleast the ones that I've checked), using that allows me to IfWinActive on many places at once
#IfWinActive ahk_group browserGroup ; this is just so I can add multiple browsers to the same set of assignments, very handy, i recommend to just do the same thing above but add a new ahk class for any other browser
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




;+++++++++ SHORTCUTS THAT WORK IN ALL PROGRAMS +++++++++
; UNIVERSALKEY

ScrollLock::+f19 ; shift f19 is mute in discord because using alt makes the modifiers stuck 
; i use f19 as a shortcut for different things in various apps
; ctrl f19 is used for wox, the brilliant search app
; shift f19 is used for discord as stated above
;;-----BEGIN KEYS PAIRED WITH CAPS LOCK--------

SetCapsLockState, AlwaysOff
CapsLock::f20 ; alt + capslock toggles capslock, it's weird becuase ctrl does not work and i didn't define alt + capslock to toggle capslock
; i guess i'm going to have to create a task schedule for this script for capslock state to be always off while having the rest of my capslock code still work 
; done, you'll have to create a task schedule as well if you want to use capslock or numlock always in one state to make them modifiers
; set trigger to log on of a specific user and make it your user and make action a program and make it launch the script
; future me here, I forgot to tell you check the actual admin checkbox in the general tab(run with highest privelegaseses. )
 
; Number Keys
CapsLock & `::back()
CapsLock & 1::switchToExplorer()
; CapsLock & 2::switchToChrome()
CapsLock & 2::switchToBrave() ; I switched to brave, it's faster, I would like to have firefox with chrome extensions and chrome settings/flags
; Firefox is soooooo fast though, why can't I just have it
CapsLock & 3::switchToPremiere()
CapsLock & 4::switchToWhatsApp()
CapsLock & 5::switchToDiscord()
CapsLock & 6::return
CapsLock & 7::return
CapsLock & 8::return
CapsLock & 9::return
CapsLock & 0::return


; Top Row
CapsLock & q::Home
CapsLock & w::Up
CapsLock & e::End
CapsLock & r::winRestoreMaximize()
CapsLock & t::instantExplorer("E:\AadiSahni\")
; CapsLock & y::instantExplorer("C:\Users\Sahni\Downloads") ; this is without the onedrive if you don't have onedrive
CapsLock & y::instantExplorer("C:\Users\Sahni\OneDrive\Downloads")
CapsLock & u::Home
CapsLock & i::Up
CapsLock & o::End
CapsLock & p::return

; Home Row
CapsLock & a::Left
CapsLock & s::Down
CapsLock & d::Right
CapsLock & f::^f19
CapsLock & g::instantExplorer("E:\Apps")
CapsLock & h::instantExplorer("C:\Program Files")
CapsLock & j::Left
CapsLock & k::Down
CapsLock & l::Right

; Bottom Row
CapsLock & z::instantExplorer("C:\Program Files (x86)")
CapsLock & x::WinMinimize, A
CapsLock & c::WinClose, A
CapsLock & v::superKey()
CapsLock & b::Delete
CapsLock & n::return
CapsLock & m::return

; Extra keys
CapsLock & Space::Enter
;;----END OF INSTANT APP SWITCHER

;;------END OF CAPS LOCK KEYS----------


;;-----BEGIN KEYS PAIRED WITH ALT--------






;;------END OF ALT KEYS----------

;;-----BEGIN KEYS PAIRED WITH WINDOWS--------


#c::#+v

#x::
send #+v
send +{Delete}
return

#z::
Send #b
Send {left}
sleep 10
Send {left}
sleep 10
Send {left}
sleep 10
Send {enter}
return


; OKAY I NEED A LOT OF MEDIA PLAYBACK KEYS
#WheelUp::Volume_Up
#WheelDown::Volume_Down
#MButton::Media_Play_Pause
#Space::Media_Play_Pause

#PgUp::Volume_Up
#PgDn::Volume_Down
#Up::Volume_Up
#Down::Volume_Down

#w::Volume_Up
#s::Volume_Down

#f6::Volume_Mute
#f7::Volume_Down
#f8::Volume_Up
#f5::Media_Play_Pause

;;------END OF ALT KEYS----------

#IfWinActive

;;;;--------------------- ALL KEYS IN PREMIERE ------------------------------------------
#IfWinActive ahk_exe Adobe Premiere Pro.exe

^+n::
send, ^f
send, {enter}
return
; I honestly have no idea what the above code does and why it's there but i'm keeping it in for now
; I'll comment it out after some testing

#IfWinActive


;;---------NUMPAD FOR PREMIERE------------
; I like to keep numpad off but in premiere i have some stuff programmed to the numpad which doesn't work since the numpad sends the cursor control keys
GroupAdd, NumpadGroup, ahk_exe Adobe Premiere Pro.exe
GroupAdd, NumpadGroup, ahk_exe AfterFX.exe
GroupAdd, NumpadGroup, ahk_exe Photoshop.exe

#IfWinActive ahk_group NumpadGroup
; Numpad9::NumpadIns
; I'll figure this out later
#IfWinActive


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

;; instant cut at cursor(ALL UNLOCKED LAYERS/TRACKS) (UPON KEY RELEASE) -- super useful! even respects snapping!
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
CapsLock & F4::
send, b ;This is my Premiere shortcut for the RAZOR tool. You can use another shortcut if you like, but you have to use that shortcut here.
send, {shift down} ;makes the blade tool affect all (unlocked) tracks
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton} ;makes a CUT
send, {shift up}
sleep 10
send, v ;This is my Premiere shortcut for the SELECTION tool. again, you can use whatever shortcut you like.
return


;; instant cut at cursor(UNLOCKEDLAYER/TRACK BELOW CURSOR ONLY) (UPON KEY RELEASE) -- super useful! even respects snapping!
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
F4::
send, b ;This is my Premiere shortcut for the RAZOR tool. You can use another shortcut if you like, but you have to use that shortcut here.
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton} ;makes a CUT
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

;; RIPPLE DELETE SINGLE CLIP AT CURSOR
F10::
prFocus("timeline") ;This will bring focus to the timeline. ; you can't just send ^+!3 because it'll change the sequence if you alkready have the timeline in focus. You have to go to the effect controls first. That is what this function does.
send, ^!d ;ctrl alt d is my Premiere shortcut for DESELECT. This shortcut only works if the timeline is in focus, which is why we did that on the previous line!! And you need to deselect all the timeline clips becuase otherwise, those clips will also get deleted later. I think.
send, v ;This is my Premiere shortcut for the SELECTION tool.
send, {alt down}
send, {lbutton}
send, {alt up}
send, +c ;I have C assigned to "CLEAR" in Premiere's shortcuts panel.
return

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