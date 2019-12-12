load "../framework/main"

executable_name=cylinder
executable_help="cylinder - generates a cylinder along the z axis
  usage: cylinder [options] | [consumer of bc stream]
  options:
    -h, --help, /?: display this message
    -sxy [number], --size-xy [number]: size on x and y axes (diameter, millimeters) (default: 1.000000)
    -sz [number], --size-z [number]: size on z axis (length/height, millimeters) (default: 1.000000)
    -cxy, --center-xy: center on x and y axes
    -cz, --center-z: center on z axis"

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
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "0.207107"
}

@test "non-empty stdin" {
  check_failure "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_x.bc" "unexpected stdin"
}

@test "parameter size xy" {
  number_parameter "cylinder" "sxy" "size-xy"
}

@test "parameter size z" {
  number_parameter "cylinder" "sz" "size-z"
}

function test_cylinder {
  parameters=$1

  xy_minimum=$2
  xy_low=$3
  xy_origin=$4
  xy_high=$5
  xy_maximum=$6

  z_minimum=$7
  z_origin=$8
  z_maximum=$9

  check_valid "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_minimum -y $xy_origin -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_maximum -y $xy_origin -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_origin -y $xy_minimum -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_origin -y $xy_maximum -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_low -y $xy_low -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_low -y $xy_high -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_high -y $xy_low -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_high -y $xy_high -z $z_origin" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_origin -y $xy_origin -z $z_minimum" "0.000000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} $parameters | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x $xy_origin -y $xy_origin -z $z_maximum" "0.000000"
}

@test "face centers on surface" {
  test_cylinder "--size-xy 7 --center-z --size-z 3" "0" "1.025126" "3.5" "5.974874" "7" "-1.5" "0" "1.5"
}

@test "face centers above surface" {
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 3.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 3.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 7.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 0.954415" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 6.045585" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045585 -y 0.954416" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 6.045585" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 3.5 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 3.5 -z 1.6" "0.100000"
}

@test "face centers below surface" {
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 3.5" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.9 -y 3.5" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 0.1" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 6.9" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.095837 -y 1.095837" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.095837 -y 5.904163" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 5.904163 -y 1.095837" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 5.904163 -y 5.904163" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 3.5 -z -1.4" "-0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 3.5 -z 1.4" "-0.100000"
}

@test "faces near edges" {
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 3.5 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 3.5 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -0.1 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 7.1 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 0.954415 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 6.045585 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045585 -y 0.954416 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 6.045585 -z -1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 3.5 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7.1 -y 3.5 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y -0.1 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 7.1 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 0.954415 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 6.045585 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045585 -y 0.954416 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 6.045585 -z 1.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y 3.5 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7 -y 3.5 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 7 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.025126 -y 1.025126 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.025126 -y 5.974874 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 5.974874 -y 1.025126 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 5.974874 -y 5.974874 -z -1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y 3.5 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 7 -y 3.5 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.5 -y 7 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.025126 -y 1.025126 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.025126 -y 5.974874 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 5.974874 -y 1.025126 -z 1.6" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 5.974874 -y 5.974874 -z 1.6" "0.100000"
}

@test "edges" {
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 0.954416 -z -1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 6.045584 -z -1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 0.954416 -z -1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 6.045584 -z -1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 0.954416 -z 1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.954416 -y 6.045585 -z 1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 0.954416 -z 1.6" "0.141421"
  check_successful "${BC_EXECUTABLE_PREFIX}cylinder${BC_EXECUTABLE_SUFFIX} --size-xy 7 --center-z --size-z 3 | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.045584 -y 6.045584 -z 1.6" "0.141421"
}

@test "no parameters" {
  test_cylinder "" "0" "0.1464465" "0.5" "0.8535535" "1" "0" "0.5" "1"
}

@test "short center xy" {
  test_cylinder "-cxy" "-0.5" "-0.3535535" "0" "0.3535535" "0.5" "0" "0.5" "1"
}

@test "long center xy" {
  test_cylinder "--center-xy" "-0.5" "-0.3535535" "0" "0.3535535" "0.5" "0" "0.5" "1"
}

@test "short center z" {
  test_cylinder "-cz" "0" "0.1464465" "0.5" "0.8535535" "1" "-0.5" "0" "0.5"
}

@test "long center z" {
  test_cylinder "--center-z" "0" "0.1464465" "0.5" "0.8535535" "1" "-0.5" "0" "0.5"
}

@test "short size xy" {
  test_cylinder "-sxy 7" "0" "1.025126" "3.5" "5.974874" "7" "0" "0.5" "1"
}

@test "long size xy" {
  test_cylinder "--size-xy 7" "0" "1.025126" "3.5" "5.974874" "7" "0" "0.5" "1"
}

@test "short size xy center xy" {
  test_cylinder "-sxy 7 -cxy" "-3.5" "-2.474874" "0.0" "2.474874" "3.5" "0" "0.5" "1"
}

@test "long size xy center xy" {
  test_cylinder "--size-xy 7 --center-xy" "-3.5" "-2.474874" "0.0" "2.474874" "3.5" "0" "0.5" "1"
}

@test "short size xy center z" {
  test_cylinder "-sxy 7 -cz" "0" "1.025126" "3.5" "5.974874" "7" "-0.5" "0" "0.5"
}

@test "long size xy center z" {
  test_cylinder "--size-xy 7 --center-z" "0" "1.025126" "3.5" "5.974874" "7" "-0.5" "0" "0.5"
}

@test "short size z" {
  test_cylinder "-sz 3" "0" "0.1464465" "0.5" "0.8535535" "1" "0" "1.5" "3"
}

@test "long size z" {
  test_cylinder "--size-z 3" "0" "0.1464465" "0.5" "0.8535535" "1" "0" "1.5" "3"
}

@test "short size z center xy" {
  test_cylinder "-sz 3 -cxy" "-0.5" "-0.3535535" "0" "0.3535535" "0.5" "0" "1.5" "3"
}

@test "long size z center xy" {
  test_cylinder "--size-z 3 --center-xy" "-0.5" "-0.3535535" "0" "0.3535535" "0.5" "0" "1.5" "3"
}

@test "short size z center z" {
  test_cylinder "-sz 3 -cz" "0" "0.1464465" "0.5" "0.8535535" "1" "-1.5" "0" "1.5"
}

@test "long size z center z" {
  test_cylinder "--size-z 3 --center-z" "0" "0.1464465" "0.5" "0.8535535" "1" "-1.5" "0" "1.5"
}

@test "short size xy z" {
  test_cylinder "-sxy 7 -sz 3" "0" "1.025126" "3.5" "5.974874" "7" "0" "1.5" "3"
}

@test "long size xy z" {
  test_cylinder "--size-xy 7 --size-z 3" "0" "1.025126" "3.5" "5.974874" "7" "0" "1.5" "3"
}

@test "short size xy z center xy" {
  test_cylinder "-sxy 7 -sz 3 -cxy" "-3.5" "-2.474874" "0" "2.474874" "3.5" "0" "1.5" "3"
}

@test "long size xy z center xy" {
  test_cylinder "--size-xy 7 --size-z 3 --center-xy" "-3.5" "-2.474874" "0" "2.474874" "3.5" "0" "1.5" "3"
}

@test "short size xy z center z" {
  test_cylinder "-sxy 7 -sz 3 -cz" "0" "1.025126" "3.5" "5.974874" "7" "-1.5" "0" "1.5"
}

@test "long size xy z center z" {
  test_cylinder "--size-xy 7 --size-z 3 --center-z" "0" "1.025126" "3.5" "5.974874" "7" "-1.5" "0" "1.5"
}
