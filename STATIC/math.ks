// math functions to be used

declare global function CLOCK_CALL { 
    // convert time into HOUR / MIN / SEC
    parameter second.

    local minute to mod(floor(second / 60), 60).
    local hour to floor(second / 3600).
    
    return list(hour, minute, floor(mod(second, 60))).
}

declare global function SAFE_SQRT {
    parameter a.
    if a >= 0 {
        return sqrt(a).
    } else {
        raiseError(SQRTWITHNEGATIVE).
        return 0.
    }
}

declare global function SCALING {
    parameter data.
    parameter degree to 0.
    set data to data:tostring():toscalar().
    set degree to degree:tostring():toscalar().
    return round(data, degree) * 10^degree.
}

declare global function SCALING_DOWN {
    parameter data.
    parameter degree to 0.
    return round(data/10^degree).
}

declare global function DIV {
    parameter x, y.
    if y = 0 {
        raiseError(DIVBYZERO).
        return 0.
    }
    return x / y.
}

declare global function GROUND_RANGE { // return -> meter 
    parameter CPOS, TPOS.
    local GCA to vAng(CPOS, TPOS). // great circle angle
    local GCR to 2 * constant:pi * ship:body:radius. // great circle radius
    return round(abs(GCR * GCA/360)).
}

declare global function DIFFERENTIATE {
    parameter pV, opV, dT.
    local derivative to (pV-opV)/dT.
    return derivative.
}

declare global function LPD_DESIG {
    // return this as a vector for P64, actually
    // we'll project it, and then clear that projection
    // once we are in the terminal phase of P64
}

// a function for orbital parameters

declare global function LLA2ECI {
    parameter latlon, currentAlt.
    local R to (ship:body:radius + currentAlt).

    local lat to latlon:lat.
    local lon to mod(latlon:lng + ship:body:rotationangle, 360).

    local x to R * cos(lat) * cos(lon).
    local y to R * cos(lat) * sin(lon).
    local z to R * sin(lat).

    return V(x, y, z).
}

declare global function CARTESIAN2KEPLER {
    parameter p, pDot.
    parameter returnMode to 1. 
    // if we want to return things like ap/pe without body radius,
    // set this to 1. 1 by default.

    local angularMomentumVector to vCrs(p, pDot).
    local nVector to vCrs(v(0,0,1), angularMomentumVector). // N vector
    local eccVec to (vCrs(pDot, angularMomentumVector))/ship:body:mu - p:normalized.
    local e to eccVec:mag. // eccentricity
    local inclination to arcCos(angularMomentumVector:z/angularMomentumVector:mag).
    local longitudeOfAscendingNode to arcCos(nVector:x/nVector:mag).
    if nVector:y < 0 {
        set longitudeOfAscendingNode to (360 - longitudeOfAscendingNode).
    }
    local argumentOfPeriapsis to arcCos(vDot(nVector,eccVec)/(nVector:mag * e)).
    if (eccVec:z < 0) {
        set argumentOfPeriapsis to 360 - argumentOfPeriapsis.
    }
    local trueAnomaly to arcCos(eccVec * p / (e * p:mag)).
    if (vDot(p, pDot) < 0) {
        set trueAnomaly to 360 - trueAnomaly.
    }
    local SMA to 1 / ((2/p:mag) - (pDot:sqrmagnitude)/ship:body:mu).
    local ap to SMA * (1 + e).
    local pe to SMA * (1 - e).
    if returnMode = 1 {
        return list(ap-ship:body:radius, pe-ship:body:radius, inclination, longitudeOfAscendingNode, argumentOfPeriapsis, trueAnomaly).
    } else {
        return list(ap, pe, inclination, longitudeOfAscendingNode, argumentOfPeriapsis, trueAnomaly).
    }

}

// FROM NAVBALL.LIB

function east_for {
    parameter ves is ship.

    return vcrs(ves:up:vector, ves:north:vector).
}

function compass_for {
    parameter ves is ship,thing is "default".

    local pointing is ves:facing:forevector.
    if not thing:istype("string") {
        set pointing to type_to_vector(ves,thing).
    }

    local east is east_for(ves).

    local trig_x is vdot(ves:north:vector, pointing).
    local trig_y is vdot(east, pointing).

    local result is arctan2(trig_y, trig_x).

    if result < 0 {
        return 360 + result.
    } else {
        return result.
    }
}

function pitch_for {
    parameter ves is ship,thing is "default".

    local pointing is ves:facing:forevector.
    if not thing:istype("string") {
        set pointing to type_to_vector(ves,thing).
    }

    return 90 - vang(ves:up:vector, pointing).
}

function type_to_vector {
    parameter ves,thing.
    if thing:istype("vector") {
        return thing:normalized.
    } else if thing:istype("direction") {
        return thing:forevector.
    } else if thing:istype("vessel") or thing:istype("part") {
        return thing:facing:forevector.
    } else if thing:istype("geoposition") or thing:istype("waypoint") {
        return (thing:position - ves:position):normalized.
    } else {
        print "type: " + thing:typename + " is not recognized by lib_navball".
    }
}