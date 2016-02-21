#!/bin/bash

installDir=$(pwd)
libraryDir=/usr/local/lib/path
userDir=~
completionDir=/etc/bash_completion.d
githubUrl=http://raw.githubusercontent.com/isaias-b
downloadUrl=$githubUrl/envtools/master/path/src/main

wget -nv -O $installDir/path.sh              $downloadUrl/path.sh
wget -nv -O $installDir/path.bashrc          $downloadUrl/path.bashrc
wget -nv -O $installDir/path.completion      $downloadUrl/path.completion

mkdir -p $libraryDir

mv -f $installDir/path.sh                   $libraryDir/path.sh
mv -f $installDir/path.bashrc               $libraryDir/path.bashrc
mv -f $installDir/path.completion           $completionDir/path

chmod +x $libraryDir/path.sh

echo "# path setup"                                >> $userDir/.bashrc
echo "export PATH_HOME=$libraryDir"                >> $userDir/.bashrc
echo "source \$PATH_HOME/path.sh get-source"       >> $userDir/.bashrc
echo ""                                            >> $userDir/.bashrc
echo ""                                            >> $userDir/.bashrc

source $userDir/.bashrc
source $completionDir/path

