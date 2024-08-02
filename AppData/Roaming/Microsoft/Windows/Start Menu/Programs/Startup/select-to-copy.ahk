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

class Winfo {

  id {
    get => this._id
    set {
      this._id := value

      this.class := WinGetClass(value)
      this.exe := WinGetProcessName(value)

      this.debug["active Window"] := BoolStr(WinActive(value))
      this.debug["window Class"] := this.class
      this.debug["exe"] := this.exe
    }
  }

  __New(window := "A") {
    this.debug := Map()
    try {
      MouseGetPos(&mouseX, &mouseY, &mouseWindow, &mouseCtrl)
      this.mouseX := mouseX
      this.mouseY := mouseY
      this.mouseWindow := mouseWindow

      CoordMode "Mouse", "Screen"
      MouseGetPos(&mouseScreenX, &mouseScreenY)
      this.mouseScreenX := mouseScreenX
      this.mouseScreenY := mouseScreenY

      if (window == "mouse") {
          window := mouseWindow
      }
      this.id := window
      this.el := Acc.ElementFromPoint(mouseScreenX, mouseScreenY)

      this.debug["Acc Role Initial"] := this.el.RoleText

    } catch TargetError as e {
      return
    }
  }
}

~LButton Up::
{
  if not w := WInfo()
    return

  for i, x in DisabledApps
    if (w.exe ~= "i)^" . x . "\.exe$")
        return

  if (w.class == "Emacs")
    SendInput("!w")

  else if (w.exe ~= "WindowsTerminal.exe")
    return

  else if (w.exe ~= "i)Tabby.exe$")
    SendInput("+^c")

  else if (w.exe ~= "i)terminal.exe$")
    SendInput("+^c")

  else if (w.exe == "explorer.exe") {
    if (w.mouseX > 215 &&
      w.mouseY > 48 &&
      w.mouseY < 80
    )
      SendInput("^c")
  }

  else if (w.exe == "firefox.exe") {
    try site := Browser.CurrentTab(w.id)
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

;~MButton::
$MButton::
{
  if not w := WInfo("mouse")
    return

  if (!WinActive(w.id)) {
    WinActivate(w.id)
    WinWaitActive(w.id)
  }

  parent := w.el
  i := 0
  while (parent.accessible.accParent) {
    if (parent.RoleText == "editable text") {
      w.el := parent
      break
    }
    parent := parent.Parent
    i++
  }

  w.debug["Acc Parent distance"] := i
  w.debug["Acc Parent role"] := parent.RoleText
  w.debug["Acc role"] := w.el.RoleText

  Debug(w.debug)
  ;allowedAccRoles := ["editable text", "client"]
  ;if (! Has(allowedAccRoles, w.el.RoleText))
  ;  return

  for i, x in DisabledApps
    if (w.exe ~= x) {
        Send "{MButton}"
        return
    }

  if (w.class == "Emacs")
    SendInput("^y")

  else if (w.exe == "Tabby.exe")
    SendInput("+^v")

  else if (w.exe ~= "i)terminal.exe$")
    SendInput("+^v")

  else if (w.exe == "explorer.exe") {
    if (w.mouseX > 215 &&
      w.mouseY > 48 &&
      w.mouseY < 80
    ) {
      SendEvent("!d") ; Move to toolbar
      SendInput("^v")
    }
  }

  else if (w.exe == "firefox.exe") {
    SendInput("{Escape}")

    if (w.el.DefaultAction == "activate") {
      w.el.DoDefaultAction()
      SendInput("^v")
    } else {
      Send "{MButton}"
    }
  }

  else
    SendInput("^v")
  return
}

$^+c::
{
  if not w := WInfo()
    return

  if (w.exe == "gvim.exe") {
    SendInput('"{+}y')

  } else {
    SendInput "^+c"
    return
  }

}

$^+v::
{
  if not w := WInfo()
    return

  if (w.exe == "gvim.exe") {
    SendInput('"{+}p')

  } else {
    Send "^+v"
    return
  }

}

#HotIf !WinActive(, )


;; clipx
^mbutton::
{
  SendInput("^+{insert}")
  return
}
