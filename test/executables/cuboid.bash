load "../framework/main"

executable_name=cuboid
executable_help="cuboid - generates a cuboid
  usage: cuboid [options] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message
    -s [number], --size [number]: size on all axes (millimeters) (default: 1.000000)
    -c, --center: center on all axes
    -sx [number], --size-x [number]: size on x axis (millimeters) (default: 0.000000)
    -cx, --center-x: center on x axis (millimeters)
    -sy [number], --size-y [number]: size on y axis (millimeters) (default: 0.000000)
    -cy, --center-y: center on y axis (millimeters)
    -sz [number], --size-z [number]: size on z axis (millimeters) (default: 0.000000)
    -cz, --center-z: center on z axis (millimeters)"

@test "help (short name)" {
  test_help "-h"
}

@test "help (long name)" {
  test_help "--help"
}

@test "help (query)" {
  test_help "/?"
}

@test "empty stdin" {
  check_successful "bin/cuboid < test/sdf/empty.sdf | bin/sample" "inf"
}

@test "non-empty stdin" {
  check_failure "bin/cuboid < test/sdf/parameter_x.sdf" "unexpected stdin"
}
