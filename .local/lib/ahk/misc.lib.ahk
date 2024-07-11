#Include "Acc.ahk"

class Browser {

    static CurrentTab(handle) {
        exe := WinGetProcessName(handle)
        if (exe == "firefox.exe") {
          oAcc := Acc.ElementFromHandle(handle)
          site := oAcc.FindElement({Name:"Search with Google or enter address"})

          if ! site is String
              site := site.Value

          return String(site)
        }
        throw Error("Browser not currently supported")
    }
}

ToolTip2(params*) {
    ToolTip(params*)
    SetTimer((*) =>  KeyWait("LButton", "D") && ToolTip(), -1)
}

Has(haystack, needle) {
    for x in haystack
        if (x == needle)
            return 1
    return 0
}

class List extends Array {
    Includes(needle) {
        return Has(this, needle)
    }
}
