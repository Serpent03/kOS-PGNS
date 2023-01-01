runOncePath("0:/PGNS/ROUTINES/R00.ks"). // Watchdog
runOncePath("0:/PGNS/ROUTINES/R03.ks"). // DAP data load
runOncePath("0:/PGNS/ROUTINES/R11.ks"). // Abort discretes monitor
runOncePath("0:/PGNS/ROUTINES/R12.ks"). // Descent state vector guidance updates
runOncePath("0:/PGNS/ROUTINES/R30.ks"). // Orbital parameters
runOncePath("0:/PGNS/ROUTINES/R31.ks"). // Rendezvous parameters
runOncePath("0:/PGNS/ROUTINES/R41.ks"). // State vector integration (Keplerian elements)
runOncePath("0:/PGNS/ROUTINES/R36.ks"). // Out of plane computation
runOncePath("0:/PGNS/ROUTINES/R63.ks"). // Rendezvous final attitude
runOncePath("0:/PGNS/ROUTINES/R99.ks"). // Cleanup

set routines to lexicon().
routines:add("03", R03@).
routines:add("11", R11@).
routines:add("12", R12@).
routines:add("30", R30@).
routines:add("31", R31@).
routines:add("36", R36@).
routines:add("41", R41@).
routines:add("63", R63@).

set routineList to list().
set routineQueue to routineList:length.
// routineList will have routines that we actively update.
// all the routines will be in the lexicon, and if that key
// exists in the routineList, we will proceed to update it.

declare global function NEW_ROUTINE {
  parameter rne.
  set rne to rne:tostring().

  if rne:length = 2 {
    routineList:add(rne).
  }
  // if routine in routineList; return.
  // if not; verify, add and return
}

declare global function routinePick {
  // routineList will get cleaned up if it is ran once
  // because of the loop-iteration power draw, we will start a routine
  // ONLY if a program demands it, with some exceptions

  R00(). // runs every time to update clocks.
  set routineQueue to routineList:length.
  set CMPACTY to routineQueue > 0. 
  // if we have a routine running, then CMPACTY is back on

  for rns in routineList {
    routines[rns]().
  }
  R99(). // runs every time to clear routine stack
}