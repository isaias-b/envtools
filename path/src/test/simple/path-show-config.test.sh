#!/bin/bash
cd $(dirname $0)

source $(path get-source)

expected=$PATH
expected=$expected:$(realpath .bin)
expected=$expected:$(realpath bin)
expected=$expected:$(realpath subfolder/bin)

echo $expected | sed 's/:/\n/g' > $0.expect~
path show-config > $0.output~


