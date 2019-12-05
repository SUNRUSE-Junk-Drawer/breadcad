load "../framework/main"

executable_name=translate
executable_help="translate - translates the geometry described by a sdf stream
  usage: [sdf stream] | translate [options] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message
    -x [number], --x [number]: translation on the x axis (millimeters) (default: 0.000000)
    -y [number], --y [number]: translation on the y axis (millimeters) (default: 0.000000)
    -z [number], --z [number]: translation on the z axis (millimeters) (default: 0.000000)"

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
  check_valid "${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

function test_cuboid {
  parameters=$1

  x_origin=$2
  x_low=$3
  x_high=$4
  y_origin=$5
  y_low=$6
  y_high=$7
  z_origin=$8
  z_low=$9
  z_high=${10}

  check_valid "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_origin -y $y_origin -z $z_origin" "-0.500000"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_low -y $y_origin -z $z_origin" "-0.400000"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_high -y $y_origin -z $z_origin" "-0.400000"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_origin -y $y_low -z $z_origin" "-0.400000"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_origin -y $y_high -z $z_origin" "-0.400000"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_origin -y $y_origin -z $z_low" "-0.400000"
  check_successful "${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} --size-x 2 --size-y 8 --size-z 4 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} $parameters | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x $x_origin -y $y_origin -z $z_high" "-0.400000"
}

@test "default" {
  test_cuboid "" "0.5" "0.4" "1.6" "0.5" "0.4" "7.6" "0.5" "0.4" "3.6"
}

@test "x short" {
  test_cuboid "-x 10" "10.5" "10.4" "11.6" "0.5" "0.4" "7.6" "0.5" "0.4" "3.6"
}

@test "y short" {
  test_cuboid "-y 20" "0.5" "0.4" "1.6" "20.5" "20.4" "27.6" "0.5" "0.4" "3.6"
}

@test "z short" {
  test_cuboid "-z 25" "0.5" "0.4" "1.6" "0.5" "0.4" "7.6" "25.5" "25.4" "28.6"
}

@test "x y short" {
  test_cuboid "-x 10 -y 20" "10.5" "10.4" "11.6" "20.5" "20.4" "27.6" "0.5" "0.4" "3.6"
}

@test "x z short" {
  test_cuboid "-x 10 -z 25" "10.5" "10.4" "11.6" "0.5" "0.4" "7.6" "25.5" "25.4" "28.6"
}

@test "y z short" {
  test_cuboid "-y 20 -z 25" "0.5" "0.4" "1.6" "20.5" "20.4" "27.6" "25.5" "25.4" "28.6"
}

@test "x long" {
  test_cuboid "--x 10" "10.5" "10.4" "11.6" "0.5" "0.4" "7.6" "0.5" "0.4" "3.6"
}

@test "y long" {
  test_cuboid "--y 20" "0.5" "0.4" "1.6" "20.5" "20.4" "27.6" "0.5" "0.4" "3.6"
}

@test "z long" {
  test_cuboid "--z 25" "0.5" "0.4" "1.6" "0.5" "0.4" "7.6" "25.5" "25.4" "28.6"
}

@test "x y long" {
  test_cuboid "--x 10 --y 20" "10.5" "10.4" "11.6" "20.5" "20.4" "27.6" "0.5" "0.4" "3.6"
}

@test "x z long" {
  test_cuboid "--x 10 --z 25" "10.5" "10.4" "11.6" "0.5" "0.4" "7.6" "25.5" "25.4" "28.6"
}

@test "y z long" {
  test_cuboid "--y 20 --z 25" "0.5" "0.4" "1.6" "20.5" "20.4" "27.6" "25.5" "25.4" "28.6"
}

@test "x validation" {
  number_parameter "translate" "x" "x"
}

@test "y validation" {
  number_parameter "translate" "y" "y"
}

@test "z validation" {
  number_parameter "translate" "z" "z"
}
