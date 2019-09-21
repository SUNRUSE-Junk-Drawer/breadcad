if [[ "$OSTYPE" == "win32" ]]; then
  export SDF_BATS_PATH=../bin/bats
  export SDF_LINE_BREAK=$'\r\n'
else
  SDF_BATS_PATH=submodules/bats-core/bin/bats
  export SDF_BATS_PATH
  export SDF_LINE_BREAK=$'\n'
fi

$@
