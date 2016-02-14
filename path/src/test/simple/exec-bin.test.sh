#!/bin/bash
cd $(dirname $0)

path config

echo $(which echo-bin) > $0.expect~
echo-bin > $0.output~


