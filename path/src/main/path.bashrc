
function path() {
  ~/envtools/path/src/main/path.sh $@
  if [ -f .PATH ]
  then
    PATH=$(cat .PATH)
  fi
}

export -f path

path backup


