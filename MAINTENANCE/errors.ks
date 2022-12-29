// error dictionary
// 1xxxx -> information
// 2xxxx -> ignorable errors. program can proceed without them resolving
// 3xxxx -> critical errors. program can't proceed without them resolving
set MISSINGPROGRAM to "10045".
set ILLEGALENTRYFORMAT to "10190". 
set V37NOTALLOWED to "11520".
set SQRTWITHNEGATIVE to "21302".
set ARITHMETICONSTRING to "26088".
set DIVBYZERO to "25910".
set STACKTIMELIMIT to "31201".
set ORBITALTGTMISSING to "36064".

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