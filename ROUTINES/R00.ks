declare global function R00 {
  // routine 00 will always run. 
  set aliveTime to kuniverse:realtime - firstClock.
  if abs(aliveTime - lastResponseTime) >= 1.5 {
    raiseError(laggingCPU).
    raiseProgError().
  }.
}
