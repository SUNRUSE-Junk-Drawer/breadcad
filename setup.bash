if [[ "$OSTYPE" == "msys" ]]; then
  export SDF_LINE_BREAK=$'\r\n'
else
  export SDF_LINE_BREAK=$'\n'
fi

export SDF_EXECUTABLE_PREFIX=$1
export SDF_EXECUTABLE_SUFFIX=$2

$3 test
