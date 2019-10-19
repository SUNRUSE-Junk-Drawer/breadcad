load "../framework/main"

executable_name=scale
executable_help="scale - uniformly scales the geometry described by a sdf stream
  usage: [sdf stream] | scale [options] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message
    -f [number], --factor [number]: scaling factor (coefficient) (default: 1.000000)"

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
  check_successful "bin/scale < test/sdf/empty.sdf | bin/sample" "inf"
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

  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_origin -y $y_origin -z $z_origin" "-0.500000"
  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_low -y $y_origin -z $z_origin" "-0.400000"
  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_high -y $y_origin -z $z_origin" "-0.400000"
  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_origin -y $y_low -z $z_origin" "-0.400000"
  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_origin -y $y_high -z $z_origin" "-0.400000"
  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_origin -y $y_origin -z $z_low" "-0.400000"
  check_successful "bin/cuboid --size-x 2 --size-y 8 --size-z 4 | bin/scale $parameters | bin/sample -x $x_origin -y $y_origin -z $z_high" "-0.400000"
}

@test "default" {
  test_cuboid "" "0.5" "0.4" "1.6" "0.5" "0.4" "7.6" "0.5" "0.4" "3.6"
}

@test "short" {
  test_cuboid "-f 2" "0.5" "0.4" "3.6" "0.5" "0.4" "15.6" "0.5" "0.4" "7.6"
}

@test "long" {
  test_cuboid "--factor 2" "0.5" "0.4" "3.6" "0.5" "0.4" "15.6" "0.5" "0.4" "7.6"
}

@test "factor validation" {
  float_parameter "scale" "f" "factor"
}
