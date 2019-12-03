load "../framework/main"

executable_name=union
executable_help="union - combines any number of sdf streams using a csg union
  usage: union [options, paths to sdf streams] | [consumer of sdf stream]
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
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "non-empty stdin" {
  check_failure "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "no streams" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "one stream" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "one empty stream" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX}" "inf"
}

@test "two streams (first empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/a.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams (second empty)" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to first" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to second" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to first" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to second" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to third" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to second" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to third" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} test/sdf/empty.sdf temp/b.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to first" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to third" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 15 > temp/c.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf test/sdf/empty.sdf temp/c.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to first" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to second" {
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} > temp/a.sdf
  ${SDF_EXECUTABLE_PREFIX}cuboid${SDF_EXECUTABLE_SUFFIX} | ${SDF_EXECUTABLE_PREFIX}translate${SDF_EXECUTABLE_SUFFIX} -x 10 > temp/b.sdf
  check_successful "${SDF_EXECUTABLE_PREFIX}union${SDF_EXECUTABLE_SUFFIX} temp/a.sdf temp/b.sdf test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample${SDF_EXECUTABLE_SUFFIX} -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}
