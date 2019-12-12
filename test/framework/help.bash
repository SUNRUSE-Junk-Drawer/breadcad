function test_help {
  check_successful "${BC_EXECUTABLE_PREFIX}$executable_name${BC_EXECUTABLE_SUFFIX} $1" "$executable_help"
}
