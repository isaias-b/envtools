#!/bin/bash
cd $(dirname $0)

path config

echo $(which echo-subfolder-bin) > $0.expect~
echo-subfolder-bin > $0.output~


