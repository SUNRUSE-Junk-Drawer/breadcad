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
  check_successful "bin/cuboid < test/sdf/empty.sdf | bin/sample" "-0.000000"
}

@test "non-empty stdin" {
  check_failure "bin/cuboid < test/sdf/parameter_x.sdf" "unexpected stdin"
}

function test_cuboid_subset {
  subset_parameters=$1

  subset_x_origin=$2
  subset_x_low=$3
  subset_x_high=$4
  subset_y_origin=$5
  subset_y_low=$6
  subset_y_high=$7
  subset_z_origin=$8
  subset_z_low=$9
  subset_z_high=${10}

  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_origin -y $subset_y_origin -z $subset_z_origin" "-0.500000"
  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_low -y $subset_y_origin -z $subset_z_origin" "-0.400000"
  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_high -y $subset_y_origin -z $subset_z_origin" "-0.400000"
  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_origin -y $subset_y_low -z $subset_z_origin" "-0.400000"
  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_origin -y $subset_y_high -z $subset_z_origin" "-0.400000"
  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_origin -y $subset_y_origin -z $subset_z_low" "-0.400000"
  check_successful "bin/cuboid $subset_parameters | bin/sample -x $subset_x_origin -y $subset_y_origin -z $subset_z_high" "-0.400000"
}

function test_cuboid {
  parameters=$1

  non_centered_x_origin=$2
  non_centered_x_low=$3
  non_centered_x_high=$4
  non_centered_y_origin=$5
  non_centered_y_low=$6
  non_centered_y_high=$7
  non_centered_z_origin=$8
  non_centered_z_low=$9
  non_centered_z_high=${10}

  centered_x_origin=${11}
  centered_x_low=${12}
  centered_x_high=${13}
  centered_y_origin=${14}
  centered_y_low=${15}
  centered_y_high=${16}
  centered_z_origin=${17}
  centered_z_low=${18}
  centered_z_high=${19}

  test_cuboid_subset "$parameters" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters -cx" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters -cy" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters -cz" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters -cx -cy" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters -cx -cz" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters -cy -cz" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters -c" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters --center-x" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters --center-y" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters --center-z" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters --center-x --center-y" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$non_centered_z_origin" "$non_centered_z_low" "$non_centered_z_high"
  test_cuboid_subset "$parameters --center-x --center-z" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$non_centered_y_origin" "$non_centered_y_low" "$non_centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters --center-y --center-z" "$non_centered_x_origin" "$non_centered_x_low" "$non_centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
  test_cuboid_subset "$parameters --center" "$centered_x_origin" "$centered_x_low" "$centered_x_high" "$centered_y_origin" "$centered_y_low" "$centered_y_high" "$centered_z_origin" "$centered_z_low" "$centered_z_high"
}

@test "default" {
  test_cuboid "" "0.5" "0.4" "0.6" "0.5" "0.4" "0.6" "0.5" "0.4" "0.6" "0.0" "-0.1" "0.1" "0.0" "-0.1" "0.1" "0.0" "-0.1" "0.1"
}

@test "size short" {
  test_cuboid "-s 2" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6"
}

@test "size long" {
  test_cuboid "--size 2" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6"
}

@test "size x short" {
  test_cuboid "-sx 2" "1.5" "0.4" "1.6" "0.5" "0.4" "0.6" "0.5" "0.4" "0.6" "0.5" "-0.6" "0.6" "0.0" "-0.1" "0.1" "0.0" "-0.1" "0.1"
}

@test "size x long" {
  test_cuboid "--size-x 2" "1.5" "0.4" "1.6" "0.5" "0.4" "0.6" "0.5" "0.4" "0.6" "0.5" "-0.6" "0.6" "0.0" "-0.1" "0.1" "0.0" "-0.1" "0.1"
}

@test "size y short" {
  test_cuboid "-sy 2" "0.5" "0.4" "0.6" "1.5" "0.4" "1.6" "0.5" "0.4" "0.6" "0.0" "-0.1" "0.1" "0.5" "-0.6" "0.6" "0.0" "-0.1" "0.1"
}

@test "size y long" {
  test_cuboid "--size-y 2" "0.5" "0.4" "0.6" "1.5" "0.4" "1.6" "0.5" "0.4" "0.6" "0.0" "-0.1" "0.1" "0.5" "-0.6" "0.6" "0.0" "-0.1" "0.1"
}

@test "size z short" {
  test_cuboid "-sz 2" "0.5" "0.4" "0.6" "0.5" "0.4" "0.6" "1.5" "0.4" "1.6" "0.0" "-0.1" "0.1" "0.0" "-0.1" "0.1" "0.5" "-0.6" "0.6"
}

@test "size z long" {
  test_cuboid "--size-z 2" "0.5" "0.4" "0.6" "0.5" "0.4" "0.6" "1.5" "0.4" "1.6" "0.0" "-0.1" "0.1" "0.0" "-0.1" "0.1" "0.5" "-0.6" "0.6"
}

@test "size x y short" {
  test_cuboid "-sx 2 -sy 3" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "0.5" "0.4" "0.6" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1" "0.0" "-0.1" "0.1"
}

@test "size x y long" {
  test_cuboid "--size-x 2 --size-y 3" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "0.5" "0.4" "0.6" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1" "0.0" "-0.1" "0.1"
}

@test "size x z short" {
  test_cuboid "-sx 2 -sz 3" "1.5" "0.4" "1.6" "0.5" "0.4" "0.6" "2.5" "0.4" "2.6" "0.5" "-0.6" "0.6" "0.0" "-0.1" "0.1" "1" "-1.1" "1.1"
}

@test "size x z long" {
  test_cuboid "--size-x 2 --size-z 3" "1.5" "0.4" "1.6" "0.5" "0.4" "0.6" "2.5" "0.4" "2.6" "0.5" "-0.6" "0.6" "0.0" "-0.1" "0.1" "1" "-1.1" "1.1"
}

@test "size y z short" {
  test_cuboid "-sy 2 -sz 3" "0.5" "0.4" "0.6" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "0.0" "-0.1" "0.1" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1"
}

@test "size y z long" {
  test_cuboid "--size-y 2 --size-z 3" "0.5" "0.4" "0.6" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "0.0" "-0.1" "0.1" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1"
}

@test "size and x short" {
  test_cuboid "-s 2 -sx 3" "2.5" "0.4" "2.6" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "1" "-1.1" "1.1" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6"
}

@test "size and x long" {
  test_cuboid "--size 2 --size-x 3" "2.5" "0.4" "2.6" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "1" "-1.1" "1.1" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6"
}

@test "size and y short" {
  test_cuboid "-s 2 -sy 3" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "1.5" "0.4" "1.6" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1" "0.5" "-0.6" "0.6"
}

@test "size and y long" {
  test_cuboid "--size 2 --size-y 3" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "1.5" "0.4" "1.6" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1" "0.5" "-0.6" "0.6"
}

@test "size and z short" {
  test_cuboid "-s 2 -sz 3" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1"
}

@test "size and z long" {
  test_cuboid "--size 2 --size-z 3" "1.5" "0.4" "1.6" "1.5" "0.4" "1.6" "2.5" "0.4" "2.6" "0.5" "-0.6" "0.6" "0.5" "-0.6" "0.6" "1" "-1.1" "1.1"
}

@test "parameter size" {
  float_parameter "cuboid" "s" "size"
}

@test "parameter size x" {
  float_parameter "cuboid" "sx" "size-x"
}

@test "parameter size y" {
  float_parameter "cuboid" "sy" "size-y"
}

@test "parameter size z" {
  float_parameter "cuboid" "sz" "size-z"
}
