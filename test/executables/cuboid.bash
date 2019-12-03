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
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000"
}

@test "non-empty stdin" {
  check_failure "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} < test/sdf/parameter_x.sdf" "unexpected stdin"
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
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 2.000000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 3 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-y 4 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.500000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-x 3 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 2.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -z 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000 -z 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 2.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 2.000000 -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -2.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-y 4 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -z 2.500000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000 -z 2.500000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-y | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-y --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000 -y 1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center-x --center-z | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y 1.000000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -1.000000" "0.000000" # - 0 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -y -1.000000" "0.000000" # 0 - 0 long
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size 2 --size-z 5 --center | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -z -2.500000" "0.000000" # 0 0 - long
}
