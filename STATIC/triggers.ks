set oldCMPACTY to CMPACTY.
set oldGlobalRegVals to globalRegvals.

when terminal:input:haschar and inputInterrupt then {
    set CMPACTY to true. 
    set chaIn to terminal:input:getchar().
    takeInput(chaIn, xc, yc).
    preserve.
}

when terminal:input:haschar then {
    set CMPACTY to true.
    set chaIn2 to terminal:input:getchar().
    if chaIn2 = "+" {
        set inputInterrupt to true.
        set inputStream to "N". 
        set xc to 32.
        set yc to 9.
        print "  " at (xc, yc).
    }
    if chaIn2 = "-" {
        set inputInterrupt to true.
        set inputStream to "V".
        set xc to 22.
        set yc to 9.
        print "  " at (xc, yc).
    }
    if chaIn2 = "*" {
        // => PRO key
        // set inputInterrupt to true.
    }
    if chaIn2 = "/" {
        // => RESET key
        // set inputInterrupt to true.
    } 
    preserve.
}

// <> == != >= <= @ g $


when (oldGlobalRegVals[0] <> globalRegvals[0]) or (oldGlobalRegVals[1] <> globalRegvals[1]) or (oldGlobalRegVals[2] <> globalRegvals[2]) then {
    set CMPACTY to true.
    set oldGlobalRegVals to globalRegvals.
    set oldCMPACTY to CMPACTY.
    preserve.
}

when oldCMPACTY <> COMP_ACTY then {
    dataLights().
    set oldCMPACTY to CMPACTY.
    preserve.
}