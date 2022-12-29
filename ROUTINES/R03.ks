// DAP data load -> throttle and attitude
declare global function R03 {
  if DAP_THROT_BOOL {
    // DAP_THROT_RQST will be updated in each separate PGM file
    set DAP_THROT to DAP_THROT_RQST.
    set ship:control:pilotmainthrottle to DAP_THROT.
    set DAP_THROT_PGM to currentProgram.
  } else {
    set DAP_THROT to ship:control:pilotmainthrottle.
    set DAP_THROT_PGM to "-1".
  }
  if DAP_ATT_BOOL {
    set DAP_ATT to DAP_ATT_RQST.
    set DAP_ATT_PGM to currentProgram.
  } 
  // DAP_ATT will be locked to DAP_ATT_RQST based on a trigger.
  // This trigger is based in the triggers file. It will lock/unlock only once, so that
  // we don't have any locks in a loop.
}