// handles the entirety of the special V-N
// interactions with the computer

set verbInterrupt to list(0, 0, 0, 0).
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
  set verbInterrupt[2] to currentVerb = "35".
  set verbInterrupt[3] to currentVerb = "99".
  set verbPriority to verbInterrupt:find(true) <> -1.
  // so if it finds one interrupting verb as current,
  // then the return index will not be -1, so hence
  // we engage the verb priority on the register

  if currentVerb = "30" {
    // 2 decimal places
    set globalRegvals to list(round(abs(aliveTime - lastResponseTime), 4)*10000, "", "").
  }
  if currentVerb = "34" {
    NEW_PROG("00").
    REVERT_VERB().
  }
  if currentVerb =  "37" {
    set inputInterrupt to true.
    set inputStream to "P". 
    set xc to 32.
    set yc to 9.
  }
  if currentVerb = "81" {
    ROUTINE_ADD("10").
    REVERT_VERB().
  }
  if currentVerb = "99" {
    set globalRegvals to list("", "", "").
    set NEED_ASTRO_INPUT to true.
    // Further handling will be done from the trigger
  }
}

declare local function NOUNS {
  if currentNoun = "07" {
    set globalRegvals to list(lastErrorCode, secondLastErrorCode, thirdLastErrorCode).
  }
  if currentNoun = "36" {
    set globalRegvals to CLOCK_CALL(aliveTime).
  }
  if currentNoun = "43" {
    set globalRegvals to list(round(ship:geoposition:lat,2)*100, round(ship:geoposition:lng,2)*100, round(ship:altitude)).
  }
  if currentNoun = "44" {
    set globalRegvals to currentPosition.
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
