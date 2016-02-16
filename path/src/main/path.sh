#!/bin/bash

version=0.1
configFile=PATH
savedFile=.PATH~saved
backupFile=~/.PATH~backup
pathFile=.PATH
doecho=false

function realpath { echo "$(cd "$1" ; pwd)"; };

function build {
  newpath=$PATH
  while read p; do
    realp="$(realpath $p)"
    newpath=$newpath:$realp
  done <$configFile
  echo "$newpath"
}

function myecho {
  if $doecho; then echo "$1"; fi
}
function echo-done {
  myecho "done"
}
function set-path {
  PATH="$1" 
  echo "$PATH" > $pathFile
}


## path commands

function cmd-backup {
  myecho "save into $backupFile"
  echo "$PATH" > $backupFile && echo-done
}

function cmd-save {
  myecho "save into $savedFile"
  echo "$PATH" > $savedFile && echo-done
}

function cmd-load {
  myecho "load \$PATH from $savedFile"
  set-path $(cat $savedFile) && echo-done
}

function cmd-reset {
  myecho "load \$PATH from $backupFile"
  set-path $(cat $backupFile) && echo-done
}

function cmd-config {
  myecho "configure \$PATH built from $configFile"
  set-path $(echo "$(build)") && echo-done
}

function cmd-echo-on {
  doecho=true
}

function cmd-echo-off {
  doecho=false
}

function cmd-get-source {
  echo "$0"
}



## path show- commands

function cmd-show-commands {
  pattern="function cmd"
  pattern+="-"
  cat "$0" | grep "$pattern" | sed -e "s/$pattern//g" | sed -e "s/ {//g"
}

function cmd-show-config {
  myecho "show conifguration built from $configFile"
  myecho "$(cat $configFile | sed 's/:/\n/g')"
  build | sed 's/:/\n/g'
}

function cmd-show {
  myecho "show current \$PATH"
  echo "$PATH" | sed 's/:/\n/g'
}

function cmd-show-saved {
  myecho "show $savedFile"
  cat $savedFile | sed 's/:/\n/g'
}

function cmd-show-backup {
  myecho "show $backupFile"
  cat $backupFile | sed 's/:/\n/g'
}

function cmd-help {
  echo "path utility $version"
  echo "usage:  path <cmd1> [... <cmdN>]"
  echo "performs a series of path commands in given order"
  echo
  echo "tool to configure the \$PATH environment variable"
  echo "this is handy when dealing with heterogenous project"
  echo "environments, all coming with different collections"
  echo "of binaries, or same binaries in different versions"
  echo
  echo "used files:"
  echo "  config        line separated      $configFile"
  echo "  backup        color separated     $backupFile"
  echo "  saved         colon separated     $savedFile"
  echo
  echo "commands:       some are marked M for mutating"
  echo "  help          shows this help"
  echo "  save       M  saves current path into backup-file"
  echo "  load       M  loads path from save-file file created with load"
  echo "  reset      M  loads path from backup-file file created at shell spawn"
  echo "  config     M  appends configuration from config-file to \$PATH"
  echo "  echo-on       enable echo for upper mutator commands"
  echo "  echo-off      disable echo for upper mutator commands"
  echo "  show          shows contents of the \$PATH environment variable"
  echo "  show-saved    shows contents of backup-file"
  echo "  show-config   shows built path using config-file"
  echo "  get-source    retrieves the location of the path.sh file"
  echo
  echo "examples:"
  echo "  path save show-bak      save current \$PATH and show backup-file"
  echo "  path show-config        show built \$PATH using the config-file"
  echo "  path config show        configure \$PATH from config-file and show it"
  echo "  path doecho reset       enable echo and reset \$PATH from backup-file"
  echo
  echo "author:"
  echo "  Isaias Bartelborth"
  echo "  isaias.b@gmx.de"
  echo
}

function path {
  doecho=false
  for var in "$@"
  do
    cmd-$var
  done
  if [ $# = 0 ]; then cmd-help; fi
}

function isSourced {
  # http://stackoverflow.com/a/2684300/3165552
  [[ "${BASH_SOURCE[0]}" == "${0}" ]]
}

## main entry point

if isSourced
then
  path $@
fi
