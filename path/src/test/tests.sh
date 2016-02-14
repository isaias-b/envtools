#! /bin/sh

testEquality()
{
  assertEquals 1 1
}

testPartyLikeItIs1999()
{
  year=`date '+%Y'`
  assertEquals "It's not 1999 :-(" \
      '1999' "${year}"
}

cd $(dirname $0)

echo $PATH | sed 's/:/\n/g' > $0.expect~
path show > $0.output~


# load shunit2
. shunit2

