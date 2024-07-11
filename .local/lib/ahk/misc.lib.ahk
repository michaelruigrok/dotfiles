#Include "Acc.ahk"

class Debug {
    static On := false
    static Call(data) {
        if (Debug.On) {
            ToolTip2(DisplayObj(data))
        }
    }
}

DisplayObj(Obj, Depth:=5, IndentLevel2:="") {
    if Type(Obj) = "Object"
        Obj := Obj.OwnProps()
    else
        return Obj

    for k, v in Obj {
        arr .= IndentLevel2 "[" k "]"
        if (IsObject(v) && Depth>1)
            arr .="`n" DisplayObj(v, Depth-1, IndentLevel2 . "    ")
        Else
            arr .=" => " v
        arr .="`n"
    }
    return RTrim(arr)
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
