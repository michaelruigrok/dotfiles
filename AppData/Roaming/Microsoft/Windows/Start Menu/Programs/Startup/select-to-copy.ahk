#Requires AutoHotkey v2.0
#Warn  ; Enable warnings to assist with detecting common errors.
#Include "C:\Users\%A_UserName%\.local\lib\ahk\"
#Include "clipboard-history.lib.ahk"

DisabledApps := [
    ".*vim",
    "mintty",
    "tabby",
]

~LButton Up::
{
  try {
    winClass := WinGetClass("A")
    exe := WinGetProcessName("A")
    MouseGetPos(&mouseX, &mouseY, &mouseW, &ctrl)
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
    if (mouseX > 215 &&
      mouseY > 48 &&
      mouseY < 80
      )
      SendInput("^c")
  }

  else
    SendInput("^c")


  clipHist := ClipboardHistory
  if clipHist.HistoryEnabled {
      clips := clipHist.Count
      loop {
          text := clipHist.GetItemText(clips)
          if (!text) {
              clipHist.DeleteItem(clips)
          }
      } until (!--clips)
      clipHist.PutItemIntoClipboard(1)
  }
  return
}

~mbutton::
{
  try {
    winClass := WinGetClass("A")
    exe := WinGetProcessName("A")
    MouseGetPos(&mouseX, &mouseY, &mouseW, &ctrl)
  } catch TargetError {
    return
  }

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
    if (mouseX > 215 &&
      mouseY > 48 &&
      mouseY < 80
      )
      SendInput("^v")
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
