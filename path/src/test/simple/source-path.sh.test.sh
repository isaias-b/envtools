#!/bin/bash
cd $(dirname $0)

printf "" > $0.expect~
source $(path get-source) > $0.output~


