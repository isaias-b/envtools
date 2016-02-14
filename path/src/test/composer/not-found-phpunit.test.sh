#!/bin/bash
cd $(dirname $0)

pattern="phpunit: command not found"

echo $pattern > $0.expect~ 

# try to execute unavailable command
phpunit --version 2>&1 | \
  sed -e 's/.*\(phpunit: command not found\)/\1/g' \
  > $0.output~

