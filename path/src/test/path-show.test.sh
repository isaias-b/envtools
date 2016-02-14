#!/bin/bash
cd $(dirname $0)

echo $PATH | sed 's/:/\n/g' > $0.expect~
path show > $0.output~



