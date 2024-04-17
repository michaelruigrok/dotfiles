Perf( NumberOfSplits :=0 ) { ; Wrapper for QueryPerformanceCounter()by SKAN | CD: 06/Dec/2009
    Static F := 0,A := 0,Q := 0,P := 0,X := 0 ; www.autohotkey.com/forum/viewtopic.php?t=52083 | LM: 10/Dec/2009
    If ( NumberOfSplits  && !P )
        Return DllCall("QueryPerformanceFrequency", "Int64P", &F) + (X:=A:=0) + DllCall("QueryPerformanceCounter", "Int64P", &P)
    DllCall("QueryPerformanceCounter", "Int64P", &Q), A:=A+Q-P, P:=Q, X:=X+1
    Return ( NumberOfSplits  && X=NumberOfSplits  ) ?
        (X:=X-1)<<64 :
        ( NumberOfSplits =0 && (R:=A/X/F) ) ? ( R + (A:=P:=X:=0) ) : 1
}

; eg
; Perf(true)
; sleep(1000)
; TimeSinceInit := Perf()

; While Perf(1000) { ; runs contents of loop 1000 times
;   Sleep(1)
; }
; AvgTimePerLoop := Perf()
