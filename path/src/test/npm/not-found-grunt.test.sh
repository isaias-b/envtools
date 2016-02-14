#!/bin/bash
cd $(dirname $0)

pattern="grunt: command not found"

echo $pattern > $0.expect~ 

# try to execute unavailable command
grunt --version 2>&1 | \
  sed -e 's/.*\(grunt: command not found\)/\1/g' \
  > $0.output~

