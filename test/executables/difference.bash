load "../framework/main"

executable_name=difference
executable_help="difference - combines any number of sdf streams using a csg difference from the first
  usage: difference [options, paths to sdf streams] | [consumer of sdf stream]
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
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "non-empty stdin" {
  check_failure "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "no streams" {
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX}"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "one stream" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "one empty stream" {
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "two streams (first empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "two streams (second empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "two streams" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams (first empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf temp/b.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "inf"
}

@test "three streams (second empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams (third empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > temp/c.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (first empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > temp/c.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf temp/b.sdf temp/c.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "inf"
}

@test "four streams (second empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > temp/c.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (third empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > temp/c.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (fourth empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > temp/c.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > temp/c.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} -s 0.3 | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 0.5 > temp/d.sdf
  check_valid "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.65 -y -0.1 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.25 -y -0.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.9 -y -0.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.25 -y 0.15 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.9 -y 0.15 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.65 -y 0.65 -z -0.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.65 -y 0.2 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.15 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.7 -y 0.15 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.65 -y 0.15 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${SDF_EXECUTABLE_PREFIX}difference${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf temp/d.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}
