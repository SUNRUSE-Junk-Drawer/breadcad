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
  check_successful "bin/cuboid < test/sdf/empty.sdf | bin/sample" "0.000000"
}

@test "non-empty stdin" {
  check_failure "bin/cuboid < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "parameter size" {
  number_parameter "cuboid" "s" "size"
}

@test "parameter size x" {
  number_parameter "cuboid" "sx" "size-x"
}

@test "parameter size y" {
  number_parameter "cuboid" "sy" "size-y"
}

@test "parameter size z" {
  number_parameter "cuboid" "sz" "size-z"
}

@test "distances" {
  check_successful "bin/cuboid | bin/sample -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid | bin/sample -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid | bin/sample -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid | bin/sample -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-x | bin/sample -x -0.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-x | bin/sample -x -0.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-y | bin/sample -x 0.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-y | bin/sample -x 0.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-z | bin/sample -x 0.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-z | bin/sample -x 0.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-x --center-y | bin/sample -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-x --center-y | bin/sample -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-x --center-y | bin/sample -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-x --center-y | bin/sample -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-y --center-z | bin/sample -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-y --center-z | bin/sample -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-y --center-z | bin/sample -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-y --center-z | bin/sample -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-x --center-z | bin/sample -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-x --center-z | bin/sample -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center-x --center-z | bin/sample -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center-x --center-z | bin/sample -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 | bin/sample -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 | bin/sample -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 | bin/sample -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 | bin/sample -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 | bin/sample -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 | bin/sample -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-x | bin/sample -x -1.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-x | bin/sample -x -1.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-y | bin/sample -x 1.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-y | bin/sample -x 1.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-z | bin/sample -x 1.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-z | bin/sample -x 1.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-x --center-y | bin/sample -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-y | bin/sample -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-x --center-y | bin/sample -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-y | bin/sample -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-x --center-z | bin/sample -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-z | bin/sample -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center-x --center-z | bin/sample -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center-x --center-z | bin/sample -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 | bin/sample -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 | bin/sample -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 | bin/sample -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 | bin/sample -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 | bin/sample -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 | bin/sample -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-x | bin/sample -x -0.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-x | bin/sample -x -0.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-y | bin/sample -x 0.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-y | bin/sample -x 0.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-z | bin/sample -x 0.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-z | bin/sample -x 0.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-x --center-y | bin/sample -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-y | bin/sample -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-x --center-y | bin/sample -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-y | bin/sample -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-y --center-z | bin/sample -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-y --center-z | bin/sample -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-y --center-z | bin/sample -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-y --center-z | bin/sample -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-x --center-z | bin/sample -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-z | bin/sample -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center-x --center-z | bin/sample -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center-x --center-z | bin/sample -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 | bin/sample -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 | bin/sample -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 | bin/sample -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 | bin/sample -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-x | bin/sample -x -0.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-x | bin/sample -x -0.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-y | bin/sample -x 0.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-y | bin/sample -x 0.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-z | bin/sample -x 0.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-z | bin/sample -x 0.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-x --center-y | bin/sample -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-y | bin/sample -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-x --center-y | bin/sample -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-y | bin/sample -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-x --center-z | bin/sample -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-z | bin/sample -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center-x --center-z | bin/sample -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center-x --center-z | bin/sample -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-z 5 --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-z 5 --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 | bin/sample -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 | bin/sample -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 | bin/sample -x 1.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 | bin/sample -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 | bin/sample -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 | bin/sample -x 1.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x | bin/sample -x -1.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x | bin/sample -x -1.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x | bin/sample -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y | bin/sample -x 1.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y | bin/sample -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y | bin/sample -x 1.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-z | bin/sample -x 1.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-z | bin/sample -x 1.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-y | bin/sample -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-y | bin/sample -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-y | bin/sample -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-y | bin/sample -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y --center-z | bin/sample -x 1.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y --center-z | bin/sample -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y --center-z | bin/sample -x 1.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-y --center-z | bin/sample -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-z | bin/sample -x -1.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-z | bin/sample -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-z | bin/sample -x -1.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center-x --center-z | bin/sample -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-y 4 --center | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 | bin/sample -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 | bin/sample -x 1.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 | bin/sample -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 | bin/sample -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 | bin/sample -x 1.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 | bin/sample -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x | bin/sample -x -1.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x | bin/sample -x -1.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x | bin/sample -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y | bin/sample -x 1.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y | bin/sample -x 1.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-z | bin/sample -x 1.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-z | bin/sample -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-z | bin/sample -x 1.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-y | bin/sample -x -1.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-y | bin/sample -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-y | bin/sample -x -1.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-y | bin/sample -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y --center-z | bin/sample -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y --center-z | bin/sample -x 1.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y --center-z | bin/sample -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-y --center-z | bin/sample -x 1.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-z | bin/sample -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-z | bin/sample -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-z | bin/sample -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center-x --center-z | bin/sample -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center | bin/sample -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-x 3 --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 | bin/sample -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 | bin/sample -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 | bin/sample -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 | bin/sample -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 | bin/sample -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 | bin/sample -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x | bin/sample -x -0.500000 -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x | bin/sample -x -0.500000 -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y | bin/sample -x 0.500000 -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y | bin/sample -x 0.500000 -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y | bin/sample -x 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-z | bin/sample -x 0.500000 -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-z | bin/sample -x 0.500000 -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-y | bin/sample -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-y | bin/sample -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-y | bin/sample -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-y | bin/sample -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-y --center-z | bin/sample -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-z | bin/sample -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-z | bin/sample -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-z | bin/sample -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center-x --center-z | bin/sample -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center | bin/sample -x -0.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size-y 4 --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 | bin/sample -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 | bin/sample -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 | bin/sample -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 | bin/sample -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 | bin/sample -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 | bin/sample -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-x | bin/sample -x -1.000000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-x | bin/sample -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-x | bin/sample -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-x | bin/sample -x -1.000000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-x | bin/sample -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-x | bin/sample -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-y | bin/sample -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-y | bin/sample -x 1.000000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-y | bin/sample -x 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-y | bin/sample -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-y | bin/sample -x 1.000000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-y | bin/sample -x 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-z | bin/sample -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-z | bin/sample -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-z | bin/sample -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-z | bin/sample -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-x --center-y | bin/sample -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-y | bin/sample -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-x --center-y | bin/sample -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-y | bin/sample -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-y --center-z | bin/sample -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-y --center-z | bin/sample -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-y --center-z | bin/sample -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-y --center-z | bin/sample -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-x --center-z | bin/sample -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-z | bin/sample -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center-x --center-z | bin/sample -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center-x --center-z | bin/sample -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center | bin/sample -x -1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center | bin/sample -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center | bin/sample -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --center | bin/sample -x -1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --center | bin/sample -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --center | bin/sample -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 | bin/sample -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 | bin/sample -x 1.500000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 | bin/sample -x 1.500000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 | bin/sample -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 | bin/sample -x 1.500000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 | bin/sample -x 1.500000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x | bin/sample -x -1.500000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x | bin/sample -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x | bin/sample -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x | bin/sample -x -1.500000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x | bin/sample -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x | bin/sample -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y | bin/sample -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y | bin/sample -x 1.500000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y | bin/sample -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y | bin/sample -x 1.500000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y | bin/sample -x 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-z | bin/sample -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-z | bin/sample -x 1.500000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-z | bin/sample -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-z | bin/sample -x 1.500000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-y | bin/sample -x -1.500000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-y | bin/sample -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-y | bin/sample -x -1.500000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-y | bin/sample -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-y --center-z | bin/sample -x 1.500000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-z | bin/sample -x -1.500000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-z | bin/sample -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-z | bin/sample -x -1.500000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center-x --center-z | bin/sample -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center | bin/sample -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center | bin/sample -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-x 3 --center | bin/sample -x -1.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center | bin/sample -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-x 3 --center | bin/sample -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 | bin/sample -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 | bin/sample -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 | bin/sample -x 1.000000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 | bin/sample -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 | bin/sample -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 | bin/sample -x 1.000000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x | bin/sample -x -1.000000 -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x | bin/sample -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x | bin/sample -x -1.000000 -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x | bin/sample -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x | bin/sample -y 2.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y | bin/sample -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y | bin/sample -x 1.000000 -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y | bin/sample -x 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y | bin/sample -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y | bin/sample -x 1.000000 -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y | bin/sample -x 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-z | bin/sample -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-z | bin/sample -x 1.000000 -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-z | bin/sample -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-z | bin/sample -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-z | bin/sample -x 1.000000 -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-y | bin/sample -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-y | bin/sample -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-y | bin/sample -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-y | bin/sample -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y --center-z | bin/sample -x 1.000000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y --center-z | bin/sample -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y --center-z | bin/sample -x 1.000000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-y --center-z | bin/sample -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-z | bin/sample -x -1.000000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-z | bin/sample -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-z | bin/sample -x -1.000000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center-x --center-z | bin/sample -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center | bin/sample -x -1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center | bin/sample -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-y 4 --center | bin/sample -x -1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center | bin/sample -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-y 4 --center | bin/sample -z -1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 | bin/sample -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 | bin/sample -x 1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 | bin/sample -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 | bin/sample -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 | bin/sample -x 1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 | bin/sample -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x | bin/sample -x -1.000000 -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x | bin/sample -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x | bin/sample -x -1.000000 -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x | bin/sample -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x | bin/sample -y 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y | bin/sample -x 1.000000 -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y | bin/sample -x 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y | bin/sample -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y | bin/sample -x 1.000000 -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y | bin/sample -x 1.000000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-z | bin/sample -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-z | bin/sample -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-z | bin/sample -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-z | bin/sample -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-y | bin/sample -x -1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-y | bin/sample -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-y | bin/sample -x -1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-y | bin/sample -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-y | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y --center-z | bin/sample -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y --center-z | bin/sample -x 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y --center-z | bin/sample" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y --center-z | bin/sample -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-y --center-z | bin/sample -x 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-z | bin/sample -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-z | bin/sample -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-z | bin/sample -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-z | bin/sample" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center-x --center-z | bin/sample -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center | bin/sample -x -1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center | bin/sample -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cuboid --size 2 --size-z 5 --center | bin/sample -x -1.000000" "0.000000" # - 0 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center | bin/sample -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "bin/cuboid --size 2 --size-z 5 --center | bin/sample -z -2.500000" "0.000000" # 0 0 - long
}
