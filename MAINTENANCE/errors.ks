// error dictionary
// 005 => program does not exist
// 006 => incorrect values
// 1202 => ...

declare function raiseError {
  parameter err to 0.
  set lastErrorCode to err.
  set secondLastErrorCode to lastErrorCode.
}

declare function clearErrors {
  set lastErrorCode to 0.
  set secondLastErrorCode to 0.
}