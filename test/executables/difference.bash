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
  check_successful "bin/difference < test/sdf/empty.sdf | bin/sample" "inf"
}

@test "non-empty stdin" {
  check_failure "bin/difference < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "no streams" {
  check_successful "bin/difference | bin/sample" "inf"
}

@test "one stream" {
  check_successful "bin/difference <(bin/cuboid) | bin/sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) | bin/sample -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) | bin/sample -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) | bin/sample -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "one empty stream" {
  check_successful "bin/difference test/sdf/empty.sdf | bin/sample" "inf"
}

@test "two streams (first empty)" {
  check_successful "bin/difference test/sdf/empty.sdf <(bin/cuboid) | bin/sample" "inf"
}

@test "two streams (second empty)" {
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x 1.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x 0.5 -y 1.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf | bin/sample -x 0.5 -y 0.5 -z 1.1" "0.100000"
}

@test "two streams" {
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams (first empty)" {
  check_successful "bin/difference test/sdf/empty.sdf <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.5 -y -0.1 -z 0.5" "inf"
}

@test "three streams (second empty)" {
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) | bin/sample -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams (third empty)" {
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x -0.1 -y 0.5 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 1.1 -y 0.2 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 1.1 -y 0.7 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.6 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.1 -y 1.1 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.6 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.1 -y 0.7 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.6 -y 0.7 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf | bin/sample -x 0.3 -y 0.7 -z 0.65" "0.100000"
}

@test "three streams" {
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (first empty)" {
  check_successful "bin/difference test/sdf/empty.sdf <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y -0.1 -z 0.5" "inf"
}

@test "four streams (second empty)" {
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "bin/difference <(bin/cuboid) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (third empty)" {
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) test/sdf/empty.sdf <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) | bin/sample -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams (fourth empty)" {
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.5 -y -0.1 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.5 -y 0.5 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) test/sdf/empty.sdf | bin/sample -x 0.1 -y 0.6 -z 0.65" "0.100000"
}

@test "four streams" {
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.65 -y -0.1 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.25 -y -0.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.9 -y -0.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.25 -y 0.15 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.9 -y 0.15 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.65 -y 0.65 -z -0.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.65 -y 0.2 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.6 -y 0.15 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.7 -y 0.15 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.65 -y 0.15 -z 0.2" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 1.1 -y 0.2 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 1.1 -y 0.6 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.8 -y 1.1 -z 0.15" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.3 -y 1.1 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x -0.1 -y 0.25 -z 0.5" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x -0.1 -y 0.75 -z 0.05" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.1 -y 0.45 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.5 -y 0.2 -z 1.1" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.3 -y 0.75 -z 0.2" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.8 -y 0.75 -z 0.4" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.4 -y 0.45 -z 0.325" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.225 -y 0.45 -z 0.65" "0.025000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.6 -y 0.5 -z 0.65" "0.100000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.55 -y 0.75 -z 0.2" "0.050000"
  check_successful "bin/difference <(bin/cuboid) <(bin/cuboid | bin/translate -x 0.2 -y 0.4 -z 0.3) <(bin/cuboid | bin/translate -x -0.4 -y 0.5 -z 0.1) <(bin/cuboid -s 0.3 | bin/translate -x 0.5) | bin/sample -x 0.1 -y 0.6 -z 0.65" "0.100000"
}
