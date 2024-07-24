#Requires AutoHotkey v2.0
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force

#Include komorebic.lib.ahk

#Include "C:\Users\%A_UserName%\.local\lib\ahk\"
#Include "misc.lib.ahk"

Init() {
    Critical
    SetCapsLockState false

    ; Allow win + L to be set
    RegWrite(1, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")

    FocusMonitor(0)
    ChangeLayout("bsp")

    MonitorGet(2, , , &Right, &Bottom)
    if (Right < Bottom) {
        For w in ["7", "9", "10", "8"] { ; end on workspace 8
            FocusNamedWorkspace(w)
            ChangeLayout("rows")
        }
        FocusMonitor(0)
    }
    Critical "Off"
}
Init()

CapsLock::Escape
#Enter::Run("wt")

+#Q::WinClose("A")


#s::{
    QuickMenu := {
        q: "mute",
    }
    ToolTip2(Pretty(QuickMenu))
    ih := InputHook("L1 T3")
    ih.Start()
    ih.Wait()
    Switch ih.Input {
        Case "q":
            Send "#!k"
    }
    ToolTip()
}

Lock() {
    RegWrite(0, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")
    DllCall("LockWorkStation")
    sleep(1000)
    RegWrite(1, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")
}

; Win+Esc enables lock screen for long enough to lock it.
#Escape:: {
    Lock()
    return
}

; Lock every 30 minutes, to force frequent breaks
SetTimer Lock, 30 * 60 * 1000

#+m::{
    For x in WinGetList()
        WinRestore(x)
}

; Focus windows
#h::Focus("left")
#j:: {
    Critical
    window := WinGetId("A")

    Focus("down")
    ; Wait for focus to update)
    Query("focused-container-index")

    if (window == WinGetId("A")) {
        Focus("right")
        Focus("down")

        if (Query("focused-container-index") == "0") {
            Focus("left")
        }
    }
    Critical "Off"
}
#k:: {
    Critical
    window := WinGetId("A")

    Focus("up")
    ; Wait for focus to update)
    Query("focused-container-index")

    if (window == WinGetId("A")
            && Query("focused-container-index") != "0"
        ) {
        Focus("left")
        Focus("up")
    }
    Critical "Off"
}
#l::Focus("right")
#+[::CycleFocus("previous")
#+]::CycleFocus("next")

; Move windows
#+h::Move("left")
#+j::Move("down")
#+k::Move("up")
#+l::Move("right")
#t::Promote()

; Stack windows
#Left::Stack("left")
#Right::Stack("right")
#Up::Stack("up")
#Down::Stack("down")
#;::Unstack()
#[::CycleStack("previous")
#]::CycleStack("next")

#w:: {
    Loop 32 {
        window := WinGetId("A")
        CycleFocus("next")
        ; Wait for focus to update)
        Query("focused-container-index")
        if window == WinGetId("A") {
            break
        }

        Stack("left")
        Stack("right")
        Stack("up")
        Stack("down")
    }
}

#z:: {
    window := WinGetId("A")
    Loop 32 {
        Unstack()
        CycleFocus("previous")

        ; Wait for focus to update)
        Query("focused-container-index")
        if window == WinGetId("A") {
            break
        }
    }
}

; Resize
#=::ResizeAxis("horizontal", "increase")
#-::ResizeAxis("horizontal", "decrease")
#+=::ResizeAxis("vertical", "increase")
#+-::ResizeAxis("vertical", "decrease")

; Manipulate windows
+#Space::ToggleFloat()
#f::ToggleMonocle()

; Window manager options
#+r::{
    Init()
    Retile()
}
#p::TogglePause()

; Layouts
+#x::FlipLayout("horizontal")
+#y::FlipLayout("vertical")

; Monitors
#^1::FocusMonitor(0)
#^2::FocusMonitor(1)
#^+1::SendToMonitor(0)
#^+2::SendToMonitor(1)

; Workspaces
#1::FocusNamedWorkspace("1")
#2::FocusNamedWorkspace("2")
#3::FocusNamedWorkspace("3")
#4::FocusNamedWorkspace("4")
#5::FocusNamedWorkspace("5")
#6::FocusNamedWorkspace("6")
#7::FocusNamedWorkspace("7")
#8::FocusNamedWorkspace("8")
#9::FocusNamedWorkspace("9")
#0::FocusNamedWorkspace("10")

; Move windows across workspaces
#+1::SendToNamedWorkspace("1")
#+2::SendToNamedWorkspace("2")
#+3::SendToNamedWorkspace("3")
#+4::SendToNamedWorkspace("4")
#+5::SendToNamedWorkspace("5")
#+6::SendToNamedWorkspace("6")
#+7::SendToNamedWorkspace("7")
#+8::SendToNamedWorkspace("8")
#+9::SendToNamedWorkspace("9")
#+0::SendToNamedWorkspace("10")
