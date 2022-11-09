// math functions to be used

declare function CLOCK_CALL { 
    // convert time into HOURS / MIN / SEC
    parameter second.

    local minute to mod(floor(second / 60), 60).
    local hour to floor(second / 3600).
    
    return list(floor(mod(second, 60)), minute, hour).
}

// a function for orbital parameters
