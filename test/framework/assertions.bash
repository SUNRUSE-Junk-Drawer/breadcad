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

function check_exit_successful {
  run bash -c "$1"
  assert_success
}

function check_successful {
  check_exit_successful "$1"
  check_stdout "$1" "$2"
}
