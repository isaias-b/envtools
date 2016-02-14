#!/bin/bash
cd $(dirname $0)

path config

cat > $0.expect~ <<EOL
PHPUnit 5.0.10 by Sebastian Bergmann and contributors.
EOL

phpunit --version > $0.output~


