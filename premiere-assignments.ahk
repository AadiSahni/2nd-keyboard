SetWorkingDir, C:\AHK\2nd-keyboard\support_files

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Ripple delete clip at playhead!! This was the first AHK script I ever wrote, I think!
F1::
Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
sleep 1
Send ^+!d ;ctrl alt shift d  is [ripple delete]
sleep 1
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;; instant cut at cursor (UPON KEY RELEASE) -- super useful! even respects snapping!
;note to self, move this to premiere_functions already
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
F4::
;keywait, F4
;tooltip, |
send, b ;This is my Premiere shortcut for the RAZOR tool. You can use another shortcut if you like, but you have to use that shortcut here.
send, {shift down} ;makes the blade tool affect all (unlocked) tracks
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton} ;makes a CUT
send, {shift up}
sleep 10
send, v ;This is my Premiere shortcut for the SELECTION tool. again, you can use whatever shortcut you like.
return
;;the code below turned out to not be necessary.
; F4 Up::
; ;tooltip, 
; send, {lbutton}
; send, {shift up}
; sleep 10
; send, v ;selection tool
; return

;;;CLICK ON THE 'CROP' TRANSFORM BUTTON IN ORDER TO SELECT THE CROP ITSELF.
;;;THIS WAY, YOU INSTANTLY GET HANDLES ON TEH PROGRAM MONITOR, IT'S SO MUCH NICER.
cropClick()
{
;need something that wil toggle ^p if effect controls are not open.
CoordMode Pixel ;, screen
CoordMode Mouse, screen

BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor


effectControlsX = 10
effectControlsY = 200 ;the coordinates of roughly where my Effect Controls usually are located on the screen


; coordmode, pixel, Window
; coordmode, mouse, Window
; coordmode, Caret, Window

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are(were) done with default UI brightness, plus 150% UI scaling in Windows.

;ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_button_D2019.png ;

ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_2020.png
if ErrorLevel = 2
	{
	;msgbox,,, TaranDir is `n%TaranDir%,0.7
	; ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_button_D2019.png
	ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_2020.png
	}
if ErrorLevel = 1
	{
	;msgbox, we made it to try 2    
	;YOU DO NOT NEED TIPPY() ... JUST DELETE IT FROM YOUR SCRIPT.
	;IT'S A DEBUGGING THING, DON'T WORRY ABOUT IT, LOL.
	goto resetcropper
	}
if ErrorLevel = 2
	{
	goto resetcropper
	}
if ErrorLevel = 0
	{
	MouseMove, FoundX+10, FoundY+10, 0 ;this moves the cursor onto the little square thingy.
	;msgbox, is the cursor in position?
	sleep 5
	click left
	}

resetcropper:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10

;msgbox, u are in cropland
return
}
;end of CROP CLICK

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