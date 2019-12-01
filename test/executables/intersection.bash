load "../framework/main"

executable_name=intersection
executable_help="intersection - combines any number of sdf streams using a csg intersection
  usage: intersection [options, paths to sdf streams] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message"

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
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection < test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample" "inf"
}

@test "non-empty stdin" {
  check_failure "${SDF_EXECUTABLE_PREFIX}intersection < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "no streams" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection | ${SDF_EXECUTABLE_PREFIX}sample" "inf"
}

@test "one stream" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "one empty stream" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample" "inf"
}

@test "two streams (first empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "two streams (second empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "two streams" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.3 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 1.1" "0.100000"
}

@test "three streams (first empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.3 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 1.1" "0.100000"
}

@test "three streams (second empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.3 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 1.1" "0.100000"
}

@test "three streams (third empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 1.1 -y 0.7 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.3 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.6 -y 0.7 -z 1.1" "0.100000"
}

@test "three streams" {
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x -0.4 -y 0.5 -z 0.1) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.1 -y 0.65 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x -0.4 -y 0.5 -z 0.1) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.7 -y 0.65 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x -0.4 -y 0.5 -z 0.1) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.4 -y 0.4 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x -0.4 -y 0.5 -z 0.1) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x -0.4 -y 0.5 -z 0.1) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.4 -y 0.75 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}intersection <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 0.2 -y 0.4 -z 0.3) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x -0.4 -y 0.5 -z 0.1) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.4 -y 0.75 -z 0.2" "0.100000"
}
