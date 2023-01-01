// INITIAL MAINTENANCE AND WATCHDOG
runOncePath("0:/PGNS/ROUTINES/R99.ks").
declare global function R00 {
  // routine 00 will always run. 
  set aliveTime to time:seconds - firstClock.
  if abs(aliveTime - lastResponseTime) >= 2 {
    raiseError(STACKTIMELIMIT).
    raiseProgError().
    R99(). // clear out the routineList incase of hang
  }.
}
