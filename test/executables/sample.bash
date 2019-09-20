load "../framework/main"

executable_name=sample
executable_help="sample - sample a sdf stream at a single point in space$LINE_BREAK
  usage: [sdf stream] | sample [options]$LINE_BREAK
  options:$LINE_BREAK
    -h, --help, /?: display this message$LINE_BREAK
    -x [number], --x [number]: location from which to sample (millimeters) (default: 0.000000)$LINE_BREAK
    -y [number], --y [number]: location from which to sample (millimeters) (default: 0.000000)$LINE_BREAK
    -z [number], --z [number]: location from which to sample (millimeters) (default: 0.000000)"

@test "help (short name)" {
  test_help "-h"
}

@test "help (long name)" {
  test_help "--help"
}

@test "help (query)" {
  test_help "/?"
}
