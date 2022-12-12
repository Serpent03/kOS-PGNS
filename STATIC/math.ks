// math functions to be used

declare global function CLOCK_CALL { 
    // convert time into HOUR / MIN / SEC
    parameter second.

    local minute to mod(floor(second / 60), 60).
    local hour to floor(second / 3600).
    
    return list(hour, minute, floor(mod(second, 60))).
}

declare global function LPD_DESIG {
    // return this as a vector for P64, actually
    // we'll project it, and then clear that projection
    // once we are in the terminal phase of P64
}

// a function for orbital parameters
