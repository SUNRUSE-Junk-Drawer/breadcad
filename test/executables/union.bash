load "../framework/main"

executable_name=union
executable_help="union - combines any number of bc streams using a csg union
  usage: union [options, paths to bc streams] | [consumer of bc stream]
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
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "non-empty stdin" {
  check_failure "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_x.bc" "unexpected stdin"
}

@test "no streams" {
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX}"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "one stream" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "one empty stream" {
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX}" "inf"
}

@test "two streams (first empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc temp/a.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc temp/a.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams (second empty)" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to first" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to second" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to first" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to second" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to third" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to second" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc temp/b.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc temp/b.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to third" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc temp/b.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} test/bc/empty.bc temp/b.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to first" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc test/bc/empty.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc test/bc/empty.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to third" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 15 > temp/c.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc test/bc/empty.bc temp/c.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc test/bc/empty.bc temp/c.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to first" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to second" {
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} > temp/a.bc
  ${BC_EXECUTABLE_PREFIX}cuboid${BC_EXECUTABLE_SUFFIX} | ${BC_EXECUTABLE_PREFIX}translate${BC_EXECUTABLE_SUFFIX} -x 10 > temp/b.bc
  check_valid "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc test/bc/empty.bc"
  check_successful "${BC_EXECUTABLE_PREFIX}union${BC_EXECUTABLE_SUFFIX} temp/a.bc temp/b.bc test/bc/empty.bc | ${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}
