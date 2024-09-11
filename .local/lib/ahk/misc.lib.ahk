#Include "Acc.ahk"

class Debug {
    static Enabled := false

    static On() {
        this.Enabled := true
    }
    static Off() {
        this.Enabled := false
    }
    static Call(data) {
        if (Debug.Enabled) {
            ToolTip2(data)
        }
    }
}

Pretty(data, Depth:=5, IndentLevel2:="") {

    if type(data) == 'String'
        return data

    if not HasMethod(data, "__Enum")
        data := data.OwnProps()

    arr := ""
        for k, v in data {
            arr .= IndentLevel2 "[" k "]"
            if (IsObject(v) && Depth>1)
                arr .="`n" Pretty(v, Depth-1, IndentLevel2 . "    ")
            Else
                arr .=" => " v
            arr .="`n"
        }
    if arr
        return RTrim(arr)
    return String(data)
}

BoolStr(pred) {
    return pred ? "true" : "false"
}

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

ToolTip2(content, params*) {
    ToolTip(Pretty(content), params*)
    local Clear := (*) => ToolTip()
    ; TODO: try and run Clear() when thread is interrupted.
    SetTimer((*) => KeyWait("LButton", "D") && Clear(), -1, -999999)
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
