load "../framework/main"

executable_name=difference
executable_help="difference - combines any number of bc streams using a csg difference from the first
  usage: difference [options, paths to bc streams] | [consumer of bc stream]
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
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "non-empty stdin" {
  check_failure "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_x.bc" "unexpected stdin"
}

@test "no streams" {
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX}"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "one stream" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "one empty stream" {
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "two streams (first empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc c/temp/a.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc c/temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "two streams (second empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "two streams" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams (first empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc c/temp/a.bc c/temp/b.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc c/temp/a.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "inf"
}

@test "three streams (second empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams (third empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > c/temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (first empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > c/temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc c/temp/a.bc c/temp/b.bc c/temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc c/temp/a.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "inf"
}

@test "four streams (second empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > c/temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc test/bc/empty.bc c/temp/b.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (third empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > c/temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc test/bc/empty.bc c/temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (fourth empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > c/temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > c/temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.2 -y 0.4 -z 0.3 > c/temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x -0.4 -y 0.5 -z 0.1 > c/temp/c.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} -s 0.3 | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 0.5 > c/temp/d.bc
  check_valid "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.65 -y -0.1 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.25 -y -0.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.9 -y -0.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.25 -y 0.15 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.9 -y 0.15 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.65 -y 0.65 -z -0.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.65 -y 0.2 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.15 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.7 -y 0.15 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.65 -y 0.15 -z 0.2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "${BC_EXECUTABLE_PREFIX}difference${BC_EXECUTABLE_SUFFIX} c/temp/a.bc c/temp/b.bc c/temp/c.bc c/temp/d.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 0.6 -z 0.65" "0.100000"
}
