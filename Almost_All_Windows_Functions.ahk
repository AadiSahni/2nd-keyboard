#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%\support_files  ; Ensures a consistent starting directory.

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
	Run, Adobe Premiere Pro.exe
	tooltip, Premiere isn't running!!!!
	sleep 3000
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

;;;; +++++++++++++++++++++++++End of instant application switcher scripts

;;;+++++++++++++++++++SUPER KEY+++++++++++++++++++++++++++
superKey() 
	{
	; backcolor=121212
	; fontcolor=ffffff
	; fontsize=18
	; boldness=400
	; font=Arial
	; statusheight=75
	; statuswidth=1000
	; statusx=10
	; statusy=10
	; statusy = 1850
	; statusx = 30

	; Gui, superkeygui: new
	; Gui, Margin,0,0
	; Gui, Color, %backcolor%
	; Gui, Font,CFF0000 S15 W500 Q5, Franklin Gothic
	; Gui, Font,C%fontcolor% S%fontsize% W%boldness% Q5 underline,%font%
	; Gui, Add, Text,, "CapsLock + V was pressed. Waiting for secondary input."
	; Gui, Add, Edit
	; Gui, Add, Button, Hidden Default, OK
	
	; Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound ;Turns out you NEED THIS LINE for the transparency to work...????

	
	; WinSet, TransColor, %backcolor% 160, KEYSTROKE
	
	; Gui, Show
	
	; GuiClose:
	; ButtonOK:
	; Gui, Submit
	
	; gui in ahk is way too shitty and complicated. some other day, for now, tooltip
	
	Tooltip, Superkey, waiting for input
	SuperKeyInput:= GetKeyState(A)
	if SuperKeyInput = 1
		{	
		tooltip, this is for eternity and you pressed A
		
		}	
	
	
	
	}


;;;;;;;;;;++++++++++++++++++Begin Windows(shell) Mods Functions(this is almost all windows functions.ahk after all)

deselectAllExplorer()
{
	CoordMode Pixel ;, screen
	CoordMode Mouse, screen
	BlockInput, on
	BlockInput, MouseMove
	MouseGetPos, xPosCursor, yPosCursor
	
	MouseMove, 863, 823, 0
	; msgbox, moved to blank space
	sleep 5
	click left
	; msgbox, click
	MouseMove, xPosCursor, yPosCursor, 0
	; msgbox, back to orignal place
	BlockInput, off
	BlockInput, MouseMoveOff
}

copyPathExplorer() 
{
CoordMode Pixel ;, screen
CoordMode Mouse, screen
copyPathX = 157
copyPathY = 110 ; these are the coordinates of where the copy path button is roughly on my screen
copyPathEndX = 235
copyPathEndY = 131

; send, !h ; enable this if you don't have the ribbon pinned

; msgbox, ctrl shift c pressed

; BlockInput, on
; BlockInput, MouseMove
; MouseGetPos, xPosCursor, yPosCursor


; ImageSearch, FoundX, FoundY, copyPathX, copyPathY, copyPathEndX, copyPathEndY, %A_WorkingDir%\COPY_PATH_Home.png
; msgbox, image search done 

; if ErrorLevel = 0 
	; {
	; msgbox, 0
	; MouseMove, FoundX, FoundY, 0
	; click left
	; MouseMove, xPosCursor, yPosCursor, 0
	
	; BlockInput, off
	; BlockInput, MouseMoveOff ; to remove the tooltip i need to execute tooltip without any parameters but that adds a delay for the function to actually finish which keeps my mouse input off untill then, so I have this 2 times, on in the execution and on at the end of the script
	
	; ; all the above code is not necessary, turns out that when you copy a file, it copies it's path as well. Of course I do not to still modifiy the behaviour so that it removes the quotes so explorer doesn't think it's a link and open it in the default browser(which I guess is better than MS Edge or, ugh, internet explorer)
	; ; whatever the case maybe, i'm remapping ctrl c in explorer to this function and seeing if copy pasting files is affected by it. 
	; ; Also of not, is that removing the quotes from a copied file isn't ideal, and I'd rather find a way to disable opening links in explorer altogether, whether by an ahk script, or an application, or just a settings hid somewhere(perhaps regedit)
	
	; ; UPDATE!!!
	; The method I just told you, that file copy thing, doesn't work outside of explorer. to hell with you windows
	; Send, ^C
	
	; clipboard:= clipboard
	
	; StrReplace(clipboard, ",, )
	
	; get selected file's path
	clipboard =
	SendInput, ^c
	ClipWait
	
	oldstr = %clipboard%
	; Removes quotes
	StringReplace, newstr, oldstr,",,All;"  ; Include the escape character (`).
	clipboard = %clipboard%
	
	ToolTip, Copied file path to clipboard
	
	sleep 1000
	tooltip, 

	
	; }
; if ErrorLevel = 1
	; {
	; ; msgbox, 1
	; }
	
; if ErrorLevel = 2
	; {
	; ; msgbox, 2
	
	; }	
	; BlockInput, off
	; BlockInput, MouseMoveOff
}




; newItemExplorer clicks the new item menu so you can select a format
; for me weird usages, I just have it set to select a text file and the ctrl a so I can type the file exntension my self
; for this to work you must always have the ribbon menu pinned, although use the next line to use this without pinnin the ribbon

; IMPORTANT ++++++++++++++++++++++++++
; none of this is needed anymore, you can have it unpinned because i'm using context menu and deselect all to do this
newItemExplorer()
{
CoordMode Pixel ;, screen
CoordMode Mouse, screen
newItemX = 501
newItemY = 89 ; these are the coordinates of where the new item button is roughly on my screen
newItemEndX = 582
newItemEndY = 109

; send, !h 

; msgbox, ctrl n pressed

; ; BlockInput, on
; ; BlockInput, MouseMove
; ; MouseGetPos, xPosCursor, yPosCursor

; ; ImageSearch, FoundX, FoundY, newItemX, newItemY, newItemEndX, newItemEndY, %A_WorkingDir%\NEW_ITEM_Home.png
; ; ; msgbox, image search done

; ; if ErrorLevel = 0
	; ; {
	; ; ; msgbox, mission succesful, we found the image
	; ; MouseMove, FoundX, FoundY, 0
	; ; click left
	; ; MouseMove, xPosCursor, yPosCursor
	; ; Sleep 5
	; ; SendInput, {up}
	; ; Sleep 5
	; ; SendInput, {up}
	; ; Sleep 5
	; ; SendInput, {up}
	; ; Sleep 5
	; ; SendInput, {Enter}
	; ; Sleep 1100
	; ; Send, ^a
	; ; }
; ; if ErrorLevel = 1
	; ; {
	; ; ; msgbox, mission failed, we'll get em next time
	; ; }
; ; if ErrorLevel = 2
	; ; {
	; ; ; msgbox, mission paused bro, i dunno what happened
	; ; }
	
	; ; BlockInput, off
	; ; BlockInput, MouseMoveOff
	
	deselectAllExplorer()
	; msgbox, deselected
	Send, {AppsKey}
	sleep 50
	Send, {Ctrl up}
	Send, {w}
	Send, {t}
	sleep 10
	Send, {Ctrl up}
	sleep 100 
	SendInput, ^a
}
#IfWinActive