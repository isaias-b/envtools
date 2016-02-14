#!/bin/bash
cd $(dirname $0)

path show-config > $0.expect~
path config show > $0.output~


