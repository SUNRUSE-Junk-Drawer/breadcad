function stdout_only {
  bash -c "$@" 2>/dev/null
}

function stderr_only {
  bash -c "$@" 1>/dev/null
}

function check_stdout {
  run stdout_only "$1"
  replaced=${2//$'\n'/$SDF_LINE_BREAK}
  assert_output "$replaced"
}

function check_stderr {
  run stderr_only "$1"
  replaced=${2//$'\n'/$SDF_LINE_BREAK}
  assert_output "$replaced"
}

function check_failure {
  check_stderr "$1" "$2"
  check_stdout "$1" ""
  assert_failure
}

function check_successful {
  check_stderr "$1" ""
  check_stdout "$1" "$2"
  assert_success
}
