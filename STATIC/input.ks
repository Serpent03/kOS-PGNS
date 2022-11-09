set inputInterrupt to false.
set inputStream to "".
set typeTime to aliveTime.

set inpStr to "".
set backSpace to terminal:input:backspace.
set enter to terminal:input:enter.

set xc to 0.
set yc to 0.

declare function takeInput {
    parameter userInput.
    parameter x to 2.
    parameter y to 2.
    
    if (userInput <> backSpace) or (userInput <> enter) {
        if inpStr:length <= 1 {
            set inpStr to inpStr + userInput.
            set inpStr to inpStr:trim().
        }
    }

    if userInput = backSpace and inpStr:length > 1 {
        set inpStr to inpStr:remove(inpStr:length-2, 2).
    }

    if userInput = enter {
        if inputStream = "N" {
            set oldNoun to currentNoun.
            set currentNoun to inpStr.
            set inputStream to "".
        }
        if inputStream = "V" {
            set oldVerb to currentVerb.
            set currentVerb to inpStr.
            set inputStream to "".
        }
        if inputStream = "P" {
            set oldProgram to currentProgram.
            set currentProgram to inpStr.
            set inputStream to "".
            set currentVerb to oldVerb.
        }
        set xc to 0.
        set yc to 0.
        set inputInterrupt to false.
        set inpStr to "".
    }
}