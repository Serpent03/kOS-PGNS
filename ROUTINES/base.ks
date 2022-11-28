runOncePath("0:/PGNS/ROUTINES/R00.ks").

set routines to lexicon().
routines:add("00", R00@).

set routineList to list().
// routineList will have routines that we actively update.
// all the routines will be in the lexicon, and if that key
// exists in the routineList, we will proceed to update it.

declare global function ROUTINE_ADD {
  parameter rne.
  set rne to rne:tostring().

  if rne:length = 2 {
    routineList:add(rne).
  }
  // if routine in routineList; return.
  // if not; verify, add and return
}
declare global function ROUTINE_DEL {
  parameter rne.
  // if routineAdd key in routineList; delete, return.
  // if routine not in routineList; return
}

declare global function routinePick {
  

  // iterate and call!
}