#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
#installkeybdhook

Menu, Tray, Icon, shell32.dll, 35

;win-options
#d::WinMinimize, A
#c::winClose, A
;end of win-options

;symbols
^+4::SendInput {₹}
;end of symbols

;résumé
::resumee::résumé
;end of résumé

;chrome tabs and any chromium app(maybe)
#IfWinActive ahk_class Chrome_WidgetWin_1
F1::send ^+{tab} ;control shift tab, which goes to the previous tab
F2::send ^{tab} ;control tab, which goes to the next tab
F3::send ^w ;control w, which closes a tab
F4::send ^t ;control t, which opens a new tab
#IfWinActive
;end chrome tabs
;notepad++ mods
;notepad++ tab thingy
#IfWinActive ahk_exe notepad++.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 
F4::F2 ;this is to regain what I lost when I used F2 and F3 for tab navigation.
;end of notepad++
;end of notepad++ mods

;explorer mods
#IfWinActive ahk_class CabinetWClass ; File Explorer
    ;explorer for some reason pastes a weird box character when you ctrl backspace(which is supposed to delete the entire word) so this mod just enables it
	^Backspace::
    Send ^+{Left}{Backspace}
	return
	;end of weird control backspace explorer thingy
	;F6 in chrome highlights the adress bar but in explorer ctrl + l and f4 highlight it so just a little mod
	F6::^l
	;f6 end
	;tilde to go up in directory mod
	`::
	Sendinput, {alt Down}
	sleep 5
	sendinput, {up} ; this is the up arrow key ; ALT+UP will go down(or "up?") one folder level in explorer
	sleep 5
	Sendinput, {alt Up} ;this is just the virtual ALT keystroke going up.
	return
	;end of tilde
	
#IfWinActive ;this is just to make it so that anything after this does not work just in explorer
;keymapping

SetNumLockState,On
SetNumLockState,AlwaysOn
SetScrollLockState, AlwaysOff
return

AppsKey::
SendInput, {ctrl down}
SendInput, {alt down}
SendInput, {shift down}
SendInput, {1}
SendInput, {ctrl up}
SendInput, {alt up}
SendInput, {shift up}
return

Pause::
SendInput, {ctrl down}
SendInput, {alt down}
SendInput, {shift down}
SendInput, {2}
SendInput, {ctrl up}
SendInput, {alt up}
SendInput, {shift up}
return

NumLock::
SendInput, {ctrl down}
SendInput, {alt down}
SendInput, {shift down}
SendInput, {3}
SendInput, {ctrl up}
SendInput, {alt up}
SendInput, {shift up}
return

ScrollLock::
SendInput, {ctrl down}
SendInput, {alt down}
SendInput, {shift down}
SendInput, {4}
SendInput, {ctrl up}
SendInput, {alt up}
SendInput, {shift up}
return

CapsLock::
SendInput, {F21}  
return

+CapsLock::
SendInput, {Enter}
;end of keymapping

;script reloader, but it only worKs on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
Soundbeep, 1000, 500
Reload
Return