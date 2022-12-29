// handles the entirety of the special V-N
// interactions with the computer

set verbInterrupt to list(0, 0, 0, 0, 0).
// (B_V27, B_V30, B_V35, B_V99)
set verbPriority to false.

declare global function special_functions {
  VERBS().
  if not verbPriority {
    NOUNS().
  }
  if inputInterrupt {
    set globalRegvals to list("", "", "").
  } // this should ensure that the screen remains blanked out
}

declare local function VERBS {
  set verbInterrupt[0] to currentVerb = "27".
  set verbInterrupt[1] to currentVerb = "30".
  set verbInterrupt[2] to currentVerb = "31".
  set verbInterrupt[3] to currentVerb = "35".
  set verbInterrupt[4] to currentVerb = "99".
  set verbPriority to verbInterrupt:find(true) <> -1.
  // so if it finds one interrupting verb as current,
  // then the return index will not be -1, so hence
  // we engage the verb priority on the register

  if currentVerb = "30" {
    // Show 2 decimal places of current program process time
    set globalRegvals to list(SCALING(abs(aliveTime - lastResponseTime), 4), "", "").
  }
  if currentVerb = "31" {
    set globalRegvals to list(routineQueue, "", "").
  }
  if currentVerb = "34" {
    // Cancel current program
    NEW_PROG("00").
    REVERT_VERB().
  }
  if currentVerb =  "37" {
    if V37INHIBIT {
      raiseError(V37NOTALLOWED).
      REVERT_VERB().
    } else {
      set inputInterrupt to true.
      set inputStream to "P".
      SET_XY("NOUN"). 
      // because current input display for PROGRAM is at
      // same place as NOUN
    }
  }
  if currentVerb = "81" {
    // Request update of orbital parameters once
    NEW_ROUTINE("30").
    REVERT_VERB().
  }
  if currentVerb = "99" {
    set globalRegvals to list("", "", "").
    set NEED_ASTRO_INPUT to true.
    // Further handling will be done from the trigger
  }
}

declare local function NOUNS {
  if currentNoun = "09" {
    set globalRegvals to list(thirdLastErrorCode, secondLastErrorCode, lastErrorCode).
  }
  if currentNoun = "36" {
    set globalRegvals to CLOCK_CALL(aliveTime).
  }
  if currentNoun = "43" {
    set globalRegvals to list(SCALING(ship:geoposition:lat,2), SCALING(ship:geoposition:lng,2), SCALING(ship:altitude)).
  }
  if currentNoun = "44" {
    set globalRegvals to currentPosition.
  }
  if currentNoun = "92" {
    set globalRegvals to list(DAP_THROT_RQST * 100, SCALING(verticalSpeed, 1), "").
  }
}

declare global function REVERT_VERB {
  set currentVerb to oldVerb.
}

declare global function REVERT_NOUN {
  set currentNoun to oldNoun.
}

declare global function REVERT_PROG {
  set currentProgram to oldProgram.
}

declare global function NEW_NOUN {
  parameter noun.
  set oldNoun to currentNoun.
  set currentNoun to noun:tostring().
}

declare global function NEW_VERB {
  parameter verb.
  set oldVerb to currentVerb.
  set currentVerb to verb:tostring().
}

declare global function NEW_PROG {
  parameter program.
  set oldProgram to currentProgram.
  set currentProgram to program:tostring().
}
