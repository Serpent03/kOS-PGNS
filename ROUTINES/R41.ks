declare global function R41 {
  set keplerianSet to CARTESIAN2KEPLER(currentPosition, currentVelocity).
  raiseDebugLog(keplerianSet[1], 2, 20).
}