// error dictionary
set nonExistingProgram to "0045".
set incorrectDataEntry to "0190".
set missingOrbitalTarget to "0701".

declare global function raiseError {
  parameter err to 0.
  set thirdLastErrorCode to secondLastErrorCode.
  set secondLastErrorCode to lastErrorCode.
  set lastErrorCode to err.
}

declare global function clearErrors {
  set lastErrorCode to 0.
  set secondLastErrorCode to 0.
  set thirdLastErrorCode to 0.
}