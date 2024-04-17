#Requires AutoHotkey v2.0
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force

; Load library
#Include komorebic.lib.ahk

CapsLock::Escape
#Enter::Run("wt")

Init() {
    ; Allow win + L to be set
    RegWrite(1, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")

    MonitorGet(2, , , &Right, &Bottom)
    if (Right < Bottom) {
        For w in ["7", "9", "10", "8"] { ; end on workspace 8
            FocusNamedWorkspace(w)
            ChangeLayout("rows")
        }
        FocusMonitor(0)
    }

}
Init()


+#Q::WinClose("A")

; Win+Esc enables lock screen for long enough to lock it.
#Escape:: {
    RegWrite(0, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")
    DllCall("LockWorkStation")
    sleep(1000)
    RegWrite(1, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")
    return
}


; Focus windows
#h::Focus("left")
#j:: {
    Critical
    window := WinGetId("A")
    Focus("down")
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
#^+1::MoveToMonitor(0)
#^+2::MoveToMonitor(1)

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
#+1::MoveToNamedWorkspace("1")
#+2::MoveToNamedWorkspace("2")
#+3::MoveToNamedWorkspace("3")
#+4::MoveToNamedWorkspace("4")
#+5::MoveToNamedWorkspace("5")
#+6::MoveToNamedWorkspace("6")
#+7::MoveToNamedWorkspace("7")
#+8::MoveToNamedWorkspace("8")
#+9::MoveToNamedWorkspace("9")
#+0::MoveToNamedWorkspace("10")
