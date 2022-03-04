﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%\support_files  ; Ensures a consistent starting directory.

GroupAdd, ExplorerGroup, ahk_class #32770 ;This is for all the Explorer-based "save" and "load" boxes, from any program!
GroupAdd, ExplorerGroup, ahk_class CabinetWClass ;Regular Explorer window 

GroupAdd, browserGroup, ahk_class Chrome_WidgetWin_1
GroupAdd, browserGroup, ahk_class MozillaWindowClass



; MouseIsOver
; MouseIsOver is a simple function that allows me to do an action using #If when the mouse is over a certain window
MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}



; INSTANT APPLICATION SWITCHER+++++++++++++++++++++++++
; pretty simple actually, just a little bit of basic ahk knowledge

switchToExplorer(){
sleep 11 ;this is to avoid the stuck modifiers bug
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, aadiexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	Send, ^{Tab}
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

switchToChrome()
{
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe

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
	tooltip, Launching Premiere
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
	Run, "C:\Users\sahni\AppData\Local\WhatsApp\WhatsApp.exe"

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
IfWinNotExist, ahk_exe Discord.exe ; ;
	Run, "C:\Users\Sahni\AppData\Local\Discord\Update.exe" --processStart Discord.exe ; this is the exact path with command line parameters(the processStart part) i got from the discord shortcut on my taskbar
	; not sure if just using discord.exe would be the same
	; also, some programs that aren't in program files won't be accesible by just the exe without a file path. which is why you see me using a full path in some places which isn't good since some applications are in your user folder, and your username can change
	; check if you can run it directly by pressing windows + r and typing the exe name direcly instead of a full path. 

if WinActive("ahk_exe Discord.exe")
	WinMinimize
else
	WinActivate ahk_exe Discord.exe
}

switchToWord()
{
sleep 11 ;this is to try to avoid the stuck modifiers bug
;tooltip, why
Process, Exist, WINWORD.EXE
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, WINWORD.EXE
	else
	{
	IfWinExist, Microsoft Office Word, OK ;checks to see if the annoying "do you want to continue searching from the beginning of the document" dialouge box is present.
		sendinput, {escape}
	else if WinActive("ahk_class OpusApp")
		sendinput, {F3} ;set to "go to next comment" in Word.
	else
		WinActivate ahk_class OpusApp
	}

;maybe need to unstick modifiers
sleep 2
sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}


switchToNotepadplusplus()
{
IfWinNotExist, ahk_exe Notepad++.exe
	Run, Notepad++.exe
	
If WinActive("ahk_exe Notepad++.exe")
	Send ^{Tab}
else
	WinActivate ahk_exe Notepad++.exe
}


switchToSteam()
{
IfWinNotExist, ahk_exe steam.exe
	Run, "C:\Program Files (x86)\Steam\steam.exe"

if WinActive("ahk_exe steam.exe")
	WinMinimize
else
	WinActivate ahk_exe steam.exe

sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
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
leaderKey() 
	{
	
	
	
	
	
	
	; so the idea is that you presss a hotkey for activating leaderKey, and then press any other key or key combination, for example v, or v with any modifier like shift v and then it executes code based on what you pressed while inside leaderKey. Maybe I can wrap the key in F21 and have it corelate with an action the the assignments script kinda like how the second keyboard is done(each key is wrapped in F24, so it becomes F24 + a instead of just regular a)
	; for now the plan is dead, and I also don't have any keys left for assigning since the capslock layer is finished. 8, 9 and 0 are left, but they are reserved for Instant app Switcher, and the keys are too far right anyway, making it impossible to activate with one hand. P is also empty but again, same thing, too far right, hard to use regularly
	
	
	
	
	
	; ; ; backcolor=121212
	; ; ; fontcolor=ffffff
	; ; ; fontsize=18
	; ; ; boldness=400
	; ; ; font=Arial
	; ; ; statusheight=75
	; ; ; statuswidth=1000
	; ; ; statusx=10
	; ; ; statusy=10
	; ; ; statusy = 1850
	; ; ; statusx = 30

	; ; ; Gui, superkeygui: new
	; ; ; Gui, Margin,0,0
	; ; ; Gui, Color, %backcolor%
	; ; ; Gui, Font,CFF0000 S15 W500 Q5, Franklin Gothic
	; ; ; Gui, Font,C%fontcolor% S%fontsize% W%boldness% Q5 underline,%font%
	; ; ; Gui, Add, Text,, "CapsLock + V was pressed. Waiting for secondary input."
	; ; ; Gui, Add, Edit
	; ; ; Gui, Add, Button, Hidden Default, OK
	
	; ; ; Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound ;Turns out you NEED THIS LINE for the transparency to work...????

	
	; ; ; WinSet, TransColor, %backcolor% 160, KEYSTROKE
	
	; ; ; Gui, Show
	
	; ; ; GuiClose:
	; ; ; ButtonOK:
	; ; ; Gui, Submit
	
	; ; ; gui in ahk is way too shitty and complicated. some other day, for now, tooltip
	
	; ; Tooltip, Superkey. Waiting for input!
	; ; if GetKeyState("a")
		; ; msgbox, you pressed A and tis is superkey
	
	}


;;;;;;;;;;++++++++++++++++++Begin Windows(shell) Mods Functions(this is almost all windows functions.ahk after all)

deselectAllExplorer()
{
	; CoordMode Pixel ;, screen
	; CoordMode Mouse, screen
	; BlockInput, on
	; BlockInput, MouseMove
	; MouseGetPos, xPosCursor, yPosCursor
	
	; MouseMove, 863, 823, 0
	; ; msgbox, moved to blank space
	; sleep 5
	; click left
	; ; msgbox, click
	; MouseMove, xPosCursor, yPosCursor, 0
	; ; msgbox, back to orignal place
	; BlockInput, off
	; BlockInput, MouseMoveOff
	
	; PgUp ctrl space does the same thing and it's more reliable
	SendInput, {PgUp}
	sleep 1000
	Send, {Ctrl down}{Space}{Ctrl up}
	sleep 50
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
	Send, w
	Send, t
	sleep 10
	Send, {Ctrl up}
}



InstantExplorer(f_path,pleasePrepend := 0)
{
; This heavily modified script is from TaranVH
; The original is linked below

;this has been heavily modified from https://autohotkey.com/docs/scripts/FavoriteFolders.htm

;I feel ambivilant about this line. It'll be more stable, but it'll be a bit sloooowerrrr!
keywait, %A_priorhotkey% ;should there be a timeout clause? this still works even when launched with no hotkey, hmm.

sendinput, {blind}{SC0E8} ;scan code of an unassigned key. This is needed to prevent the item from merely FLASHING on the task bar, rather than opening the folder. Don't ask me why, but this works. Also, this is helpful for debugging.

;msgbox, hello

if pleasePrepend = 1 ;this is for the changeable per-project folder shortcuts
	{
	FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Windows_Mods\SavedExplorerAddress.txt
	;msgbox, current f_path is %f_path%
	if f_path =
		{
		; if f_path is BLANK, then we don't want to add a \ onto the end just by itself, as that will be done later!
		;msgbox, I did not add a blank f_path.
		f_path = %SavedExplorerAddress%
		}
	else
		f_path = %SavedExplorerAddress%\%f_path% ;there is no need to use . to concatenate
		
	;msgbox, new f_path is %f_path%
	;SUPER IMPORTANT NOTE - you must have explorer show the entire path in the title bar, or this doesn't work. I do need a better way to get that information. Something DLL based or whatever.
	}
;NOTE TO FUTURE TARAN: for Keyshower, put code here to find the first \ and remove the string before it. otherwise you can't see the FULL final folder name because it gets cropped off
;Keyshower(f_path,"InstExplor")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(f_path,"InstExplor") 
}

;;;NO LONGER IMPORTANT: YOU NEED TO GO INTO WINDOWS' FOLDER OPTIONS > VIEW > AND CHECK "DISPLAY THE FULL PATH IN THE TITLE BAR" OR THIS WON'T WORK.
;;;UPDATE: THE INSTRUCTION ABOVE ARE OBSOLETE NOW, I'VE FIGURED OUT A BETTER WAY TO DO GET THAT INFO! (It uses the windows API stuff that i have access to through AHK)


instantExplorerTryAgain:

if !FileExist(f_path)
{
	;MsgBox,,, %f_path%`nNo such path exists`, but we will go down in folders until it does.,1.0
	
	if InStr(f_path, "\"){
	
		FoundPos := InStr(f_path, "\", , StartingPos := 0, Occurrence := 1)
		;msgbox % FoundPos
		
		Length := StrLen(f_path)
		
		;StringLeft, OutputVar, InputVar, Count
		
		trimThis := Length - FoundPos
		
		;msgbox % trimThis
		
		NewString := SubStr(f_path, 1, FoundPos-1)
		;msgbox, NewString is %NewString%
		f_path := NewString
		GOTO, instantExplorerTryAgain
		;oh my god this code is so sloppy, it's great. And this is like, one of my best ever functions. I'm not even kidding. I use it like 20x an hour.
	}
	else
	{
		MsgBox,,, %f_path%`n`nNo such path exists.,1.0
		GOTO, instantExplorerEnd
		
	}
}

f_path = %f_path%\ ;;THIS ADDS A \ AT THE VERY END OF THE FILE PATH, FOR THE SAKE OF OLD-STYLE SAVE AS DIALOUGE BOXES WHICH REQUIRE THEM IN ORDER TO UPDATE THE FOLDER PATH WHEN IT IS INSERTED INTO Edit1.

;msgbox, f_path is currently %f_path% ;just debugging as usual

f_path := """" . f_path . """" ;this adds quotation marks around everything so that it works as a string, not a variable. 

;but also, the old style still dopesn't like the quotation marks, and I'm not sure how to detect it since i know almost nothing about it. ho hum. But it does have ClassNN:	SysListView321 which MAYBE i could use with this code https://autohotkey.com/board/topic/9362-detect-opensave-dialog/ but i dont know. saving this for later.

;msgbox, f_path is now finally %f_path%

;SoundBeep, 900, 400 ;this is dumb because you cant change the volume, or tell it NOT to wait while the sound plays...

; These first few variables are set here and used by f_OpenFavorite:
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
WinGetTitle, f_title, ahk_id %f_window_id% ;to be used later to see if this is the export dialouge window in Premiere...
if f_class in #32770,ExploreWClass,CabinetWClass  ; if the window class is a save/load dialog, or an Explorer window of either kind.
	ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%


	;edit2
	
; if f_AlwaysShowMenu = n  ; The menu should be shown only selectively.
; {
	; if f_class in #32770,ExploreWClass,CabinetWClass  ; Dialog or Explorer.
	; {
		; if f_Edit1Pos =  ; The control doesn't exist, so don't display the menu
			; return
	; }
	; else if f_class <> ConsoleWindowClass
		; return ; Since it's some other window type, don't display menu.
; }
; Otherwise, the menu should be presented for this type of window:
; Menu, Favorites, show


;msgbox, A_ThisMenuItemPos %A_ThisMenuItemPos%
;msgbox, A_ThisMenuItem %A_ThisMenuItem%
;msgbox, A_ThisMenu %A_ThisMenu%

;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
; msgbox, f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; f_OpenFavorite:
;msgbox, BEFORE:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; Fetch the array element that corresponds to the selected menu item:
;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
if f_path =
	return

if f_class = EVERYTHING    ; It's Everything search. I want to put the fodler name in quotes in the main field, because that's how you search a subdirectory.
{
ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%
;msgbox, this is Everything search`nf_Edit1Pos = %f_Edit1Pos%

if f_Edit1Pos <>   ; we know it should have an Edit1 control.
	{
	ControlFocus, Edit1, ahk_id %f_window_id%
	
	WinActivate ahk_id %f_window_id%
	
	f_path := f_path . " " ;this adds a space to the end, so i can type the actual thing to search for afterwards.

	ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
	;(it adds a space to the end too.)
	sleep 2
	ControlFocus, DirectUIHWND2, ahk_id %f_window_id% ;to try to get the focus back into the center area, so you can now type letters and have it go to a file or fodler, rather than try to SEARCH or try to change the FILE NAME by default.
	send, {end} ;to get to the end of the search box. best place to search for the actual thing i want to find.
	return
	}

GOTO, instantExplorerEnd 
}



if f_class = #32770    ; It's a dialog.
	{

	if WinActive("ahk_exe waifu2x-caffe.exe")
		{
		tooltip, you are inside of Waifu2x
		
		GOTO, ending2
		;this will open an explorer window rather than trying to change waifu2x's input path as it otherwise would.
		}
	
	if WinActive("ahk_exe Adobe Premiere Pro.exe")
		{
		tooltip, you are inside of premiere
		sleep 1000
		tooltip,
		
		if (f_title = "Export Settings") or if (f_title = "Link Media")
			{
			msgbox,,,you are in Premiere's export window or link media window, but NOT in the "Save as" inside of THAT window. no bueno, 1
			GOTO, instantExplorerEnd 
			;return ;no, I don't want to return because i still want to open an explorer window.
			}
		
		
		If InStr(f_title, "Link Media to") ;Note that you must have "use media browser to locate files" UNCHECKED because it is GARBAGE.
			{
			tooltip, you are inside Premieres relinker.
			; This requires custom code, because the EditX boxes are different:
			; last path   = Edit1
			; filename    = Edit2
			; address bar = Edit3

			ControlFocus, Edit2, ahk_id %f_window_id% 

			tooltip, you are inside the link media thingy
			sleep 1
			
			WinActivate ahk_id %f_window_id%
			sleep 1
			ControlGetText, f_text, Edit2, ahk_id %f_window_id%
			sleep 1
			ControlSetText, Edit2, %f_path%, ahk_id %f_window_id%
			ControlSend, Edit2, +{Enter}, ahk_id %f_window_id%
			Sleep, 100  ; It needs extra time on some dialogs or in some cases.
			ControlSetText, Edit2, %f_text%, ahk_id %f_window_id%
			;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
			
			tooltip,
			return		
			}

		if (f_title = "Save As") or if (f_title = "Save Project")
			{
			;;;ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%
			;ControlFocus, Edit2, ahk_id %f_window_id% ;we know that Edit2 is the address bar in this case. So there's no need to use Edit1 and then swap back in the filename.
			
			ControlFocus, Edit1, ahk_id %f_window_id% 
			;msgbox,,,you are hereee,0.5
			tooltip, you are here
			sleep 1
			;tippy2("DIALOUGE WITH PREMIERE'S Edit1`n`nLE controlfocus of Edit1 for f_window_id was just engaged.", 2000)
			; msgbox, is it in focus?
			; MouseMove, f_Edit1Pos, f_Edit1PosY, 0
			; sleep 10
			; click
			; sleep 10
			; msgbox, how about now? x%f_Edit1Pos% y%f_Edit1PosY%
			;msgbox, Edit1 has been clicked maybe
			
			; Activate the window so that if the user is middle-clicking
			; outside the dialog, subsequent clicks will also work:
			WinActivate ahk_id %f_window_id%
			; Retrieve any filename that might already be in the field so
			; that it can be restored after the switch to the new folder:
			ControlGetText, f_text, Edit1, ahk_id %f_window_id%
			sleep 1
			ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
			ControlSend, Edit1, +{Enter}, ahk_id %f_window_id%
			Sleep, 100  ; It needs extra time on some dialogs or in some cases.
			ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
			;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
			
			tooltip,
			return
			tooltip, do you make it this far
			tooltip, the answer is no. the RETURN ends it properly
			GOTO, instantExplorerEnd 
			;But i have the GOTO just in case, hahahaha
			}
		}

	; stuff beyond here is NOT in premiere
	if f_Edit1Pos <>   ; And it has an Edit1 control.
		{

		ControlFocus, Edit1, ahk_id %f_window_id% ;this is really important.... it doesn't work if you don't do this...
		;tippy2("DIALOUGE WITH EDIT1`n`nwait really?`n`nLE controlfocus of edit1 for f_window_id was just engaged.", 1000)
		; msgbox, is it in focus?
		; MouseMove, f_Edit1Pos, f_Edit1PosY, 0
		; sleep 10
		; click
		; sleep 10
		; msgbox, how about now? x%f_Edit1Pos% y%f_Edit1PosY%
		;msgbox, edit1 has been clicked maybe
		
		; Activate the window so that if the user is middle-clicking
		; outside the dialog, subsequent clicks will also work:
		WinActivate ahk_id %f_window_id%
		
		; Retrieve any filename that might already be in the field so
		; that it can be restored after the switch to the new folder:
		ControlGetText, f_text, Edit1, ahk_id %f_window_id%
		sleep 2
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		sleep 3
		ControlSend, Edit1, {Enter}, ahk_id %f_window_id%
		Sleep, 100  ; It needs extra time on some dialogs or in some cases.
		
		;now RESTORE the filename in that text field. I don't like doing it this way...
		ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
		;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
		sleep 2
		ControlFocus, DirectUIHWND2, ahk_id %f_window_id% ;to try to get the focus back into the center area, so you can now type letters and have it go to a file or fodler, rather than try to SEARCH or try to change the FILE NAME by default.
		return
		}
	; else fall through to the bottom of the subroutine to take standard action.
	}

;for some reason, the following code just doesn't work well at all.
/*
else if f_class in ExploreWClass,CabinetWClass  ; In Explorer, switch folders.
{
	tooltip, f_class is %f_class% and f_window_ID is %f_window_id%
	if f_Edit1Pos <>   ; And it has an Edit1 control.
	{
		Tippy2("EXPLORER WITH EDIT1 only 2 lines of code here....", 1000)
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		msgbox, ControlSetText happened. `nf_class is %f_class% and f_window_ID is %f_window_id%`nAND f_Edit1Pos is %f_Edit1Pos%
		; Tekl reported the following: "If I want to change to Folder L:\folder
		; then the addressbar shows http://www.L:\folder.com. To solve this,
		; I added a {right} before {Enter}":
		ControlSend, Edit1, {Right}{Enter}, ahk_id %f_window_id%
		return
	}
	; else fall through to the bottom of the subroutine to take standard action.
}
*/

else if f_class = ConsoleWindowClass ; In a console window, CD to that directory
	{
	WinActivate, ahk_id %f_window_id% ; Because sometimes the mclick deactivates it.
	SetKeyDelay, 0  ; This will be in effect only for the duration of this thread.
	IfInString, f_path, :  ; It contains a drive letter
		{
		StringLeft, f_path_drive, f_path, 1
		Send %f_path_drive%:{enter}
		}
	Send, cd %f_path%{Enter}
	return
	}
ending2:
; Since the above didn't return, one of the following is true:
; 1) It's an unsupported window type but f_AlwaysShowMenu is y (yes).
; 2) It's a supported type but it lacks an Edit1 control to facilitate the custom
;    action, so instead do the default action below.
;Tippy2("end was reached.",333)
;SoundBeep, 800, 300 ;this is nice but the whole damn script WAITS for the sound to finish before it continues...
; Run, Explorer %f_path%  ; Might work on more systems without double quotes.

;msgbox, f_path is %f_path%

; SplitPath, f_path, , OutDir, , ,
; var := InStr(FileExist(OutDir), "D")

; if (var = 0)
	; msgbox, directory does not exist
; else if var = 1
	Run, %f_path%  ; I got rid of the "Explorer" part because it caused redundant windows to be opened, rather than just switching to the existing window
;else
;	msgbox,,,Directory does not exist,1

instantExplorerEnd:
tooltip,
}
;end of instantexplorer()



#IfWinActive ; just to make sure i didn't forget to reset anything so my hotkeys in All_Multiple_Keyboard_Assignments.ahk still work.
; I would very much like to format all my code, but it's too much work. If you write it yourself, use newer syntaxing and use better formatting