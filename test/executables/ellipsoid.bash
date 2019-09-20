load "../framework/main"

executable_name=ellipsoid
executable_help="ellipsoid - generates an ellipsoid$LINE_BREAK
  usage: ellipsoid [options] | [consumer of sdf stream]$LINE_BREAK
  options:$LINE_BREAK
    -h, --help, /?: display this message$LINE_BREAK
    -r [number], --radius [number]: radius on all axes (millimeters) (default: 1.000000)$LINE_BREAK
    -d [number], --diameter [number]: radius on all axes (millimeters) (default: 0.000000)$LINE_BREAK
    -c, --center: center on all axes$LINE_BREAK
    -rx [number], --radius-x [number]: radius on x axis (millimeters) (default: 0.000000)$LINE_BREAK
    -dx [number], --diameter-x [number]: diameter on x axis (millimeters) (default: 0.000000)$LINE_BREAK
    -cx, --center-x: center on x axis (millimeters)$LINE_BREAK
    -ry [number], --radius-y [number]: radius on y axis (millimeters) (default: 0.000000)$LINE_BREAK
    -dy [number], --diameter-y [number]: diameter on y axis (millimeters) (default: 0.000000)$LINE_BREAK
    -cy, --center-y: center on y axis (millimeters)$LINE_BREAK
    -rz [number], --radius-z [number]: radius on z axis (millimeters) (default: 0.000000)$LINE_BREAK
    -dz [number], --diameter-z [number]: diameter on z axis (millimeters) (default: 0.000000)$LINE_BREAK
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
