local oldCMPACTY to CMPACTY.
local oldGlobalRegVals to globalRegvals.
local oldATTBool to DAP_ATT_BOOL.

when terminal:input:haschar and inputInterrupt then {
    set CMPACTY to true. 
    set chaIn to terminal:input:getchar().
    takeInput(chaIn, xc, yc).
    preserve.
}

when terminal:input:haschar and not inputInterrupt then {
    set CMPACTY to true.
    set chaIn2 to terminal:input:getchar().
    if chaIn2 = "+" {
        set inputInterrupt to true.
        set inputStream to "N". 
        SET_XY("NOUN").
        print currentVerb:tostring:padright(2) at (22, 9). 
        print "  " at (xc, yc).
    }
    if chaIn2 = "-" {
        set inputInterrupt to true.
        set inputStream to "V".
        SET_XY("VERB").
        print currentNoun:tostring:padright(2) at (32, 9).
        print "  " at (xc, yc).
    }
    if chaIn2 = "0" {
        // => PRO key
        if NEED_ASTRO_INPUT {
            if currentVerb = "99" {
                // When requesting engine ignition.
                set DAP_THROT_BOOL to true.
                REVERT_VERB().
            }
            set NEED_ASTRO_INPUT to false.
            // deal with it here.
        }
        // set inputInterrupt to true.
    }
    if chaIn2 = "/" {
        // => RESET key
        // set inputInterrupt to true.
    } 
    preserve.
}

when oldATTBool <> DAP_ATT_BOOL then {
    set oldATTBool to DAP_ATT_BOOL.
    if DAP_ATT_BOOL {
        lock steering to DAP_ATT_RQST.
    } else {
        unlock steering.
    }
    preserve.
}

// The register[1,2,3] trigger for COMP_ACTY light trigger is not
// accurate to life.

// when (oldGlobalRegVals[0] <> globalRegvals[0]) or (oldGlobalRegVals[1] <> globalRegvals[1]) or (oldGlobalRegVals[2] <> globalRegvals[2]) then {
//     set CMPACTY to true.
//     set oldGlobalRegVals to globalRegvals.
//     // set oldCMPACTY to CMPACTY.
//     preserve.
// }

when oldCMPACTY <> CMPACTY then {
    dataLights().
    set oldCMPACTY to CMPACTY.
    preserve.
}