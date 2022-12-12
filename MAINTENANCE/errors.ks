// error dictionary
set nonExistingProgram to "0045".
set incorrectDataEntry to "0190".
set missingOrbitalTarget to "0701".
set laggingCPU to "1201".

declare global function raiseError {
  parameter err to 0.
  set OEBIT to true.
  set thirdLastErrorCode to secondLastErrorCode.
  set secondLastErrorCode to lastErrorCode.
  set lastErrorCode to err.
}

declare global function clearErrors {
  set lastErrorCode to 0.
  set secondLastErrorCode to 0.
  set thirdLastErrorCode to 0.
}

declare global function raiseProgError {
  set PROGBIT to true.
}

declare global function raiseDebugLog {
  parameter message to "".
  parameter x to 2.
  parameter y to 20.

  set message to message:tostring().
  print message at (x, y).
}