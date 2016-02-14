#!/bin/bash
cd $(dirname $0)

path config

cat > $0.expect~ <<EOL
grunt-cli v0.1.13
grunt v0.4.5
EOL

grunt --version > $0.output~


