#!/bin/bash
cd $(dirname $0)

path config

echo $(which echo-dot-bin) > $0.expect~
echo-dot-bin > $0.output~


