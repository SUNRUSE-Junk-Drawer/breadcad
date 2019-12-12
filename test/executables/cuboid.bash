load "../framework/main"

executable_name=cuboid
executable_help="cuboid - generates a cuboid
  usage: cuboid [options] | [consumer of bc stream]
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
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "0.000000"
}

@test "non-empty stdin" {
  check_failure "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_x.bc" "unexpected stdin"
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

@test "default parameters valid" {
  check_valid "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX}"
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

  check_valid "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $x_low -y $y_origin -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $x_high -y $y_origin -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $x_origin -y $y_low -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $x_origin -y $y_high -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $x_origin -y $y_origin -z $z_low" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $x_origin -y $y_origin -z $z_high" "0.000000"
}

@test "face centers on surface" {
  test_cuboid "--size-x 7 --center-y --size-y 3 --size-z 4" "3.5" "0" "7" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "face centers above surface" {
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -1.6 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z 4.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.6 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -z 2" "0.100000"
}

@test "face centers below surface" {
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z 0.1" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -1.4 -z 2" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -z 2" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z 3.9" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.4 -z 2" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.9 -z 2" "-0.100000"
}

@test "faces near edges" {
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 1.5 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 1.5 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y -1.6 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7 -y -1.6 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y 1.6 -z 2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7 -y 1.6 -z 2" "0.100000"

  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -z 4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -z 4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -z 4.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7 -z 4.1" "0.100000"

  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -1.6 -z 4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.6 -z 4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z 4.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.5 -z 4.1" "0.100000"
}

@test "edges" {
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y -1.6 -z 2" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 1.6 -z 2" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y -1.6 -z 2" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 1.6 -z 2" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -z -0.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -z 4.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -z -0.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -z 4.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -1.6 -z -0.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -1.6 -z 4.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.6 -z -0.1" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 1.6 -z 4.1" "0.141421"
}

@test "corners" {
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y -1.6 -z -0.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y -1.6 -z -0.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 1.6 -z -0.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 1.6 -z -0.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y -1.6 -z 4.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y -1.6 -z 4.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 1.6 -z 4.1" "0.173205"
  check_successful "${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} --size-x 7 --center-y --size-y 3 --size-z 4 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 1.6 -z 4.1" "0.173205"
}

@test "no parameters" {
  test_cuboid "" "0.5" "0" "1" "0.5" "0" "1" "0.5" "0" "1"
}

@test "short center x" {
  test_cuboid "-cx" "0" "-0.5" "0.5" "0.5" "0" "1" "0.5" "0" "1"
}

@test "long center x" {
  test_cuboid "--center-x" "0" "-0.5" "0.5" "0.5" "0" "1" "0.5" "0" "1"
}

@test "short center y" {
  test_cuboid "-cy" "0.5" "0" "1" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "long center y" {
  test_cuboid "--center-y" "0.5" "0" "1" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "short center z" {
  test_cuboid "-cz" "0.5" "0" "1" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "long center z" {
  test_cuboid "--center-z" "0.5" "0" "1" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "short center x y" {
  test_cuboid "-cx -cy" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "long center x y" {
  test_cuboid "--center-x --center-y" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "short center x z" {
  test_cuboid "-cx -cz" "0" "-0.5" "0.5" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "long center x z" {
  test_cuboid "--center-x --center-z" "0" "-0.5" "0.5" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "short center y z" {
  test_cuboid "-cy -cz" "0.5" "0" "1" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "long center y z" {
  test_cuboid "--center-y --center-z" "0.5" "0" "1" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "short center" {
  test_cuboid "-c" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "long center" {
  test_cuboid "--center" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "short size x" {
  test_cuboid "-sx 7" "3.5" "0" "7" "0.5" "0" "1" "0.5" "0" "1"
}

@test "long size x" {
  test_cuboid "--size-x 7" "3.5" "0" "7" "0.5" "0" "1" "0.5" "0" "1"
}

@test "short size x center x" {
  test_cuboid "-sx 7 -cx" "0" "-3.5" "3.5" "0.5" "0" "1" "0.5" "0" "1"
}

@test "long size x center x" {
  test_cuboid "--size-x 7 --center-x" "0" "-3.5" "3.5" "0.5" "0" "1" "0.5" "0" "1"
}

@test "short size x center y" {
  test_cuboid "-sx 7 -cy" "3.5" "0" "7" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "long size x center y" {
  test_cuboid "--size-x 7 --center-y" "3.5" "0" "7" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "short size x center z" {
  test_cuboid "-sx 7 -cz" "3.5" "0" "7" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "long size x center z" {
  test_cuboid "--size-x 7 --center-z" "3.5" "0" "7" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "short size x center x y" {
  test_cuboid "-sx 7 -cx -cy" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "long size x center x y" {
  test_cuboid "--size-x 7 --center-x --center-y" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "0.5" "0" "1"
}

@test "short size x center x z" {
  test_cuboid "-sx 7 -cx -cz" "0" "-3.5" "3.5" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "long size x center x z" {
  test_cuboid "--size-x 7 --center-x --center-z" "0" "-3.5" "3.5" "0.5" "0" "1" "0" "-0.5" "0.5"
}

@test "short size x center y z" {
  test_cuboid "-sx 7 -cy -cz" "3.5" "0" "7" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "long size x center y z" {
  test_cuboid "--size-x 7 --center-y --center-z" "3.5" "0" "7" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "short size x center" {
  test_cuboid "-sx 7 -c" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "long size x center" {
  test_cuboid "--size-x 7 --center" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "0" "-0.5" "0.5"
}

@test "short size y" {
  test_cuboid "-sy 3" "0.5" "0" "1" "1.5" "0" "3" "0.5" "0" "1"
}

@test "long size y" {
  test_cuboid "--size-y 3" "0.5" "0" "1" "1.5" "0" "3" "0.5" "0" "1"
}

@test "short size y center x" {
  test_cuboid "-sy 3 -cx" "0" "-0.5" "0.5" "1.5" "0" "3" "0.5" "0" "1"
}

@test "long size y center x" {
  test_cuboid "--size-y 3 --center-x" "0" "-0.5" "0.5" "1.5" "0" "3" "0.5" "0" "1"
}

@test "short size y center y" {
  test_cuboid "-sy 3 -cy" "0.5" "0" "1" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "long size y center y" {
  test_cuboid "--size-y 3 --center-y" "0.5" "0" "1" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "short size y center z" {
  test_cuboid "-sy 3 -cz" "0.5" "0" "1" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "long size y center z" {
  test_cuboid "--size-y 3 --center-z" "0.5" "0" "1" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "short size y center x y" {
  test_cuboid "-sy 3 -cx -cy" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "long size y center x y" {
  test_cuboid "--size-y 3 --center-x --center-y" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "short size y center x z" {
  test_cuboid "-sy 3 -cx -cz" "0" "-0.5" "0.5" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "long size y center x z" {
  test_cuboid "--size-y 3 --center-x --center-z" "0" "-0.5" "0.5" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "short size y center y z" {
  test_cuboid "-sy 3 -cy -cz" "0.5" "0" "1" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "long size y center y z" {
  test_cuboid "--size-y 3 --center-y --center-z" "0.5" "0" "1" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "short size y center" {
  test_cuboid "-sy 3 -c" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "long size y center" {
  test_cuboid "--size-y 3 --center" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "short size z" {
  test_cuboid "-sz 4" "0.5" "0" "1" "0.5" "0" "1" "2" "0" "4"
}

@test "long size z" {
  test_cuboid "--size-z 4" "0.5" "0" "1" "0.5" "0" "1" "2" "0" "4"
}

@test "short size z center x" {
  test_cuboid "-sz 4 -cx" "0" "-0.5" "0.5" "0.5" "0" "1" "2" "0" "4"
}

@test "long size z center x" {
  test_cuboid "--size-z 4 --center-x" "0" "-0.5" "0.5" "0.5" "0" "1" "2" "0" "4"
}

@test "short size z center y" {
  test_cuboid "-sz 4 -cy" "0.5" "0" "1" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "long size z center y" {
  test_cuboid "--size-z 4 --center-y" "0.5" "0" "1" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "short size z center z" {
  test_cuboid "-sz 4 -cz" "0.5" "0" "1" "0.5" "0" "1" "0" "-2" "2"
}

@test "long size z center z" {
  test_cuboid "--size-z 4 --center-z" "0.5" "0" "1" "0.5" "0" "1" "0" "-2" "2"
}

@test "short size z center x y" {
  test_cuboid "-sz 4 -cx -cy" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "long size z center x y" {
  test_cuboid "--size-z 4 --center-x --center-y" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "short size z center x z" {
  test_cuboid "-sz 4 -cx -cz" "0" "-0.5" "0.5" "0.5" "0" "1" "0" "-2" "2"
}

@test "long size z center x z" {
  test_cuboid "--size-z 4 --center-x --center-z" "0" "-0.5" "0.5" "0.5" "0" "1" "0" "-2" "2"
}

@test "short size z center y z" {
  test_cuboid "-sz 4 -cy -cz" "0.5" "0" "1" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "long size z center y z" {
  test_cuboid "--size-z 4 --center-y --center-z" "0.5" "0" "1" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "short size z center" {
  test_cuboid "-sz 4 -c" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "long size z center" {
  test_cuboid "--size-z 4 --center" "0" "-0.5" "0.5" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "short size x y" {
  test_cuboid "-sx 7 -sy 3" "3.5" "0" "7" "1.5" "0" "3" "0.5" "0" "1"
}

@test "long size x y" {
  test_cuboid "--size-x 7 --size-y 3" "3.5" "0" "7" "1.5" "0" "3" "0.5" "0" "1"
}

@test "short size x y center x" {
  test_cuboid "-sx 7 -sy 3 -cx" "0" "-3.5" "3.5" "1.5" "0" "3" "0.5" "0" "1"
}

@test "long size x y center x" {
  test_cuboid "--size-x 7 --size-y 3 --center-x" "0" "-3.5" "3.5" "1.5" "0" "3" "0.5" "0" "1"
}

@test "short size x y center y" {
  test_cuboid "-sx 7 -sy 3 -cy" "3.5" "0" "7" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "long size x y center y" {
  test_cuboid "--size-x 7 --size-y 3 --center-y" "3.5" "0" "7" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "short size x y center z" {
  test_cuboid "-sx 7 -sy 3 -cz" "3.5" "0" "7" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "long size x y center z" {
  test_cuboid "--size-x 7 --size-y 3 --center-z" "3.5" "0" "7" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "short size x y center x y" {
  test_cuboid "-sx 7 -sy 3 -cx -cy" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "long size x y center x y" {
  test_cuboid "--size-x 7 --size-y 3 --center-x --center-y" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "0.5" "0" "1"
}

@test "short size x y center x z" {
  test_cuboid "-sx 7 -sy 3 -cx -cz" "0" "-3.5" "3.5" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "long size x y center x z" {
  test_cuboid "--size-x 7 --size-y 3 --center-x --center-z" "0" "-3.5" "3.5" "1.5" "0" "3" "0" "-0.5" "0.5"
}

@test "short size x y center y z" {
  test_cuboid "-sx 7 -sy 3 -cy -cz" "3.5" "0" "7" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "long size x y center y z" {
  test_cuboid "--size-x 7 --size-y 3 --center-y --center-z" "3.5" "0" "7" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "short size x y center" {
  test_cuboid "-sx 7 -sy 3 -c" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "long size x y center" {
  test_cuboid "--size-x 7 --size-y 3 --center" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "0" "-0.5" "0.5"
}

@test "short size x z" {
  test_cuboid "-sx 7 -sz 4" "3.5" "0" "7" "0.5" "0" "1" "2" "0" "4"
}

@test "long size x z" {
  test_cuboid "--size-x 7 --size-z 4" "3.5" "0" "7" "0.5" "0" "1" "2" "0" "4"
}

@test "short size x z center x" {
  test_cuboid "-sx 7 -sz 4 -cx" "0" "-3.5" "3.5" "0.5" "0" "1" "2" "0" "4"
}

@test "long size x z center x" {
  test_cuboid "--size-x 7 --size-z 4 --center-x" "0" "-3.5" "3.5" "0.5" "0" "1" "2" "0" "4"
}

@test "short size x z center y" {
  test_cuboid "-sx 7 -sz 4 -cy" "3.5" "0" "7" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "long size x z center y" {
  test_cuboid "--size-x 7 --size-z 4 --center-y" "3.5" "0" "7" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "short size x z center z" {
  test_cuboid "-sx 7 -sz 4 -cz" "3.5" "0" "7" "0.5" "0" "1" "0" "-2" "2"
}

@test "long size x z center z" {
  test_cuboid "--size-x 7 --size-z 4 --center-z" "3.5" "0" "7" "0.5" "0" "1" "0" "-2" "2"
}

@test "short size x z center x y" {
  test_cuboid "-sx 7 -sz 4 -cx -cy" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "long size x z center x y" {
  test_cuboid "--size-x 7 --size-z 4 --center-x --center-y" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "2" "0" "4"
}

@test "short size x z center x z" {
  test_cuboid "-sx 7 -sz 4 -cx -cz" "0" "-3.5" "3.5" "0.5" "0" "1" "0" "-2" "2"
}

@test "long size x z center x z" {
  test_cuboid "--size-x 7 --size-z 4 --center-x --center-z" "0" "-3.5" "3.5" "0.5" "0" "1" "0" "-2" "2"
}

@test "short size x z center y z" {
  test_cuboid "-sx 7 -sz 4 -cy -cz" "3.5" "0" "7" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "long size x z center y z" {
  test_cuboid "--size-x 7 --size-z 4 --center-y --center-z" "3.5" "0" "7" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "short size x z center" {
  test_cuboid "-sx 7 -sz 4 -c" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "long size x z center" {
  test_cuboid "--size-x 7 --size-z 4 --center" "0" "-3.5" "3.5" "0" "-0.5" "0.5" "0" "-2" "2"
}

@test "short size y z" {
  test_cuboid "-sy 3 -sz 4" "0.5" "0" "1" "1.5" "0" "3" "2" "0" "4"
}

@test "long size y z" {
  test_cuboid "--size-y 3 --size-z 4" "0.5" "0" "1" "1.5" "0" "3" "2" "0" "4"
}

@test "short size y z center x" {
  test_cuboid "-sy 3 -sz 4 -cx" "0" "-0.5" "0.5" "1.5" "0" "3" "2" "0" "4"
}

@test "long size y z center x" {
  test_cuboid "--size-y 3 --size-z 4 --center-x" "0" "-0.5" "0.5" "1.5" "0" "3" "2" "0" "4"
}

@test "short size y z center y" {
  test_cuboid "-sy 3 -sz 4 -cy" "0.5" "0" "1" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "long size y z center y" {
  test_cuboid "--size-y 3 --size-z 4 --center-y" "0.5" "0" "1" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "short size y z center z" {
  test_cuboid "-sy 3 -sz 4 -cz" "0.5" "0" "1" "1.5" "0" "3" "0" "-2" "2"
}

@test "long size y z center z" {
  test_cuboid "--size-y 3 --size-z 4 --center-z" "0.5" "0" "1" "1.5" "0" "3" "0" "-2" "2"
}

@test "short size y z center x y" {
  test_cuboid "-sy 3 -sz 4 -cx -cy" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "long size y z center x y" {
  test_cuboid "--size-y 3 --size-z 4 --center-x --center-y" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "short size y z center x z" {
  test_cuboid "-sy 3 -sz 4 -cx -cz" "0" "-0.5" "0.5" "1.5" "0" "3" "0" "-2" "2"
}

@test "long size y z center x z" {
  test_cuboid "--size-y 3 --size-z 4 --center-x --center-z" "0" "-0.5" "0.5" "1.5" "0" "3" "0" "-2" "2"
}

@test "short size y z center y z" {
  test_cuboid "-sy 3 -sz 4 -cy -cz" "0.5" "0" "1" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "long size y z center y z" {
  test_cuboid "--size-y 3 --size-z 4 --center-y --center-z" "0.5" "0" "1" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "short size y z center" {
  test_cuboid "-sy 3 -sz 4 -c" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "long size y z center" {
  test_cuboid "--size-y 3 --size-z 4 --center" "0" "-0.5" "0.5" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "short size all" {
  test_cuboid "-s 9" "4.5" "0" "9" "4.5" "0" "9" "4.5" "0" "9"
}

@test "long size all" {
  test_cuboid "--size 9" "4.5" "0" "9" "4.5" "0" "9" "4.5" "0" "9"
}

@test "short size all center x" {
  test_cuboid "-s 9 -cx" "0" "-4.5" "4.5" "4.5" "0" "9" "4.5" "0" "9"
}

@test "long size all center x" {
  test_cuboid "--size 9 --center-x" "0" "-4.5" "4.5" "4.5" "0" "9" "4.5" "0" "9"
}

@test "short size all center y" {
  test_cuboid "-s 9 -cy" "4.5" "0" "9" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "long size all center y" {
  test_cuboid "--size 9 --center-y" "4.5" "0" "9" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "short size all center z" {
  test_cuboid "-s 9 -cz" "4.5" "0" "9" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "long size all center z" {
  test_cuboid "--size 9 --center-z" "4.5" "0" "9" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "short size all center x y" {
  test_cuboid "-s 9 -cx -cy" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "long size all center x y" {
  test_cuboid "--size 9 --center-x --center-y" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "short size all center x z" {
  test_cuboid "-s 9 -cx -cz" "0" "-4.5" "4.5" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "long size all center x z" {
  test_cuboid "--size 9 --center-x --center-z" "0" "-4.5" "4.5" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "short size all center y z" {
  test_cuboid "-s 9 -cy -cz" "4.5" "0" "9" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "long size all center y z" {
  test_cuboid "--size 9 --center-y --center-z" "4.5" "0" "9" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "short size all center" {
  test_cuboid "-s 9 -c" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "long size all center" {
  test_cuboid "--size 9 --center" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "short size all x" {
  test_cuboid "-s 9  -sx 7" "3.5" "0" "7" "4.5" "0" "9" "4.5" "0" "9"
}

@test "long size all x" {
  test_cuboid "--size 9 --size-x 7" "3.5" "0" "7" "4.5" "0" "9" "4.5" "0" "9"
}

@test "short size all x center x" {
  test_cuboid "-s 9 -sx 7 -cx" "0" "-3.5" "3.5" "4.5" "0" "9" "4.5" "0" "9"
}

@test "long size all x center x" {
  test_cuboid "--size 9 --size-x 7 --center-x" "0" "-3.5" "3.5" "4.5" "0" "9" "4.5" "0" "9"
}

@test "short size all x center y" {
  test_cuboid "-s 9 -sx 7 -cy" "3.5" "0" "7" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "long size all x center y" {
  test_cuboid "--size 9 --size-x 7 --center-y" "3.5" "0" "7" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "short size all x center z" {
  test_cuboid "-s 9 -sx 7 -cz" "3.5" "0" "7" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "long size all x center z" {
  test_cuboid "--size 9 --size-x 7 --center-z" "3.5" "0" "7" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "short size all x center x y" {
  test_cuboid "-s 9 -sx 7 -cx -cy" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "long size all x center x y" {
  test_cuboid "--size 9 --size-x 7 --center-x --center-y" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "4.5" "0" "9"
}

@test "short size all x center x z" {
  test_cuboid "-s 9 -sx 7 -cx -cz" "0" "-3.5" "3.5" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "long size all x center x z" {
  test_cuboid "--size 9 --size-x 7 --center-x --center-z" "0" "-3.5" "3.5" "4.5" "0" "9" "0" "-4.5" "4.5"
}

@test "short size all x center y z" {
  test_cuboid "-s 9 -sx 7 -cy -cz" "3.5" "0" "7" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "long size all x center y z" {
  test_cuboid "--size 9 --size-x 7 --center-y --center-z" "3.5" "0" "7" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "short size all x center" {
  test_cuboid "-s 9 -sx 7 -c" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "long size all x center" {
  test_cuboid "--size 9 --size-x 7 --center" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "0" "-4.5" "4.5"
}

@test "short size all y" {
  test_cuboid "-s 9 -sy 3" "4.5" "0" "9" "1.5" "0" "3" "4.5" "0" "9"
}

@test "long size all y" {
  test_cuboid "--size 9 --size-y 3" "4.5" "0" "9" "1.5" "0" "3" "4.5" "0" "9"
}

@test "short size all y center x" {
  test_cuboid "-s 9 -sy 3 -cx" "0" "-4.5" "4.5" "1.5" "0" "3" "4.5" "0" "9"
}

@test "long size all y center x" {
  test_cuboid "--size 9 --size-y 3 --center-x" "0" "-4.5" "4.5" "1.5" "0" "3" "4.5" "0" "9"
}

@test "short size all y center y" {
  test_cuboid "-s 9 -sy 3 -cy" "4.5" "0" "9" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "long size all y center y" {
  test_cuboid "--size 9 --size-y 3 --center-y" "4.5" "0" "9" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "short size all y center z" {
  test_cuboid "-s 9 -sy 3 -cz" "4.5" "0" "9" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "long size all y center z" {
  test_cuboid "--size 9 --size-y 3 --center-z" "4.5" "0" "9" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "short size all y center x y" {
  test_cuboid "-s 9 -sy 3 -cx -cy" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "long size all y center x y" {
  test_cuboid "--size 9 --size-y 3 --center-x --center-y" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "short size all y center x z" {
  test_cuboid "-s 9 -sy 3 -cx -cz" "0" "-4.5" "4.5" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "long size all y center x z" {
  test_cuboid "--size 9 --size-y 3 --center-x --center-z" "0" "-4.5" "4.5" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "short size all y center y z" {
  test_cuboid "-s 9 -sy 3 -cy -cz" "4.5" "0" "9" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "long size all y center y z" {
  test_cuboid "--size 9 --size-y 3 --center-y --center-z" "4.5" "0" "9" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "short size all y center" {
  test_cuboid "-s 9 -sy 3 -c" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "long size all y center" {
  test_cuboid "--size 9 --size-y 3 --center" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "short size all z" {
  test_cuboid "-s 9 -sz 4" "4.5" "0" "9" "4.5" "0" "9" "2" "0" "4"
}

@test "long size all z" {
  test_cuboid "--size 9 --size-z 4" "4.5" "0" "9" "4.5" "0" "9" "2" "0" "4"
}

@test "short size all z center x" {
  test_cuboid "-s 9 -sz 4 -cx" "0" "-4.5" "4.5" "4.5" "0" "9" "2" "0" "4"
}

@test "long size all z center x" {
  test_cuboid "--size 9 --size-z 4 --center-x" "0" "-4.5" "4.5" "4.5" "0" "9" "2" "0" "4"
}

@test "short size all z center y" {
  test_cuboid "-s 9 -sz 4 -cy" "4.5" "0" "9" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "long size all z center y" {
  test_cuboid "--size 9 --size-z 4 --center-y" "4.5" "0" "9" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "short size all z center z" {
  test_cuboid "-s 9 -sz 4 -cz" "4.5" "0" "9" "4.5" "0" "9" "0" "-2" "2"
}

@test "long size all z center z" {
  test_cuboid "--size 9 --size-z 4 --center-z" "4.5" "0" "9" "4.5" "0" "9" "0" "-2" "2"
}

@test "short size all z center x y" {
  test_cuboid "-s 9 -sz 4 -cx -cy" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "long size all z center x y" {
  test_cuboid "--size 9 --size-z 4 --center-x --center-y" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "short size all z center x z" {
  test_cuboid "-s 9 -sz 4 -cx -cz" "0" "-4.5" "4.5" "4.5" "0" "9" "0" "-2" "2"
}

@test "long size all z center x z" {
  test_cuboid "--size 9 --size-z 4 --center-x --center-z" "0" "-4.5" "4.5" "4.5" "0" "9" "0" "-2" "2"
}

@test "short size all z center y z" {
  test_cuboid "-s 9 -sz 4 -cy -cz" "4.5" "0" "9" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "long size all z center y z" {
  test_cuboid "--size 9 --size-z 4 --center-y --center-z" "4.5" "0" "9" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "short size all z center" {
  test_cuboid "-s 9 -sz 4 -c" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "long size all z center" {
  test_cuboid "--size 9 --size-z 4 --center" "0" "-4.5" "4.5" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "short size all x y" {
  test_cuboid "-s 9 -sx 7 -sy 3" "3.5" "0" "7" "1.5" "0" "3" "4.5" "0" "9"
}

@test "long size all x y" {
  test_cuboid "--size 9 --size-x 7 --size-y 3" "3.5" "0" "7" "1.5" "0" "3" "4.5" "0" "9"
}

@test "short size all x y center x" {
  test_cuboid "-s 9 -sx 7 -sy 3 -cx" "0" "-3.5" "3.5" "1.5" "0" "3" "4.5" "0" "9"
}

@test "long size all x y center x" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center-x" "0" "-3.5" "3.5" "1.5" "0" "3" "4.5" "0" "9"
}

@test "short size all x y center y" {
  test_cuboid "-s 9 -sx 7 -sy 3 -cy" "3.5" "0" "7" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "long size all x y center y" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center-y" "3.5" "0" "7" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "short size all x y center z" {
  test_cuboid "-s 9 -sx 7 -sy 3 -cz" "3.5" "0" "7" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "long size all x y center z" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center-z" "3.5" "0" "7" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "short size all x y center x y" {
  test_cuboid "-s 9 -sx 7 -sy 3 -cx -cy" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "long size all x y center x y" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center-x --center-y" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "4.5" "0" "9"
}

@test "short size all x y center x z" {
  test_cuboid "-s 9 -sx 7 -sy 3 -cx -cz" "0" "-3.5" "3.5" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "long size all x y center x z" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center-x --center-z" "0" "-3.5" "3.5" "1.5" "0" "3" "0" "-4.5" "4.5"
}

@test "short size all x y center y z" {
  test_cuboid "-s 9 -sx 7 -sy 3 -cy -cz" "3.5" "0" "7" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "long size all x y center y z" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center-y --center-z" "3.5" "0" "7" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "short size all x y center" {
  test_cuboid "-s 9 -sx 7 -sy 3 -c" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "long size all x y center" {
  test_cuboid "--size 9 --size-x 7 --size-y 3 --center" "0" "-3.5" "3.5" "0" "-1.5" "1.5" "0" "-4.5" "4.5"
}

@test "short size all x z" {
  test_cuboid "-s 9 -sx 7 -sz 4" "3.5" "0" "7" "4.5" "0" "9" "2" "0" "4"
}

@test "long size all x z" {
  test_cuboid "--size 9 --size-x 7 --size-z 4" "3.5" "0" "7" "4.5" "0" "9" "2" "0" "4"
}

@test "short size all x z center x" {
  test_cuboid "-s 9 -sx 7 -sz 4 -cx" "0" "-3.5" "3.5" "4.5" "0" "9" "2" "0" "4"
}

@test "long size all x z center x" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center-x" "0" "-3.5" "3.5" "4.5" "0" "9" "2" "0" "4"
}

@test "short size all x z center y" {
  test_cuboid "-s 9 -sx 7 -sz 4 -cy" "3.5" "0" "7" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "long size all x z center y" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center-y" "3.5" "0" "7" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "short size all x z center z" {
  test_cuboid "-s 9 -sx 7 -sz 4 -cz" "3.5" "0" "7" "4.5" "0" "9" "0" "-2" "2"
}

@test "long size all x z center z" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center-z" "3.5" "0" "7" "4.5" "0" "9" "0" "-2" "2"
}

@test "short size all x z center x y" {
  test_cuboid "-s 9 -sx 7 -sz 4 -cx -cy" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "long size all x z center x y" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center-x --center-y" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "2" "0" "4"
}

@test "short size all x z center x z" {
  test_cuboid "-s 9 -sx 7 -sz 4 -cx -cz" "0" "-3.5" "3.5" "4.5" "0" "9" "0" "-2" "2"
}

@test "long size all x z center x z" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center-x --center-z" "0" "-3.5" "3.5" "4.5" "0" "9" "0" "-2" "2"
}

@test "short size all x z center y z" {
  test_cuboid "-s 9 -sx 7 -sz 4 -cy -cz" "3.5" "0" "7" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "long size all x z center y z" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center-y --center-z" "3.5" "0" "7" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "short size all x z center" {
  test_cuboid "-s 9 -sx 7 -sz 4 -c" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "long size all x z center" {
  test_cuboid "--size 9 --size-x 7 --size-z 4 --center" "0" "-3.5" "3.5" "0" "-4.5" "4.5" "0" "-2" "2"
}

@test "short size all y z" {
  test_cuboid "-s 9 -sy 3 -sz 4" "4.5" "0" "9" "1.5" "0" "3" "2" "0" "4"
}

@test "long size all y z" {
  test_cuboid "--size 9 --size-y 3 --size-z 4" "4.5" "0" "9" "1.5" "0" "3" "2" "0" "4"
}

@test "short size all y z center x" {
  test_cuboid "-s 9 -sy 3 -sz 4 -cx" "0" "-4.5" "4.5" "1.5" "0" "3" "2" "0" "4"
}

@test "long size all y z center x" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center-x" "0" "-4.5" "4.5" "1.5" "0" "3" "2" "0" "4"
}

@test "short size all y z center y" {
  test_cuboid "-s 9 -sy 3 -sz 4 -cy" "4.5" "0" "9" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "long size all y z center y" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center-y" "4.5" "0" "9" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "short size all y z center z" {
  test_cuboid "-s 9 -sy 3 -sz 4 -cz" "4.5" "0" "9" "1.5" "0" "3" "0" "-2" "2"
}

@test "long size all y z center z" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center-z" "4.5" "0" "9" "1.5" "0" "3" "0" "-2" "2"
}

@test "short size all y z center x y" {
  test_cuboid "-s 9 -sy 3 -sz 4 -cx -cy" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "long size all y z center x y" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center-x --center-y" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "2" "0" "4"
}

@test "short size all y z center x z" {
  test_cuboid "-s 9 -sy 3 -sz 4 -cx -cz" "0" "-4.5" "4.5" "1.5" "0" "3" "0" "-2" "2"
}

@test "long size all y z center x z" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center-x --center-z" "0" "-4.5" "4.5" "1.5" "0" "3" "0" "-2" "2"
}

@test "short size all y z center y z" {
  test_cuboid "-s 9 -sy 3 -sz 4 -cy -cz" "4.5" "0" "9" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "long size all y z center y z" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center-y --center-z" "4.5" "0" "9" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "short size all y z center" {
  test_cuboid "-s 9 -sy 3 -sz 4 -c" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "0" "-2" "2"
}

@test "long size all y z center" {
  test_cuboid "--size 9 --size-y 3 --size-z 4 --center" "0" "-4.5" "4.5" "0" "-1.5" "1.5" "0" "-2" "2"
}
