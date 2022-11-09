// handles the entirety of the special V-N
// interactions with the computer
declare function special_functions {
  VERBS().
  NOUNS().
  if inputInterrupt {
    set globalRegvals to list("", "", "").
  } // this should ensure that the screen remains blanked out
}

declare local function VERBS {
  if currentVerb = 37 {
    set inputInterrupt to true.
    set inputStream to "P". 
    set xc to 32.
    set yc to 9.
    print "  " at (xc, yc).
  }
}

declare local function NOUNS {
  if currentNoun = "07" {
    set globalRegvals to list(lastErrorCode, secondLastErrorCode, "").
  }
  if currentNoun = "43" {
    set globalRegvals to list(round(ship:geoposition:lat,2)*100, round(ship:geoposition:lng,2)*100, round(ship:altitude)).
  }
}