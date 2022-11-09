// add in a wrapper function. time respecting.
// add in another file which has the data/opcodes for all the calculations.
// also add in the relevant program files.

// first target -> P00DOO, and P32-36 groups.. :)

// let's keep all of master variable states here
// individual program flags will go inside their own program 
// with their own checks

set config:ipu to 150.

set localControl to false. // are we being controlled by a PGM? True for yes
set shipSteering to 0. // currently selected program will do the steering

set currentProgram to "00".
set currentVerb to "00".
set currentNoun to "43".
set oldProgram to currentProgram.
set oldVerb to currentVerb.
set oldNoun to currentNoun.

set notOff to false.

set OEBIT to false.
set CMPACTY to false.
set IDLEBIT to false.

set lastErrorCode to 0.
set secondLastErrorCode to lastErrorCode.

set firstClock to time:seconds.
set aliveTime to time:seconds - firstClock.

set firstResponseTime to firstClock.
set lastResponseTime to time:seconds - firstResponseTime.
// now if this goes to something like -1 or -2, we do the restart.. who cares about VAC queues?!

runOncePath("0:/PGNS/STATIC/base.ks"). // -> STATIC functions library index
runOncePath("0:/PGNS/MAINTENANCE/base.ks").
runOncePath("0:/PGNS/PGM/base.ks"). // -> PGM library index

declare local function maintenance {
  set aliveTime to time:seconds - firstClock.
  agcGui().
  pgmPick().
}

until notOff {
  maintenance().
  set lastResponseTime to time:seconds - firstResponseTime.
  wait 0.1.
}




