#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;================================================================================================
;  CapsLock processing.  Must double tap CapsLock to toggle CapsLock mode on or off.
;================================================================================================
; Must double tap CapsLock to toggle CapsLock mode on or off.
CapsLock::
    KeyWait, CapsLock                                                   ; Wait forever until Capslock is released.
    KeyWait, CapsLock, D T0.2                                           ; ErrorLevel = 1 if CapsLock not down within 0.2 seconds.
    if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") )                 ; Is a double tap on CapsLock?
        {
        SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"  ; Toggle the state of CapsLock LED
        }
    else
    {
        Send {Esc}
    }
return



;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================

;================================================================================================
; Vim-like navigation arrows
;================================================================================================
;Down key
CapsLock & j::
    Send {Down}
Return

;Up key
CapsLock & k::
    Send {Up}
Return

;Right key
CapsLock & l::
    Send {Right}
Return

;Left key
CapsLock & h::
    Send {Left}
Return

;================================================================================================
; Easy virtual desktop switching
;================================================================================================
;Right desktop
CapsLock & i::
    Send #^{Right}
Return

;Left desktop
CapsLock & u::
    Send #^{Left}
Return

;================================================================================================
; Miscellanous
;================================================================================================
;Compile & Run project for Visual Studio & alike
CapsLock & r::
    Send {F5}
Return

;Quit app
CapsLock & q::
    Send !{F4}
Return

;Open Windows Terminal

CapsLock & t::
	Run, wt
Return

; GOOGLE the selected text.
CapsLock & g::
    ClipboardGet()
    Run, http://www.google.com/search?q=%clipboard%             ; Launch with contents of clipboard
    ClipboardRestore()
Return

;================================================================================================
; Media Controls
;================================================================================================

; Mute
CapsLock & m::
    Send {Volume_Mute}
Return

; Pause
CapsLock & Space::
    Send {Media_Play_Pause}
Return

;++++++++++++++++++++++++++++++++++++++++++++++++++++

;================================================================================================
; Clipboard helper functions.
;================================================================================================
ClipboardGet()
{
    OldClipboard:= ClipboardAll                         ;Save existing clipboard.
    Clipboard:= ""
    Send, ^c                                            ;Copy selected test to clipboard
    ClipWait 0
    If ErrorLevel
        {
        MsgBox, No Text Selected!
        Return
        }
}


ClipboardRestore()
{
    Clipboard:= OldClipboard
}


