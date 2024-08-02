#Requires AutoHotkey v2.0
#SingleInstance
#Warn  ; Enable warnings to assist with detecting common errors.
#Include "C:\Users\%A_UserName%\.local\lib\ahk\"
#Include "clipboard-history.lib.ahk"
#Include "misc.lib.ahk"
#Include "Acc.ahk"

DisabledApps := [
  ".*vim",
  "mintty",
  "tabby",
]

~LButton Up::
{
  try {
    MouseGetPos(&mouseWinX, &mouseWinY)
    CoordMode "Mouse", "Screen"
    MouseGetPos(&mouseX, &mouseY, &mouseW, &ctrl)
    window := "A"
    winClass := WinGetClass(window)
    exe := WinGetProcessName(window)
    el := Acc.ElementFromPoint(mouseX, mouseY)
  } catch {
    return
  }

  for i, x in DisabledApps
    if (exe ~= "i)^" . x . "\.exe$")
        return

  if (winClass == "Emacs")
    SendInput("!w")

  else if (exe ~= "WindowsTerminal.exe")
    return

  else if (exe ~= "i)Tabby.exe$")
    SendInput("+^c")

  else if (exe ~= "i)terminal.exe$")
    SendInput("+^c")

  else if (exe == "explorer.exe") {
    if (mouseWinX > 215 &&
      mouseWinY > 48 &&
      mouseWinY < 80
    )
      SendInput("^c")
  }

  else if (exe == "firefox.exe") {
    try site := Browser.CurrentTab(window)
    catch
      return

    if (!site || InStr(site, "ailab.codebots.tech/"))
      return
    else
      SendInput("^c")
  }

  else
    SendInput("^c")

  clipHist := ClipboardHistory
  if clipHist.HistoryEnabled {
      clips := clipHist.Count
      while (clips) {
          text := clipHist.GetItemText(clips)
          if (!text) {
              clipHist.DeleteItem(clips)
          }
          clips--
      }
      if clipHist.Count
          clipHist.PutItemIntoClipboard(1)
  }
  return
}

~MButton::
{
  try {
    MouseGetPos(&mouseWinX, &mouseWinY)
    CoordMode "Mouse", "Screen"
    MouseGetPos(&mouseX, &mouseY, &mouseW, &ctrl)
    window := "A"
    winClass := WinGetClass(window)
    exe := WinGetProcessName(window)
  } catch TargetError {
    return
  }

  debugInfo := Map(
    "Active Window", BoolStr(WinActive(window)),
    "Window Class", winClass,
    "Exe", exe,
  )

  if (!WinActive(window)) {
    WinActivate(window)
    WinWaitActive(window)
  }

  el := Acc.ElementFromPoint(mouseX, mouseY)
  debugInfo["Acc Role Initial"] := el.RoleText
  parent := el
  i := 0
  while (parent.accessible.accParent) {
    if (parent.RoleText == "editable text") {
      el := parent
      break
    }
    parent := parent.Parent
    i++
  }

  debugInfo["Acc Parent distance"] := i
  debugInfo["Acc Parent role"] := parent.RoleText
  debugInfo["Acc role"] := el.RoleText

  Debug(debugInfo)
  ;allowedAccRoles := ["editable text", "client"]
  ;if (! Has(allowedAccRoles, el.RoleText))
  ;  return

  for i, x in DisabledApps
    if (exe ~= x)
        return

  if (winClass == "Emacs")
    SendInput("^y")

  else if (exe == "Tabby.exe")
    SendInput("+^v")

  else if (exe ~= "i)terminal.exe$")
    SendInput("+^v")

  else if (exe == "explorer.exe") {
    if (mouseWinX > 215 &&
      mouseWinY > 48 &&
      mouseWinY < 80
    ) {
      SendEvent("!d") ; Move to toolbar
      SendInput("^v")
    }
  }

  else if (exe == "firefox.exe") {
    SendInput("{Escape}")
    ; TODO: Default action doesn't actually focus the window when in use. We need AHK to do this for us
    if (el.DefaultAction == "activate") {
      el.DoDefaultAction()
      SendInput("^v")
    }
  }

  else
    SendInput("^v")
  return
}
  
#HotIf !WinActive(, )


;; clipx
^mbutton::
{
  SendInput("^+{insert}")
  return
}
