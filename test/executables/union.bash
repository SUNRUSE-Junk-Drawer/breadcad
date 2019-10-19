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
  check_successful "bin/union < test/sdf/empty.sdf | bin/sample" "inf"
}

@test "non-empty stdin" {
  check_failure "bin/union < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "no streams" {
  check_successful "bin/union | bin/sample" "inf"
}

@test "one stream" {
  check_successful "bin/union <(bin/cuboid) | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "one empty stream" {
  check_successful "bin/union test/sdf/empty.sdf | bin/sample" "inf"
}

@test "two streams (first empty)" {
  check_successful "bin/union test/sdf/empty.sdf <(bin/cuboid) | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams (second empty)" {
  check_successful "bin/union <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to first" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to second" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) | bin/sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to first" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) <(bin/cuboid | bin/translate -x 15) | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to second" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) <(bin/cuboid | bin/translate -x 15) | bin/sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to third" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) <(bin/cuboid | bin/translate -x 15) | bin/sample -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to second" {
  check_successful "bin/union test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 10) <(bin/cuboid | bin/translate -x 15) | bin/sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to third" {
  check_successful "bin/union test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 10) <(bin/cuboid | bin/translate -x 15) | bin/sample -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to first" {
  check_successful "bin/union <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 15) | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to third" {
  check_successful "bin/union <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 15) | bin/sample -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to first" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) test/sdf/empty.sdf | bin/sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to second" {
  check_successful "bin/union <(bin/cuboid) <(bin/cuboid | bin/translate -x 10) test/sdf/empty.sdf | bin/sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}
