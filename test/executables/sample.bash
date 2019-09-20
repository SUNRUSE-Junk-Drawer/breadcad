load "../framework/main"

executable_name=sample
executable_help="sample - sample a sdf stream at a single point in space
  usage: [sdf stream] | sample [options]
  options:
    -h, --help, /?: display this message
    -x [number], --x [number]: location from which to sample (millimeters) (default: 0.000000)
    -y [number], --y [number]: location from which to sample (millimeters) (default: 0.000000)
    -z [number], --z [number]: location from which to sample (millimeters) (default: 0.000000)
"

@test "help (short name)" {
  test_help "-h"
}

@test "help (long name)" {
  test_help "--help"
}

@test "help (query)" {
  test_help "/?"
}
