// pass over some variable so we know what we're running...
// actually, I think we can call it with a function-reference
// like we had for the last version of the PGNS nouns

runOncePath("0:/PGNS/PGM/P00.ks").

set programs to lexicon().
programs:add("00", P00@).

declare function pgmPick {
  if programs:haskey(currentProgram) {
    programs[currentProgram]().
  } else {
    set OEBIT to true.
    raiseError(005).
    set currentProgram to oldProgram.
  }
}

