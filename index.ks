// add in a wrapper function. time respecting.
// add in another file which has the data/opcodes for all the calculations.
// also add in the relevant program files.

// first target -> P00DOO, and P32-36 groups.. :)

// let's keep all of master variable states here
// individual program flags will go inside their own program 
// with their own checks

set config:ipu to 400. // set this to the lowest possible value

set DAP_THROT_BOOL to false. // is the DAP managing our throttle?
set DAP_THROT_PGM to "-1". // what program is throttle managed by?
set DAP_THROT_RQST to 0. // what is the requested throttle value by DAP?
set DAP_THROT to DAP_THROT_RQST. // actual throttle output

set DAP_ATT_BOOL to false. // is the DAP managing our attitude?
set DAP_ATT_PGM to "-1". // what program is attitude managed by?
set DAP_ATT_RQST to ship:facing:forevector. // what is the requested attitude by DAP?
set DAP_ATT to DAP_ATT_RQST. // actual attitude output

// DAP_THROT and DAP_ATT will be used in place of LOCK STEERING/THROTTLE
lock throttle to DAP_THROT.
// throttle will always stay on DAP_THROT.
// now we influence DAP_THROT by hand or code

set currentProgram to "00".
set currentVerb to "16".
set currentNoun to "43".
set oldProgram to currentProgram.
set oldVerb to currentVerb.
set oldNoun to currentNoun.

set service_dead to false.

set NEED_ASTRO_INPUT to false.
set OEBIT to false.
set PROGBIT to false.
set CMPACTY to false.
set IDLEBIT to false.
set V37INHIBIT to false.

set lastErrorCode to "0000".
set secondLastErrorCode to lastErrorCode.
set thirdLastErrorCode to secondLastErrorCode.

set firstClock to time:seconds.
set aliveTime to time:seconds - firstClock.
set lastResponseTime to time:seconds - firstClock.
// now if this goes to something like -1 or -2, we do the restart..
//  who cares about VAC queues?!

set currentPosition to ship:position.
set currentVelocity to ship:velocity:orbit.
// currentPosition and currentVelocity are placeholders

set keplerianSet to list(ship:apoapsis, ship:periapsis, ship:orbit:inclination, ship:orbit:longitudeofascendingnode, ship:orbit:argumentofperiapsis, ship:orbit:trueanomaly).
// ap, pe, inc, longitudeOfAscendingNode, argumentOfPeriapsis, trueAnomaly
// to describe our orbit and the position in that orbit

runOncePath("0:/PGNS/STATIC/base.ks"). // -> STATIC functions library index
runOncePath("0:/PGNS/ROUTINES/base.ks"). // -> routines 
runOncePath("0:/PGNS/GUI/base.ks"). // -> STATIC functions library index
runOncePath("0:/PGNS/MAINTENANCE/base.ks"). // -> general 
runOncePath("0:/PGNS/PGM/base.ks"). // -> PGM library index

declare local function servicer {
  routinePick().
  pgmPick().
  agcGui().
}

until service_dead {
  servicer().
  set lastResponseTime to time:seconds - firstClock.
  wait 0.
}




