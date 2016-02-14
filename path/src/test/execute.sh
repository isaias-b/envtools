#!/bin/bash
#cd $(dirname $0)

# color definitions
FAILED='\033[0;33m'  # yellow
PASSED='\033[0;32m'  # green
ERROR='\033[0;31m'   # red
BOLD='\033[1;33m'    # bold light yellow
NC='\033[0m'         # none

function clearline() {
  printf '\r'
  printf ' %0.s' {0..100}
  printf '\r'
}

function showResults() {
  rc=$1
  evalExecution $rc && evalOutput
}

function evalExecution() {
  rc=$1
  if [ "$rc" = "0" ]; then
    return 0
  else
    printf "${ERROR}error${NC} \$?=$rc $testcase\n"
    cat $errorFile
    return $rc
  fi
}

function evalOutput() {
  expect=$(cat $expectFile)
  output=$(cat $outputFile)

  if [ "$expect" = "$output" ]; then
    printf "${PASSED}passed${NC} $testcase\n"
    cleanUp
  else
    printf "${FAILED}failed${NC} $testcase\n"
    printf "${BOLD}EXPECTED OUTPUT:${NC}\n"
    cat $expectFile
    printf "${BOLD}BUT OUTPUT WAS:${NC}\n"
    cat $outputFile
  fi 
}

function executeSingle() {
  testcase=$(basename $1)

  expectFile=$testcase.expect~
  outputFile=$testcase.output~
  errorFile=$testcase.error~

  path reset
  cleanUp
  printf "executing testcase $testcase ... "
  ./$testcase 2> $errorFile
  rc=$?
  clearline
  showResults $rc
}

function cleanUp() {
  rm -f $expectFile $outputFile $errorFile
}  


if [ $# = 0 ]; then
  find $var -name "*.test.sh" | xargs $0
else
  for var in "$@"
  do
    executeSingle $var
  done
fi


