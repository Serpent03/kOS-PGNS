// UPDATE ORBITAL PARAMETERS
local localClock to time:seconds.
local delta to time:seconds - localClock.

set currentPosition to LLA2ECI(ship:geoposition, alt:radar).
set oldPosition to currentPosition.

set currentVelocity to v(0,0,0).
set oldVelocity to currentVelocity.

set currentAcc to v(0,0,0).
set oldAcc to currentAcc.

set currentJerk to v(0,0,0).

declare global function R30 {
  set delta to time:seconds - localClock.
  set localClock to time:seconds.

  set currentPosition to LLA2ECI(ship:geoposition, ship:altitude).
  set currentVelocity to DIFFERENTIATE(currentPosition, oldPosition, delta).
  set oldPosition to currentPosition.

  set currentAcc to DIFFERENTIATE(currentVelocity, oldVelocity, delta).
  set oldVelocity to currentVelocity.
  set currentVelocity to currentVelocity + (currentAcc * 1/2 * delta).

  set currentJerk to DIFFERENTIATE(currentAcc, oldAcc, delta).
  set oldAcc to currentAcc.
  set currentAcc to currentAcc + (currentJerk * 1/6 * delta).
  set currentVelocity to currentVelocity + (currentAcc * 1/2 * delta).

  // raiseDebugLog(currentJerk:mag, 2, 20).

  CARTESIAN2KEPLER(currentPosition, currentVelocity).
}