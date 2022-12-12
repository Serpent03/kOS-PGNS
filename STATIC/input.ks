set inputInterrupt to false.
set inputStream to "".

set inpStr to "".
set backSpace to terminal:input:backspace.
set enter to terminal:input:enter.

set xc to 0.
set yc to 0.

set inputLengthGuide to lexicon().
inputLengthGuide:add("V", 1).
inputLengthGuide:add("N", 1).
inputLengthGuide:add("P", 1).
inputLengthGuide:add("ECADR", 1).
inputLengthGuide:add("INPUT", 4).

declare local function cleanup {
    set inputStream to "".
    set inputInterrupt to false.
    set inpStr to "".
}

declare global function takeInput {
    parameter userInput.
    parameter x to 2.
    parameter y to 2.

    local inputLength to inputLengthGuide[inputStream].

    if (userInput <> backSpace) or (userInput <> enter) {
        if inpStr:length <= inputLength {
            set inpStr to inpStr + userInput.
            set inpStr to inpStr:trim().
        }
    }

    if userInput = backSpace and inpStr:length > inputLength {
        set inpStr to inpStr:remove(inpStr:length-2, 2).
    }

    if userInput = enter {
        if inpStr:length = inputLength+1 {
            if inputStream = "N" {
                NEW_NOUN(inpStr).
            }
            if inputStream = "V" {
                NEW_VERB(inpStr).
            }
            if inputStream = "P" {
                NEW_PROG(inpStr).
                REVERT_VERB().
            }
            cleanup().
        } else {
            raiseError(incorrectDataEntry).
            cleanup().
            set xc to 0.
            set yc to 0.
        }
    }
}