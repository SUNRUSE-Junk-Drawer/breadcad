function test_help {
  check_successful "bin/$executable_name $1" "$executable_help"
}
