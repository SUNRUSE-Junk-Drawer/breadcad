if [[ "$OSTYPE" == "msys" ]]; then
  export BC_LINE_BREAK=$'\r\n'
else
  export BC_LINE_BREAK=$'\n'
fi

export BC_EXECUTABLE_PREFIX=$1
export BC_EXECUTABLE_SUFFIX=$2

$3 test
