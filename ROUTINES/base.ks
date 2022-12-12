runOncePath("0:/PGNS/ROUTINES/R00.ks").
runOncePath("0:/PGNS/ROUTINES/R10.ks").
runOncePath("0:/PGNS/ROUTINES/R99.ks"). // for cleanup

set routines to lexicon().
routines:add("10", R10@).

set routineList to list().
// routineList will have routines that we actively update.
// all the routines will be in the lexicon, and if that key
// exists in the routineList, we will proceed to update it.

declare global function ROUTINE_ADD {
  parameter rne.
  set rne to rne:tostring().

  if rne:length = 2 and routineList:find(rne){
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
  for rns in routineList {
    routines[rns]().
  }
  R99(). // runs every time to clear routine stack
}