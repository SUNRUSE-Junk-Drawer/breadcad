if [[ "$OSTYPE" == "msys" ]]; then
  export SDF_LINE_BREAK=$'\r\n'
else
  export SDF_LINE_BREAK=$'\n'
fi

export SDF_EXECUTABLE_PREFIX=$1

$2 test
