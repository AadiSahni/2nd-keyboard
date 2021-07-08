#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%\support_files  ; Ensures a consistent starting directory.
 


#IfWinActive ahk_exe Adobe Premiere Pro.exe
	

prFocus(panel)
{
;READ ALL THE COMMENTS BELOW OR SUFFER THE CONSEQUENCES.

;PrFocus() allows you to have ONE place where you define your personal shortcuts to "focus" panels in Premiere. It also ensures that panels actually get into focus, and don't rotate through the sequences or anything like that.

; THERE IS A FULL VIDEO TUTORIAL THAT TEACHES YOU HOW TO USE THIS, STEP BY STEP.
; [[[[[LINK TBD, IT'S NOT FINISHED JUST YET.]]]]]

;For this function to work, you MUST Go to Premiere's Keyboard Shortcuts panel, and add the following keyboard shortcuts to the following commands:

; KEYBOARD SHORTCUT     PREMIERE COMMAND
; ctrl alt shift 3 .....Application > Window > Timeline (The default is shift 3)
; ctrl alt shift 1 .....Application > Window > Project  (Sets the focus onto a BIN.) (the default is SHIFT 1)
; ctrl alt shift 4 .....Application > Window > Program Monitor (Default is SHIFT 4)
; ctrl alt shift 5 .....Application > Window > Effect Controls (Default is SHIFT 5)
; ctrl alt shift 7 .....Application > Window > Effects  (NOT the Effect Controls panel!) (Default is SHIFT 7)

;(Note that ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk has the FULL list of keyboard shortcuts that you need to assign in order for my other functions to work.)


;EXPLANATION: In Premiere, panel focus is very important. Many shortucts will only work if a specific panel is in focus. That is why those panels must be put into focus FIRST, which is what I built PrFocus() to do. (It's not always as simple as sending just the one keyboard shortcut to activate that panel.)

;Right now, we do NOT know which panel is in focus, (or "active.") and AHK has no way to tell (that I know of.)
;If a panel is ALREADY in focus, and you send the shortcut to bring it into focus again, that panel might then switch to a different sequence in the case of the timeline or program monitor,, or a different item in the case of the Source panel. IT's a nightmare!

;Therefore, we must start with a clean slate. For that, I chose the EFFECTS panel. Sending its focus shortcut multiple times, has no ill effects.

Sendinput, ^!+7 ;bring focus to the effects panel... OR, if any panel had been maximized (using the `~ key by default) this will unmaximize that panel, but sadly, that panel will still be the one in focus.
;Note that if the effects panel is ALREADY maximized, then sending the shortcut to switch to it will NOT un-maximize it. This is OK, though, because I never maximize the Effects Panel. If you do, then you might want to switch to the Effect Controls panel first, and THEN the Effects panel after this line.
;note that sometimes I use ^+! instead... it makes no difference compared to ^!+

sleep 12 ;waiting for Premiere to actaully do the above.

Sendinput, ^!+7 ;Bring focus to the effects panel AGAIN. Just in case some panel somewhere was maximized, THIS will now guarantee that the Effects panel is ACTAULLY in focus.

sleep 5 ;waiting for Premiere to actaully do the above.

sendinput, {blind}{SC0EA} ;scan code of an unassigned key. Used for debugging. You do not need this.

if (panel = "effects")
	goto theEnd ;do nothing. The shortcut has already been sent.
else if (panel = "timeline")
	Sendinput, ^!+3 ;if focus had already been on the timeline, this would have switched to the "next" sequence (in some unpredictable order.)
else if (panel = "program") ;program monitor. If focus had already been here, this would have switched to the "next" sequence.
	Sendinput, ^!+4
else if (panel = "source") ;source monitor. If focus had already been here, this would have switched to the next loaded item.
{
	Sendinput, ^!+2
	;tippy("send ^!+2") ;tippy() was something I used for debugging. you don't need it.
}
else if (panel = "project") ;AKA a "bin" or "folder"
	Sendinput, ^!+1
else if (panel = "effect controls")
	Sendinput, ^!+5

theEnd:
sendinput, {blind}{SC0EB} ;more debugging - you don't need this.
}
;end of prFocus()


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

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are(were) done with default UI brightness, plus 100% UI scaling in Windows.

;ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_button_D2019.png ;

ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_2020.png
if ErrorLevel = 2
	{
	; msgbox,,, TaranDir is `n%TaranDir%,0.7
	; ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_button_D2019.png
	ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_WorkingDir%\CROP_transform_2020
	}
if ErrorLevel = 1
	{
	; msgbox, we made it to try
	goto resetcropper
	}
if ErrorLevel = 2
	{
	goto resetcropper
	}
if ErrorLevel = 0
	{
	MouseMove, FoundX+10, FoundY+10, 0 ;this moves the cursor onto the little square thingy.
	; msgbox, is the cursor in position?
	sleep 5
	click left
	}

resetcropper:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10

; msgbox, u are in cropland
return
}
;end of CROP CLICK

clickTransformIcon2()
{

;This function actually does everything that "Activate Direct Manipulation in Program Monitor" SHOULD do.


;result := untwirl()
;it will return either "reset" or "untwirled"
;either way, I think I'll ignore the output, lel.

;msgbox,,, %result%,0.7

; ; ;the code below serves to save a lot of time in determining if a clip is selected or not.
; ; ;prFocus("Effect Controls")
; ; sendinput, {F10} ;highlights the effect controls
; ; sleep 10

; ; Send {tab}
; ; ;msgbox,,, its after the tab,0.7
; ; if (A_CaretX = "")
; ; {
	; ; ;No Caret (blinking vertical line) can be found. Therefore, no clip is selected.
	; ; ;therefore, we will select the top clip at playhead using the code below:
	
	; ; ;Send ^p ;"selection follows playhead," but this causes a windows mild error sound most of the time, wtf? So I'm gonna use another shortcut.
	; ; Sendinput ^{F8} ;"selection follows playhead," alternative mapping for macros to use. (CTRL F8)
	; ; sleep 15
	; ; ;Send ^p
	; ; Sendinput ^{F8}
; ; }




;msgbox,,, about to hit F5?,0.5
sendinput, {F5} ;this is set to "activate Direct Manipulation in Program Monitor" in premiere. this is just in case you've got a mogart selected or something.

sleep 5


BlockInput, On ;blocks keyboard and mouse input... I think.
BlockInput, MouseMove
SetKeyDelay, 0

;sendinput ^!+5 ;highlights the effect controls. This seems to result in ALT not being properly released, or otherwise occuring at the end of the macro when it triggers menu acceleration. That is unacceptable.

; sendinput {F10} ;highlights the effect controls. F10 can be used to avoid the stuck modifiers bug. But It's best to put it on a higher function key that isn't actaully present on the keyboard. at the time of writing, F16 and F22 are still available.

sendinput, {F22} ;In premiere's shortcuts, F22 is assigned to Application > Window > Effect Controls. This will bring focus to the Effect Controls panel, which is the same as clicking or middle clicking on it.

sleep 20
MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window ;This is the Effect controls panel. Info gotten from Window Spy. Your might be different. Be sure to check!!

;X := X+85 ;150% ui. change these variables to match the icon's position on your screen
;Y := Y+100 ;150% ui. change these variables to match the icon's position on your screen

X := X+56 ;100% ui
Y := Y+66 ;100% ui

MouseMove, X, Y, 0
MouseClick, left
MouseMove, %xpos%, %ypos%, 0
BlockInput, Off
BlockInput, MouseMoveOff

sleep 20
sendinput, {F16} ;highlights the timeline, alternative key assignement. Note that this gets messed up if you have more than one timeline window!!
;sendinput, ^!+3 ;highlights the timeline. Danger, this can sometimes change the sequence IF the effect controls were somehow not yet highlighted, or if some other script highlighted the timeline iguess?
;sendinput, 9 ;highlights the timeline
sleep 10
sendinput, {F5} ;this is set to "show direct clip manipulation" or whatever in premiere. but it doens't work too well so this is just in case you've got a mogart sleected or something.
;the above line might not be needed and in fact is useless isnce the shortcut only works while on the timeline....
sleep 103
;sendinput ^!+5 ;highlights the effect controls. This is so that if you hit COPY, it'll copy the motion effect, NOT a selected clip on the timeline.
sendinput {F22} ;highlights the effect controls

}


