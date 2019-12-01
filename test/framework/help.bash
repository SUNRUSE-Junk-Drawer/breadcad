function test_help {
  check_successful "${SDF_EXECUTABLE_PREFIX}$executable_name $1" "$executable_help"
}
