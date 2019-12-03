function test_help {
  check_successful "${SDF_EXECUTABLE_PREFIX}$executable_name${SDF_EXECUTABLE_SUFFIX} $1" "$executable_help"
}
