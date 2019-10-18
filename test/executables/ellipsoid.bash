load "../framework/main"

executable_name=ellipsoid
executable_help="ellipsoid - generates an ellipsoid
  usage: ellipsoid [options] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message
    -r [number], --radius [number]: radius on all axes (millimeters) (default: 1.000000)
    -d [number], --diameter [number]: radius on all axes (millimeters) (default: 0.000000)
    -c, --center: center on all axes
    -rx [number], --radius-x [number]: radius on x axis (millimeters) (default: 0.000000)
    -dx [number], --diameter-x [number]: diameter on x axis (millimeters) (default: 0.000000)
    -cx, --center-x: center on x axis (millimeters)
    -ry [number], --radius-y [number]: radius on y axis (millimeters) (default: 0.000000)
    -dy [number], --diameter-y [number]: diameter on y axis (millimeters) (default: 0.000000)
    -cy, --center-y: center on y axis (millimeters)
    -rz [number], --radius-z [number]: radius on z axis (millimeters) (default: 0.000000)
    -dz [number], --diameter-z [number]: diameter on z axis (millimeters) (default: 0.000000)
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
  check_successful "bin/ellipsoid < test/sdf/empty.sdf | bin/sample" "inf"
}

@test "non-empty stdin" {
  check_failure "bin/ellipsoid < test/sdf/parameter_x.sdf" "unexpected stdin"
}
