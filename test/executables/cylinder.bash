load "../framework/main"

executable_name=cylinder
executable_help="cylinder - generates a cylinder along the z axis
  usage: cylinder [options] | [consumer of sdf stream]
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
  check_successful "bin/cylinder < test/sdf/empty.sdf | bin/sample" "0.207107"
}

@test "non-empty stdin" {
  check_failure "bin/cylinder < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "parameter size xy" {
  float_parameter "cylinder" "sxy" "size-xy"
}

@test "parameter size z" {
  float_parameter "cylinder" "sz" "size-z"
}

@test "distances" {
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 0.100000" "-0.100000" # 0 0 - inside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 0.100000" "-0.100000" # 0 0 - inside long
  check_successful "bin/cylinder -cxy | bin/sample -z 0.100000" "-0.100000" # 0 0 - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -z 0.100000" "-0.100000" # 0 0 - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.500000 -z -0.400000" "-0.100000" # 0 0 - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z -0.400000" "-0.100000" # 0 0 - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -z -0.400000" "-0.100000" # 0 0 - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z -0.400000" "-0.100000" # 0 0 - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z -0.100000" "0.100000" # 0 0 - outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z -0.100000" "0.100000" # 0 0 - outside long
  check_successful "bin/cylinder -cxy | bin/sample -z -0.100000" "0.100000" # 0 0 - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -z -0.100000" "0.100000" # 0 0 - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.500000 -z -0.600000" "0.100000" # 0 0 - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z -0.600000" "0.100000" # 0 0 - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -z -0.600000" "0.100000" # 0 0 - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z -0.600000" "0.100000" # 0 0 - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 0.900000" "-0.100000" # 0 0 + inside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 0.900000" "-0.100000" # 0 0 + inside long
  check_successful "bin/cylinder -cxy | bin/sample -z 0.900000" "-0.100000" # 0 0 + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -z 0.900000" "-0.100000" # 0 0 + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.500000 -z 0.400000" "-0.100000" # 0 0 + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z 0.400000" "-0.100000" # 0 0 + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -z 0.400000" "-0.100000" # 0 0 + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z 0.400000" "-0.100000" # 0 0 + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 1.100000" "0.100000" # 0 0 + outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 1.100000" "0.100000" # 0 0 + outside long
  check_successful "bin/cylinder -cxy | bin/sample -z 1.100000" "0.100000" # 0 0 + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -z 1.100000" "0.100000" # 0 0 + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.500000 -z 0.600000" "0.100000" # 0 0 + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z 0.600000" "0.100000" # 0 0 + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -z 0.600000" "0.100000" # 0 0 + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z 0.600000" "0.100000" # 0 0 + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 0.500000" "-0.100000" # 0 - inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 0.500000" "-0.100000" # 0 - inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.400000 -z 0.500000" "-0.100000" # 0 - inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.400000 -z 0.500000" "-0.100000" # 0 - inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.100000" "-0.100000" # 0 - inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.100000" "-0.100000" # 0 - inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.400000" "-0.100000" # 0 - inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.400000" "-0.100000" # 0 - inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 0.500000" "0.100000" # 0 - outside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 0.500000" "0.100000" # 0 - outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.600000 -z 0.500000" "0.100000" # 0 - outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.600000 -z 0.500000" "0.100000" # 0 - outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y -0.100000" "0.100000" # 0 - outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y -0.100000" "0.100000" # 0 - outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.600000" "0.100000" # 0 - outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.600000" "0.100000" # 0 - outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 0.200000" "-0.100000" # 0 - inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 0.200000" "-0.100000" # 0 - inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.400000 -z 0.200000" "-0.100000" # 0 - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.400000 -z 0.200000" "-0.100000" # 0 - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.100000 -z -0.300000" "-0.100000" # 0 - inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.100000 -z -0.300000" "-0.100000" # 0 - inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.400000 -z -0.300000" "-0.100000" # 0 - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.400000 -z -0.300000" "-0.100000" # 0 - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.200000 -z 0.100000" "-0.100000" # 0 - inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.200000 -z 0.100000" "-0.100000" # 0 - inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.300000 -z 0.100000" "-0.100000" # 0 - inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.300000 -z 0.100000" "-0.100000" # 0 - inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.200000 -z -0.400000" "-0.100000" # 0 - inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.200000 -z -0.400000" "-0.100000" # 0 - inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.300000 -z -0.400000" "-0.100000" # 0 - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.300000 -z -0.400000" "-0.100000" # 0 - inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 0.100000" "0.100000" # 0 - outside - inside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 0.100000" "0.100000" # 0 - outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.600000 -z 0.100000" "0.100000" # 0 - outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.600000 -z 0.100000" "0.100000" # 0 - outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y -0.100000 -z -0.400000" "0.100000" # 0 - outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y -0.100000 -z -0.400000" "0.100000" # 0 - outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.600000 -z -0.400000" "0.100000" # 0 - outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.600000 -z -0.400000" "0.100000" # 0 - outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z -0.100000" "0.100000" # 0 - inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z -0.100000" "0.100000" # 0 - inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.400000 -z -0.100000" "0.100000" # 0 - inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.400000 -z -0.100000" "0.100000" # 0 - inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.100000 -z -0.600000" "0.100000" # 0 - inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.100000 -z -0.600000" "0.100000" # 0 - inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.400000 -z -0.600000" "0.100000" # 0 - inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.400000 -z -0.600000" "0.100000" # 0 - inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z -0.200000" "0.223607" # 0 - outside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z -0.200000" "0.223607" # 0 - outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.600000 -z -0.200000" "0.223607" # 0 - outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.600000 -z -0.200000" "0.223607" # 0 - outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y -0.100000 -z -0.700000" "0.223607" # 0 - outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y -0.100000 -z -0.700000" "0.223607" # 0 - outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.600000 -z -0.700000" "0.223607" # 0 - outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.600000 -z -0.700000" "0.223607" # 0 - outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 0.800000" "-0.100000" # 0 - inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 0.800000" "-0.100000" # 0 - inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.400000 -z 0.800000" "-0.100000" # 0 - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.400000 -z 0.800000" "-0.100000" # 0 - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.100000 -z 0.300000" "-0.100000" # 0 - inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.100000 -z 0.300000" "-0.100000" # 0 - inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.400000 -z 0.300000" "-0.100000" # 0 - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.400000 -z 0.300000" "-0.100000" # 0 - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.200000 -z 0.900000" "-0.100000" # 0 - inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.200000 -z 0.900000" "-0.100000" # 0 - inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.300000 -z 0.900000" "-0.100000" # 0 - inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.300000 -z 0.900000" "-0.100000" # 0 - inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.200000 -z 0.400000" "-0.100000" # 0 - inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.200000 -z 0.400000" "-0.100000" # 0 - inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.300000 -z 0.400000" "-0.100000" # 0 - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.300000 -z 0.400000" "-0.100000" # 0 - inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 0.900000" "0.100000" # 0 - outside + inside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 0.900000" "0.100000" # 0 - outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.600000 -z 0.900000" "0.100000" # 0 - outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.600000 -z 0.900000" "0.100000" # 0 - outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y -0.100000 -z 0.400000" "0.100000" # 0 - outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y -0.100000 -z 0.400000" "0.100000" # 0 - outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.600000 -z 0.400000" "0.100000" # 0 - outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.600000 -z 0.400000" "0.100000" # 0 - outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 1.100000" "0.100000" # 0 - inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.100000 -z 1.100000" "0.100000" # 0 - inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.400000 -z 1.100000" "0.100000" # 0 - inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.400000 -z 1.100000" "0.100000" # 0 - inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.100000 -z 0.600000" "0.100000" # 0 - inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.100000 -z 0.600000" "0.100000" # 0 - inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.400000 -z 0.600000" "0.100000" # 0 - inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.400000 -z 0.600000" "0.100000" # 0 - inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 1.200000" "0.223607" # 0 - outside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y -0.100000 -z 1.200000" "0.223607" # 0 - outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -y -0.600000 -z 1.200000" "0.223607" # 0 - outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y -0.600000 -z 1.200000" "0.223607" # 0 - outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y -0.100000 -z 0.700000" "0.223607" # 0 - outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y -0.100000 -z 0.700000" "0.223607" # 0 - outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y -0.600000 -z 0.700000" "0.223607" # 0 - outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y -0.600000 -z 0.700000" "0.223607" # 0 - outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 0.500000" "-0.100000" # 0 + inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 0.500000" "-0.100000" # 0 + inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.400000 -z 0.500000" "-0.100000" # 0 + inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.400000 -z 0.500000" "-0.100000" # 0 + inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.900000" "-0.100000" # 0 + inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.900000" "-0.100000" # 0 + inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.400000" "-0.100000" # 0 + inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.400000" "-0.100000" # 0 + inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 0.500000" "0.100000" # 0 + outside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 0.500000" "0.100000" # 0 + outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.600000 -z 0.500000" "0.100000" # 0 + outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.600000 -z 0.500000" "0.100000" # 0 + outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 1.100000" "0.100000" # 0 + outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.100000" "0.100000" # 0 + outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.600000" "0.100000" # 0 + outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.600000" "0.100000" # 0 + outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 0.200000" "-0.100000" # 0 + inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 0.200000" "-0.100000" # 0 + inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.400000 -z 0.200000" "-0.100000" # 0 + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.400000 -z 0.200000" "-0.100000" # 0 + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.900000 -z -0.300000" "-0.100000" # 0 + inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.900000 -z -0.300000" "-0.100000" # 0 + inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.400000 -z -0.300000" "-0.100000" # 0 + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.400000 -z -0.300000" "-0.100000" # 0 + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.800000 -z 0.100000" "-0.100000" # 0 + inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.800000 -z 0.100000" "-0.100000" # 0 + inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.300000 -z 0.100000" "-0.100000" # 0 + inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.300000 -z 0.100000" "-0.100000" # 0 + inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.800000 -z -0.400000" "-0.100000" # 0 + inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.800000 -z -0.400000" "-0.100000" # 0 + inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.300000 -z -0.400000" "-0.100000" # 0 + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.300000 -z -0.400000" "-0.100000" # 0 + inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 0.100000" "0.100000" # 0 + outside - inside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 0.100000" "0.100000" # 0 + outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.600000 -z 0.100000" "0.100000" # 0 + outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.600000 -z 0.100000" "0.100000" # 0 + outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 1.100000 -z -0.400000" "0.100000" # 0 + outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.100000 -z -0.400000" "0.100000" # 0 + outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.600000 -z -0.400000" "0.100000" # 0 + outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.600000 -z -0.400000" "0.100000" # 0 + outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z -0.100000" "0.100000" # 0 + inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z -0.100000" "0.100000" # 0 + inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.400000 -z -0.100000" "0.100000" # 0 + inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.400000 -z -0.100000" "0.100000" # 0 + inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.900000 -z -0.600000" "0.100000" # 0 + inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.900000 -z -0.600000" "0.100000" # 0 + inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.400000 -z -0.600000" "0.100000" # 0 + inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.400000 -z -0.600000" "0.100000" # 0 + inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z -0.200000" "0.223607" # 0 + outside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z -0.200000" "0.223607" # 0 + outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.600000 -z -0.200000" "0.223607" # 0 + outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.600000 -z -0.200000" "0.223607" # 0 + outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 1.100000 -z -0.700000" "0.223607" # 0 + outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.100000 -z -0.700000" "0.223607" # 0 + outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.600000 -z -0.700000" "0.223607" # 0 + outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.600000 -z -0.700000" "0.223607" # 0 + outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 0.800000" "-0.100000" # 0 + inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 0.800000" "-0.100000" # 0 + inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.400000 -z 0.800000" "-0.100000" # 0 + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.400000 -z 0.800000" "-0.100000" # 0 + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.900000 -z 0.300000" "-0.100000" # 0 + inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.900000 -z 0.300000" "-0.100000" # 0 + inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.400000 -z 0.300000" "-0.100000" # 0 + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.400000 -z 0.300000" "-0.100000" # 0 + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.800000 -z 0.900000" "-0.100000" # 0 + inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.800000 -z 0.900000" "-0.100000" # 0 + inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.300000 -z 0.900000" "-0.100000" # 0 + inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.300000 -z 0.900000" "-0.100000" # 0 + inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.800000 -z 0.400000" "-0.100000" # 0 + inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.800000 -z 0.400000" "-0.100000" # 0 + inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.300000 -z 0.400000" "-0.100000" # 0 + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.300000 -z 0.400000" "-0.100000" # 0 + inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 0.900000" "0.100000" # 0 + outside + inside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 0.900000" "0.100000" # 0 + outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.600000 -z 0.900000" "0.100000" # 0 + outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.600000 -z 0.900000" "0.100000" # 0 + outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 1.100000 -z 0.400000" "0.100000" # 0 + outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.100000 -z 0.400000" "0.100000" # 0 + outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.600000 -z 0.400000" "0.100000" # 0 + outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.600000 -z 0.400000" "0.100000" # 0 + outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 1.100000" "0.100000" # 0 + inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.900000 -z 1.100000" "0.100000" # 0 + inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.400000 -z 1.100000" "0.100000" # 0 + inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.400000 -z 1.100000" "0.100000" # 0 + inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 0.900000 -z 0.600000" "0.100000" # 0 + inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.900000 -z 0.600000" "0.100000" # 0 + inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.400000 -z 0.600000" "0.100000" # 0 + inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.400000 -z 0.600000" "0.100000" # 0 + inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 1.200000" "0.223607" # 0 + outside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.100000 -z 1.200000" "0.223607" # 0 + outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -y 0.600000 -z 1.200000" "0.223607" # 0 + outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -y 0.600000 -z 1.200000" "0.223607" # 0 + outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.500000 -y 1.100000 -z 0.700000" "0.223607" # 0 + outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.100000 -z 0.700000" "0.223607" # 0 + outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -y 0.600000 -z 0.700000" "0.223607" # 0 + outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -y 0.600000 -z 0.700000" "0.223607" # 0 + outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 0.500000" "-0.100000" # - 0 inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 0.500000" "-0.100000" # - 0 inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.400000 -z 0.500000" "-0.100000" # - 0 inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.400000 -z 0.500000" "-0.100000" # - 0 inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.100000 -y 0.500000" "-0.100000" # - 0 inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.100000 -y 0.500000" "-0.100000" # - 0 inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.400000" "-0.100000" # - 0 inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.400000" "-0.100000" # - 0 inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 0.500000" "0.100000" # - 0 outside 0 short
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 0.500000" "0.100000" # - 0 outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.600000 -z 0.500000" "0.100000" # - 0 outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.600000 -z 0.500000" "0.100000" # - 0 outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.100000 -y 0.500000" "0.100000" # - 0 outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.100000 -y 0.500000" "0.100000" # - 0 outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.600000" "0.100000" # - 0 outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.600000" "0.100000" # - 0 outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 0.200000" "-0.100000" # - 0 inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 0.200000" "-0.100000" # - 0 inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.400000 -z 0.200000" "-0.100000" # - 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.400000 -z 0.200000" "-0.100000" # - 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.100000 -y 0.500000 -z -0.300000" "-0.100000" # - 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.100000 -y 0.500000 -z -0.300000" "-0.100000" # - 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.400000 -z -0.300000" "-0.100000" # - 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.400000 -z -0.300000" "-0.100000" # - 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.200000 -y 0.500000 -z 0.100000" "-0.100000" # - 0 inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.200000 -y 0.500000 -z 0.100000" "-0.100000" # - 0 inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.300000 -z 0.100000" "-0.100000" # - 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.300000 -z 0.100000" "-0.100000" # - 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.200000 -y 0.500000 -z -0.400000" "-0.100000" # - 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.200000 -y 0.500000 -z -0.400000" "-0.100000" # - 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.300000 -z -0.400000" "-0.100000" # - 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.300000 -z -0.400000" "-0.100000" # - 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 0.100000" "0.100000" # - 0 outside - inside short
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 0.100000" "0.100000" # - 0 outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.600000 -z 0.100000" "0.100000" # - 0 outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.600000 -z 0.100000" "0.100000" # - 0 outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.100000 -y 0.500000 -z -0.400000" "0.100000" # - 0 outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.100000 -y 0.500000 -z -0.400000" "0.100000" # - 0 outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.600000 -z -0.400000" "0.100000" # - 0 outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.600000 -z -0.400000" "0.100000" # - 0 outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z -0.100000" "0.100000" # - 0 inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z -0.100000" "0.100000" # - 0 inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.400000 -z -0.100000" "0.100000" # - 0 inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.400000 -z -0.100000" "0.100000" # - 0 inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.100000 -y 0.500000 -z -0.600000" "0.100000" # - 0 inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.100000 -y 0.500000 -z -0.600000" "0.100000" # - 0 inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.400000 -z -0.600000" "0.100000" # - 0 inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.400000 -z -0.600000" "0.100000" # - 0 inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z -0.200000" "0.223607" # - 0 outside - outside short
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z -0.200000" "0.223607" # - 0 outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.600000 -z -0.200000" "0.223607" # - 0 outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.600000 -z -0.200000" "0.223607" # - 0 outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.100000 -y 0.500000 -z -0.700000" "0.223607" # - 0 outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.100000 -y 0.500000 -z -0.700000" "0.223607" # - 0 outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.600000 -z -0.700000" "0.223607" # - 0 outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.600000 -z -0.700000" "0.223607" # - 0 outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 0.800000" "-0.100000" # - 0 inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 0.800000" "-0.100000" # - 0 inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.400000 -z 0.800000" "-0.100000" # - 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.400000 -z 0.800000" "-0.100000" # - 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.100000 -y 0.500000 -z 0.300000" "-0.100000" # - 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.100000 -y 0.500000 -z 0.300000" "-0.100000" # - 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.400000 -z 0.300000" "-0.100000" # - 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.400000 -z 0.300000" "-0.100000" # - 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.200000 -y 0.500000 -z 0.900000" "-0.100000" # - 0 inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.200000 -y 0.500000 -z 0.900000" "-0.100000" # - 0 inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.300000 -z 0.900000" "-0.100000" # - 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.300000 -z 0.900000" "-0.100000" # - 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.200000 -y 0.500000 -z 0.400000" "-0.100000" # - 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.200000 -y 0.500000 -z 0.400000" "-0.100000" # - 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.300000 -z 0.400000" "-0.100000" # - 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.300000 -z 0.400000" "-0.100000" # - 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 0.900000" "0.100000" # - 0 outside + inside short
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 0.900000" "0.100000" # - 0 outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.600000 -z 0.900000" "0.100000" # - 0 outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.600000 -z 0.900000" "0.100000" # - 0 outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.100000 -y 0.500000 -z 0.400000" "0.100000" # - 0 outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.100000 -y 0.500000 -z 0.400000" "0.100000" # - 0 outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.600000 -z 0.400000" "0.100000" # - 0 outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.600000 -z 0.400000" "0.100000" # - 0 outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 1.100000" "0.100000" # - 0 inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.100000 -y 0.500000 -z 1.100000" "0.100000" # - 0 inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.400000 -z 1.100000" "0.100000" # - 0 inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.400000 -z 1.100000" "0.100000" # - 0 inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.100000 -y 0.500000 -z 0.600000" "0.100000" # - 0 inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.100000 -y 0.500000 -z 0.600000" "0.100000" # - 0 inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.400000 -z 0.600000" "0.100000" # - 0 inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.400000 -z 0.600000" "0.100000" # - 0 inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 1.200000" "0.223607" # - 0 outside + outside short
  check_successful "bin/cylinder | bin/sample -x -0.100000 -y 0.500000 -z 1.200000" "0.223607" # - 0 outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.600000 -z 1.200000" "0.223607" # - 0 outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.600000 -z 1.200000" "0.223607" # - 0 outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.100000 -y 0.500000 -z 0.700000" "0.223607" # - 0 outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.100000 -y 0.500000 -z 0.700000" "0.223607" # - 0 outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.600000 -z 0.700000" "0.223607" # - 0 outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.600000 -z 0.700000" "0.223607" # - 0 outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 0.500000" "-0.100000" # + 0 inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 0.500000" "-0.100000" # + 0 inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.400000 -z 0.500000" "-0.100000" # + 0 inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.400000 -z 0.500000" "-0.100000" # + 0 inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.900000 -y 0.500000" "-0.100000" # + 0 inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.900000 -y 0.500000" "-0.100000" # + 0 inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.400000" "-0.100000" # + 0 inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.400000" "-0.100000" # + 0 inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 0.500000" "0.100000" # + 0 outside 0 short
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 0.500000" "0.100000" # + 0 outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.600000 -z 0.500000" "0.100000" # + 0 outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.600000 -z 0.500000" "0.100000" # + 0 outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.100000 -y 0.500000" "0.100000" # + 0 outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.100000 -y 0.500000" "0.100000" # + 0 outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.600000" "0.100000" # + 0 outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.600000" "0.100000" # + 0 outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 0.200000" "-0.100000" # + 0 inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 0.200000" "-0.100000" # + 0 inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.400000 -z 0.200000" "-0.100000" # + 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.400000 -z 0.200000" "-0.100000" # + 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.900000 -y 0.500000 -z -0.300000" "-0.100000" # + 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.900000 -y 0.500000 -z -0.300000" "-0.100000" # + 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.400000 -z -0.300000" "-0.100000" # + 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.400000 -z -0.300000" "-0.100000" # + 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.800000 -y 0.500000 -z 0.100000" "-0.100000" # + 0 inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.800000 -y 0.500000 -z 0.100000" "-0.100000" # + 0 inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.300000 -z 0.100000" "-0.100000" # + 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.300000 -z 0.100000" "-0.100000" # + 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.800000 -y 0.500000 -z -0.400000" "-0.100000" # + 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.800000 -y 0.500000 -z -0.400000" "-0.100000" # + 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.300000 -z -0.400000" "-0.100000" # + 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.300000 -z -0.400000" "-0.100000" # + 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 0.100000" "0.100000" # + 0 outside - inside short
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 0.100000" "0.100000" # + 0 outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.600000 -z 0.100000" "0.100000" # + 0 outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.600000 -z 0.100000" "0.100000" # + 0 outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.100000 -y 0.500000 -z -0.400000" "0.100000" # + 0 outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.100000 -y 0.500000 -z -0.400000" "0.100000" # + 0 outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.600000 -z -0.400000" "0.100000" # + 0 outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.600000 -z -0.400000" "0.100000" # + 0 outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z -0.100000" "0.100000" # + 0 inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z -0.100000" "0.100000" # + 0 inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.400000 -z -0.100000" "0.100000" # + 0 inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.400000 -z -0.100000" "0.100000" # + 0 inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.900000 -y 0.500000 -z -0.600000" "0.100000" # + 0 inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.900000 -y 0.500000 -z -0.600000" "0.100000" # + 0 inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.400000 -z -0.600000" "0.100000" # + 0 inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.400000 -z -0.600000" "0.100000" # + 0 inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z -0.200000" "0.223607" # + 0 outside - outside short
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z -0.200000" "0.223607" # + 0 outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.600000 -z -0.200000" "0.223607" # + 0 outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.600000 -z -0.200000" "0.223607" # + 0 outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.100000 -y 0.500000 -z -0.700000" "0.223607" # + 0 outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.100000 -y 0.500000 -z -0.700000" "0.223607" # + 0 outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.600000 -z -0.700000" "0.223607" # + 0 outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.600000 -z -0.700000" "0.223607" # + 0 outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 0.800000" "-0.100000" # + 0 inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 0.800000" "-0.100000" # + 0 inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.400000 -z 0.800000" "-0.100000" # + 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.400000 -z 0.800000" "-0.100000" # + 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.900000 -y 0.500000 -z 0.300000" "-0.100000" # + 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.900000 -y 0.500000 -z 0.300000" "-0.100000" # + 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.400000 -z 0.300000" "-0.100000" # + 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.400000 -z 0.300000" "-0.100000" # + 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.800000 -y 0.500000 -z 0.900000" "-0.100000" # + 0 inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.800000 -y 0.500000 -z 0.900000" "-0.100000" # + 0 inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.300000 -z 0.900000" "-0.100000" # + 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.300000 -z 0.900000" "-0.100000" # + 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.800000 -y 0.500000 -z 0.400000" "-0.100000" # + 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.800000 -y 0.500000 -z 0.400000" "-0.100000" # + 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.300000 -z 0.400000" "-0.100000" # + 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.300000 -z 0.400000" "-0.100000" # + 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 0.900000" "0.100000" # + 0 outside + inside short
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 0.900000" "0.100000" # + 0 outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.600000 -z 0.900000" "0.100000" # + 0 outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.600000 -z 0.900000" "0.100000" # + 0 outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.100000 -y 0.500000 -z 0.400000" "0.100000" # + 0 outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.100000 -y 0.500000 -z 0.400000" "0.100000" # + 0 outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.600000 -z 0.400000" "0.100000" # + 0 outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.600000 -z 0.400000" "0.100000" # + 0 outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 1.100000" "0.100000" # + 0 inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.900000 -y 0.500000 -z 1.100000" "0.100000" # + 0 inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.400000 -z 1.100000" "0.100000" # + 0 inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.400000 -z 1.100000" "0.100000" # + 0 inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.900000 -y 0.500000 -z 0.600000" "0.100000" # + 0 inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.900000 -y 0.500000 -z 0.600000" "0.100000" # + 0 inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.400000 -z 0.600000" "0.100000" # + 0 inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.400000 -z 0.600000" "0.100000" # + 0 inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 1.200000" "0.223607" # + 0 outside + outside short
  check_successful "bin/cylinder | bin/sample -x 1.100000 -y 0.500000 -z 1.200000" "0.223607" # + 0 outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.600000 -z 1.200000" "0.223607" # + 0 outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.600000 -z 1.200000" "0.223607" # + 0 outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.100000 -y 0.500000 -z 0.700000" "0.223607" # + 0 outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.100000 -y 0.500000 -z 0.700000" "0.223607" # + 0 outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.600000 -z 0.700000" "0.223607" # + 0 outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.600000 -z 0.700000" "0.223607" # + 0 outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 0.500000" "-0.100000" # - - inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 0.500000" "-0.100000" # - - inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y -0.216121 -z 0.500000" "-0.100000" # - - inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 0.500000" "-0.100000" # - - inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.283879" "-0.100000" # - - inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.283879" "-0.100000" # - - inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y -0.216121" "-0.100000" # - - inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121" "-0.100000" # - - inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 0.500000" "0.100000" # - - outside 0 short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 0.500000" "0.100000" # - - outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y -0.324181 -z 0.500000" "0.100000" # - - outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 0.500000" "0.100000" # - - outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.175819" "0.100000" # - - outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.175819" "0.100000" # - - outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y -0.324181" "0.100000" # - - outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181" "0.100000" # - - outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 0.200000" "-0.100000" # - - inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 0.200000" "-0.100000" # - - inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y -0.216121 -z 0.200000" "-0.100000" # - - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 0.200000" "-0.100000" # - - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.283879 -z -0.300000" "-0.100000" # - - inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.283879 -z -0.300000" "-0.100000" # - - inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z -0.300000" "-0.100000" # - - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z -0.300000" "-0.100000" # - - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.337909 -z 0.100000" "-0.100000" # - - inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.337909 -z 0.100000" "-0.100000" # - - inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.252441 -y -0.162091 -z 0.100000" "-0.100000" # - - inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.252441 -y -0.162091 -z 0.100000" "-0.100000" # - - inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.247559 -y 0.337909 -z -0.400000" "-0.100000" # - - inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.247559 -y 0.337909 -z -0.400000" "-0.100000" # - - inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.252441 -y -0.162091 -z -0.400000" "-0.100000" # - - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.252441 -y -0.162091 -z -0.400000" "-0.100000" # - - inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 0.100000" "0.100000" # - - outside - inside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 0.100000" "0.100000" # - - outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y -0.324181 -z 0.100000" "0.100000" # - - outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 0.100000" "0.100000" # - - outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.175819 -z -0.400000" "0.100000" # - - outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.175819 -z -0.400000" "0.100000" # - - outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z -0.400000" "0.100000" # - - outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z -0.400000" "0.100000" # - - outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z -0.100000" "0.100000" # - - inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z -0.100000" "0.100000" # - - inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y -0.216121 -z -0.100000" "0.100000" # - - inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y -0.216121 -z -0.100000" "0.100000" # - - inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.283879 -z -0.600000" "0.100000" # - - inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.283879 -z -0.600000" "0.100000" # - - inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z -0.600000" "0.100000" # - - inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z -0.600000" "0.100000" # - - inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z -0.200000" "0.223607" # - - outside - outside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z -0.200000" "0.223607" # - - outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y -0.324181 -z -0.200000" "0.223607" # - - outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y -0.324181 -z -0.200000" "0.223607" # - - outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.175819 -z -0.700000" "0.223607" # - - outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.175819 -z -0.700000" "0.223607" # - - outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z -0.700000" "0.223607" # - - outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z -0.700000" "0.223607" # - - outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 0.800000" "-0.100000" # - - inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 0.800000" "-0.100000" # - - inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y -0.216121 -z 0.800000" "-0.100000" # - - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 0.800000" "-0.100000" # - - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.283879 -z 0.300000" "-0.100000" # - - inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.283879 -z 0.300000" "-0.100000" # - - inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z 0.300000" "-0.100000" # - - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z 0.300000" "-0.100000" # - - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.337909 -z 0.900000" "-0.100000" # - - inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.337909 -z 0.900000" "-0.100000" # - - inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.252441 -y -0.162091 -z 0.900000" "-0.100000" # - - inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.252441 -y -0.162091 -z 0.900000" "-0.100000" # - - inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.247559 -y 0.337909 -z 0.400000" "-0.100000" # - - inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.247559 -y 0.337909 -z 0.400000" "-0.100000" # - - inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.252441 -y -0.162091 -z 0.400000" "-0.100000" # - - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.252441 -y -0.162091 -z 0.400000" "-0.100000" # - - inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 0.900000" "0.100000" # - - outside + inside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 0.900000" "0.100000" # - - outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y -0.324181 -z 0.900000" "0.100000" # - - outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 0.900000" "0.100000" # - - outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.175819 -z 0.400000" "0.100000" # - - outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.175819 -z 0.400000" "0.100000" # - - outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z 0.400000" "0.100000" # - - outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z 0.400000" "0.100000" # - - outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 1.100000" "0.100000" # - - inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.283879 -z 1.100000" "0.100000" # - - inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y -0.216121 -z 1.100000" "0.100000" # - - inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 1.100000" "0.100000" # - - inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.283879 -z 0.600000" "0.100000" # - - inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.283879 -z 0.600000" "0.100000" # - - inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z 0.600000" "0.100000" # - - inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z 0.600000" "0.100000" # - - inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 1.200000" "0.223607" # - - outside + outside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.175819 -z 1.200000" "0.223607" # - - outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y -0.324181 -z 1.200000" "0.223607" # - - outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 1.200000" "0.223607" # - - outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.175819 -z 0.700000" "0.223607" # - - outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.175819 -z 0.700000" "0.223607" # - - outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z 0.700000" "0.223607" # - - outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z 0.700000" "0.223607" # - - outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 0.500000" "-0.100000" # - + inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 0.500000" "-0.100000" # - + inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y 0.216121 -z 0.500000" "-0.100000" # - + inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 0.500000" "-0.100000" # - + inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.716121" "-0.100000" # - + inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.716121" "-0.100000" # - + inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y 0.216121" "-0.100000" # - + inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121" "-0.100000" # - + inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 0.500000" "0.100000" # - + outside 0 short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 0.500000" "0.100000" # - + outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y 0.324181 -z 0.500000" "0.100000" # - + outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 0.500000" "0.100000" # - + outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.824181" "0.100000" # - + outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.824181" "0.100000" # - + outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y 0.324181" "0.100000" # - + outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181" "0.100000" # - + outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 0.200000" "-0.100000" # - + inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 0.200000" "-0.100000" # - + inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y 0.216121 -z 0.200000" "-0.100000" # - + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 0.200000" "-0.100000" # - + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.716121 -z -0.300000" "-0.100000" # - + inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.716121 -z -0.300000" "-0.100000" # - + inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z -0.300000" "-0.100000" # - + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z -0.300000" "-0.100000" # - + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.662091 -z 0.100000" "-0.100000" # - + inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.662091 -z 0.100000" "-0.100000" # - + inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.252441 -y 0.162091 -z 0.100000" "-0.100000" # - + inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.252441 -y 0.162091 -z 0.100000" "-0.100000" # - + inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.247559 -y 0.662091 -z -0.400000" "-0.100000" # - + inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.247559 -y 0.662091 -z -0.400000" "-0.100000" # - + inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.252441 -y 0.162091 -z -0.400000" "-0.100000" # - + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.252441 -y 0.162091 -z -0.400000" "-0.100000" # - + inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 0.100000" "0.100000" # - + outside - inside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 0.100000" "0.100000" # - + outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y 0.324181 -z 0.100000" "0.100000" # - + outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 0.100000" "0.100000" # - + outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.824181 -z -0.400000" "0.100000" # - + outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.824181 -z -0.400000" "0.100000" # - + outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z -0.400000" "0.100000" # - + outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z -0.400000" "0.100000" # - + outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z -0.100000" "0.100000" # - + inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z -0.100000" "0.100000" # - + inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y 0.216121 -z -0.100000" "0.100000" # - + inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y 0.216121 -z -0.100000" "0.100000" # - + inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.716121 -z -0.600000" "0.100000" # - + inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.716121 -z -0.600000" "0.100000" # - + inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z -0.600000" "0.100000" # - + inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z -0.600000" "0.100000" # - + inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z -0.200000" "0.223607" # - + outside - outside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z -0.200000" "0.223607" # - + outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y 0.324181 -z -0.200000" "0.223607" # - + outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y 0.324181 -z -0.200000" "0.223607" # - + outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.824181 -z -0.700000" "0.223607" # - + outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.824181 -z -0.700000" "0.223607" # - + outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z -0.700000" "0.223607" # - + outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z -0.700000" "0.223607" # - + outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 0.800000" "-0.100000" # - + inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 0.800000" "-0.100000" # - + inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y 0.216121 -z 0.800000" "-0.100000" # - + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 0.800000" "-0.100000" # - + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.716121 -z 0.300000" "-0.100000" # - + inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.716121 -z 0.300000" "-0.100000" # - + inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z 0.300000" "-0.100000" # - + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z 0.300000" "-0.100000" # - + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.662091 -z 0.900000" "-0.100000" # - + inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.247559 -y 0.662091 -z 0.900000" "-0.100000" # - + inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.252441 -y 0.162091 -z 0.900000" "-0.100000" # - + inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.252441 -y 0.162091 -z 0.900000" "-0.100000" # - + inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.247559 -y 0.662091 -z 0.400000" "-0.100000" # - + inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.247559 -y 0.662091 -z 0.400000" "-0.100000" # - + inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.252441 -y 0.162091 -z 0.400000" "-0.100000" # - + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.252441 -y 0.162091 -z 0.400000" "-0.100000" # - + inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 0.900000" "0.100000" # - + outside + inside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 0.900000" "0.100000" # - + outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y 0.324181 -z 0.900000" "0.100000" # - + outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 0.900000" "0.100000" # - + outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.824181 -z 0.400000" "0.100000" # - + outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.824181 -z 0.400000" "0.100000" # - + outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z 0.400000" "0.100000" # - + outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z 0.400000" "0.100000" # - + outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 1.100000" "0.100000" # - + inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.163412 -y 0.716121 -z 1.100000" "0.100000" # - + inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.336588 -y 0.216121 -z 1.100000" "0.100000" # - + inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 1.100000" "0.100000" # - + inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.163412 -y 0.716121 -z 0.600000" "0.100000" # - + inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.163412 -y 0.716121 -z 0.600000" "0.100000" # - + inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z 0.600000" "0.100000" # - + inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z 0.600000" "0.100000" # - + inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 1.200000" "0.223607" # - + outside + outside short
  check_successful "bin/cylinder | bin/sample -x -0.004883 -y 0.824181 -z 1.200000" "0.223607" # - + outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x -0.504883 -y 0.324181 -z 1.200000" "0.223607" # - + outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 1.200000" "0.223607" # - + outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x -0.004883 -y 0.824181 -z 0.700000" "0.223607" # - + outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x -0.004883 -y 0.824181 -z 0.700000" "0.223607" # - + outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z 0.700000" "0.223607" # - + outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z 0.700000" "0.223607" # - + outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 0.500000" "-0.100000" # + - inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 0.500000" "-0.100000" # + - inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y -0.216121 -z 0.500000" "-0.100000" # + - inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 0.500000" "-0.100000" # + - inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.283879" "-0.100000" # + - inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.283879" "-0.100000" # + - inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y -0.216121" "-0.100000" # + - inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121" "-0.100000" # + - inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 0.500000" "0.100000" # + - outside 0 short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 0.500000" "0.100000" # + - outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y -0.324181 -z 0.500000" "0.100000" # + - outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 0.500000" "0.100000" # + - outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.175819" "0.100000" # + - outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.175819" "0.100000" # + - outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y -0.324181" "0.100000" # + - outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181" "0.100000" # + - outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 0.200000" "-0.100000" # + - inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 0.200000" "-0.100000" # + - inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y -0.216121 -z 0.200000" "-0.100000" # + - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 0.200000" "-0.100000" # + - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.283879 -z -0.300000" "-0.100000" # + - inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.283879 -z -0.300000" "-0.100000" # + - inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z -0.300000" "-0.100000" # + - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z -0.300000" "-0.100000" # + - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.337909 -z 0.100000" "-0.100000" # + - inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.337909 -z 0.100000" "-0.100000" # + - inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.252441 -y -0.162091 -z 0.100000" "-0.100000" # + - inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.252441 -y -0.162091 -z 0.100000" "-0.100000" # + - inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.752441 -y 0.337909 -z -0.400000" "-0.100000" # + - inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.752441 -y 0.337909 -z -0.400000" "-0.100000" # + - inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.252441 -y -0.162091 -z -0.400000" "-0.100000" # + - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.252441 -y -0.162091 -z -0.400000" "-0.100000" # + - inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 0.100000" "0.100000" # + - outside - inside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 0.100000" "0.100000" # + - outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y -0.324181 -z 0.100000" "0.100000" # + - outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 0.100000" "0.100000" # + - outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.175819 -z -0.400000" "0.100000" # + - outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.175819 -z -0.400000" "0.100000" # + - outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z -0.400000" "0.100000" # + - outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z -0.400000" "0.100000" # + - outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z -0.100000" "0.100000" # + - inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z -0.100000" "0.100000" # + - inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y -0.216121 -z -0.100000" "0.100000" # + - inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y -0.216121 -z -0.100000" "0.100000" # + - inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.283879 -z -0.600000" "0.100000" # + - inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.283879 -z -0.600000" "0.100000" # + - inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z -0.600000" "0.100000" # + - inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z -0.600000" "0.100000" # + - inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z -0.200000" "0.223607" # + - outside - outside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z -0.200000" "0.223607" # + - outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y -0.324181 -z -0.200000" "0.223607" # + - outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y -0.324181 -z -0.200000" "0.223607" # + - outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.175819 -z -0.700000" "0.223607" # + - outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.175819 -z -0.700000" "0.223607" # + - outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z -0.700000" "0.223607" # + - outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z -0.700000" "0.223607" # + - outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 0.800000" "-0.100000" # + - inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 0.800000" "-0.100000" # + - inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y -0.216121 -z 0.800000" "-0.100000" # + - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 0.800000" "-0.100000" # + - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.283879 -z 0.300000" "-0.100000" # + - inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.283879 -z 0.300000" "-0.100000" # + - inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z 0.300000" "-0.100000" # + - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z 0.300000" "-0.100000" # + - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.337909 -z 0.900000" "-0.100000" # + - inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.337909 -z 0.900000" "-0.100000" # + - inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.252441 -y -0.162091 -z 0.900000" "-0.100000" # + - inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.252441 -y -0.162091 -z 0.900000" "-0.100000" # + - inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.752441 -y 0.337909 -z 0.400000" "-0.100000" # + - inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.752441 -y 0.337909 -z 0.400000" "-0.100000" # + - inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.252441 -y -0.162091 -z 0.400000" "-0.100000" # + - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.252441 -y -0.162091 -z 0.400000" "-0.100000" # + - inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 0.900000" "0.100000" # + - outside + inside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 0.900000" "0.100000" # + - outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y -0.324181 -z 0.900000" "0.100000" # + - outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 0.900000" "0.100000" # + - outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.175819 -z 0.400000" "0.100000" # + - outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.175819 -z 0.400000" "0.100000" # + - outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z 0.400000" "0.100000" # + - outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z 0.400000" "0.100000" # + - outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 1.100000" "0.100000" # + - inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.283879 -z 1.100000" "0.100000" # + - inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y -0.216121 -z 1.100000" "0.100000" # + - inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 1.100000" "0.100000" # + - inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.283879 -z 0.600000" "0.100000" # + - inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.283879 -z 0.600000" "0.100000" # + - inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z 0.600000" "0.100000" # + - inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z 0.600000" "0.100000" # + - inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 1.200000" "0.223607" # + - outside + outside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.175819 -z 1.200000" "0.223607" # + - outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y -0.324181 -z 1.200000" "0.223607" # + - outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 1.200000" "0.223607" # + - outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.175819 -z 0.700000" "0.223607" # + - outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.175819 -z 0.700000" "0.223607" # + - outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z 0.700000" "0.223607" # + - outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z 0.700000" "0.223607" # + - outside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 0.500000" "-0.100000" # + + inside 0 short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 0.500000" "-0.100000" # + + inside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y 0.216121 -z 0.500000" "-0.100000" # + + inside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 0.500000" "-0.100000" # + + inside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.716121" "-0.100000" # + + inside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.716121" "-0.100000" # + + inside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y 0.216121" "-0.100000" # + + inside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121" "-0.100000" # + + inside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 0.500000" "0.100000" # + + outside 0 short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 0.500000" "0.100000" # + + outside 0 long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y 0.324181 -z 0.500000" "0.100000" # + + outside 0 center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 0.500000" "0.100000" # + + outside 0 center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.824181" "0.100000" # + + outside 0 center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.824181" "0.100000" # + + outside 0 center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y 0.324181" "0.100000" # + + outside 0 center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181" "0.100000" # + + outside 0 center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 0.200000" "-0.100000" # + + inside - inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 0.200000" "-0.100000" # + + inside - inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y 0.216121 -z 0.200000" "-0.100000" # + + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 0.200000" "-0.100000" # + + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.716121 -z -0.300000" "-0.100000" # + + inside - inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.716121 -z -0.300000" "-0.100000" # + + inside - inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z -0.300000" "-0.100000" # + + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z -0.300000" "-0.100000" # + + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.662091 -z 0.100000" "-0.100000" # + + inside - inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.662091 -z 0.100000" "-0.100000" # + + inside - inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.252441 -y 0.162091 -z 0.100000" "-0.100000" # + + inside - inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.252441 -y 0.162091 -z 0.100000" "-0.100000" # + + inside - inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.752441 -y 0.662091 -z -0.400000" "-0.100000" # + + inside - inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.752441 -y 0.662091 -z -0.400000" "-0.100000" # + + inside - inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.252441 -y 0.162091 -z -0.400000" "-0.100000" # + + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.252441 -y 0.162091 -z -0.400000" "-0.100000" # + + inside - inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 0.100000" "0.100000" # + + outside - inside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 0.100000" "0.100000" # + + outside - inside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y 0.324181 -z 0.100000" "0.100000" # + + outside - inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 0.100000" "0.100000" # + + outside - inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.824181 -z -0.400000" "0.100000" # + + outside - inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.824181 -z -0.400000" "0.100000" # + + outside - inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z -0.400000" "0.100000" # + + outside - inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z -0.400000" "0.100000" # + + outside - inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z -0.100000" "0.100000" # + + inside - outside short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z -0.100000" "0.100000" # + + inside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y 0.216121 -z -0.100000" "0.100000" # + + inside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y 0.216121 -z -0.100000" "0.100000" # + + inside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.716121 -z -0.600000" "0.100000" # + + inside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.716121 -z -0.600000" "0.100000" # + + inside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z -0.600000" "0.100000" # + + inside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z -0.600000" "0.100000" # + + inside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z -0.200000" "0.223607" # + + outside - outside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z -0.200000" "0.223607" # + + outside - outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y 0.324181 -z -0.200000" "0.223607" # + + outside - outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y 0.324181 -z -0.200000" "0.223607" # + + outside - outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.824181 -z -0.700000" "0.223607" # + + outside - outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.824181 -z -0.700000" "0.223607" # + + outside - outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z -0.700000" "0.223607" # + + outside - outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z -0.700000" "0.223607" # + + outside - outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 0.800000" "-0.100000" # + + inside + inside closer to xy short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 0.800000" "-0.100000" # + + inside + inside closer to xy long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y 0.216121 -z 0.800000" "-0.100000" # + + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 0.800000" "-0.100000" # + + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.716121 -z 0.300000" "-0.100000" # + + inside + inside closer to xy center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.716121 -z 0.300000" "-0.100000" # + + inside + inside closer to xy center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z 0.300000" "-0.100000" # + + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z 0.300000" "-0.100000" # + + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.662091 -z 0.900000" "-0.100000" # + + inside + inside closer to z short
  check_successful "bin/cylinder | bin/sample -x 0.752441 -y 0.662091 -z 0.900000" "-0.100000" # + + inside + inside closer to z long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.252441 -y 0.162091 -z 0.900000" "-0.100000" # + + inside + inside closer to z center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.252441 -y 0.162091 -z 0.900000" "-0.100000" # + + inside + inside closer to z center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.752441 -y 0.662091 -z 0.400000" "-0.100000" # + + inside + inside closer to z center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.752441 -y 0.662091 -z 0.400000" "-0.100000" # + + inside + inside closer to z center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.252441 -y 0.162091 -z 0.400000" "-0.100000" # + + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.252441 -y 0.162091 -z 0.400000" "-0.100000" # + + inside + inside closer to z center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 0.900000" "0.100000" # + + outside + inside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 0.900000" "0.100000" # + + outside + inside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y 0.324181 -z 0.900000" "0.100000" # + + outside + inside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 0.900000" "0.100000" # + + outside + inside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.824181 -z 0.400000" "0.100000" # + + outside + inside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.824181 -z 0.400000" "0.100000" # + + outside + inside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z 0.400000" "0.100000" # + + outside + inside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z 0.400000" "0.100000" # + + outside + inside center xyz long
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 1.100000" "0.100000" # + + inside + outside short
  check_successful "bin/cylinder | bin/sample -x 0.836588 -y 0.716121 -z 1.100000" "0.100000" # + + inside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.336588 -y 0.216121 -z 1.100000" "0.100000" # + + inside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 1.100000" "0.100000" # + + inside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 0.836588 -y 0.716121 -z 0.600000" "0.100000" # + + inside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 0.836588 -y 0.716121 -z 0.600000" "0.100000" # + + inside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z 0.600000" "0.100000" # + + inside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z 0.600000" "0.100000" # + + inside + outside center xyz long
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 1.200000" "0.223607" # + + outside + outside short
  check_successful "bin/cylinder | bin/sample -x 1.004883 -y 0.824181 -z 1.200000" "0.223607" # + + outside + outside long
  check_successful "bin/cylinder -cxy | bin/sample -x 0.504883 -y 0.324181 -z 1.200000" "0.223607" # + + outside + outside center xy short
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 1.200000" "0.223607" # + + outside + outside center xy long
  check_successful "bin/cylinder -cz | bin/sample -x 1.004883 -y 0.824181 -z 0.700000" "0.223607" # + + outside + outside center z short
  check_successful "bin/cylinder --center-z | bin/sample -x 1.004883 -y 0.824181 -z 0.700000" "0.223607" # + + outside + outside center z long
  check_successful "bin/cylinder -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z 0.700000" "0.223607" # + + outside + outside center xyz short
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z 0.700000" "0.223607" # + + outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.500000 -z 0.100000" "-0.100000" # size z 0 0 - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.500000 -z 0.100000" "-0.100000" # size z 0 0 - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -z 0.100000" "-0.100000" # size z 0 0 - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -z 0.100000" "-0.100000" # size z 0 0 - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.500000 -z -1.400000" "-0.100000" # size z 0 0 - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.500000 -z -1.400000" "-0.100000" # size z 0 0 - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -z -1.400000" "-0.100000" # size z 0 0 - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -z -1.400000" "-0.100000" # size z 0 0 - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.500000 -z -0.100000" "0.100000" # size z 0 0 - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.500000 -z -0.100000" "0.100000" # size z 0 0 - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -z -0.100000" "0.100000" # size z 0 0 - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -z -0.100000" "0.100000" # size z 0 0 - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.500000 -z -1.600000" "0.100000" # size z 0 0 - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.500000 -z -1.600000" "0.100000" # size z 0 0 - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -z -1.600000" "0.100000" # size z 0 0 - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -z -1.600000" "0.100000" # size z 0 0 - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.500000 -z 2.900000" "-0.100000" # size z 0 0 + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.500000 -z 2.900000" "-0.100000" # size z 0 0 + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -z 2.900000" "-0.100000" # size z 0 0 + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -z 2.900000" "-0.100000" # size z 0 0 + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.500000 -z 1.400000" "-0.100000" # size z 0 0 + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.500000 -z 1.400000" "-0.100000" # size z 0 0 + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -z 1.400000" "-0.100000" # size z 0 0 + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -z 1.400000" "-0.100000" # size z 0 0 + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.500000 -z 3.100000" "0.100000" # size z 0 0 + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.500000 -z 3.100000" "0.100000" # size z 0 0 + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -z 3.100000" "0.100000" # size z 0 0 + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -z 3.100000" "0.100000" # size z 0 0 + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.500000 -z 1.600000" "0.100000" # size z 0 0 + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.500000 -z 1.600000" "0.100000" # size z 0 0 + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -z 1.600000" "0.100000" # size z 0 0 + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -z 1.600000" "0.100000" # size z 0 0 + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.100000 -z 1.500000" "-0.100000" # size z 0 - inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.100000 -z 1.500000" "-0.100000" # size z 0 - inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.400000 -z 1.500000" "-0.100000" # size z 0 - inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.400000 -z 1.500000" "-0.100000" # size z 0 - inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.100000" "-0.100000" # size z 0 - inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.100000" "-0.100000" # size z 0 - inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.400000" "-0.100000" # size z 0 - inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.400000" "-0.100000" # size z 0 - inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y -0.100000 -z 1.500000" "0.100000" # size z 0 - outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y -0.100000 -z 1.500000" "0.100000" # size z 0 - outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.600000 -z 1.500000" "0.100000" # size z 0 - outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.600000 -z 1.500000" "0.100000" # size z 0 - outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y -0.100000" "0.100000" # size z 0 - outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y -0.100000" "0.100000" # size z 0 - outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.600000" "0.100000" # size z 0 - outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.600000" "0.100000" # size z 0 - outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.100000 -z 0.200000" "-0.100000" # size z 0 - inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.100000 -z 0.200000" "-0.100000" # size z 0 - inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.400000 -z 0.200000" "-0.100000" # size z 0 - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.400000 -z 0.200000" "-0.100000" # size z 0 - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.100000 -z -1.300000" "-0.100000" # size z 0 - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.100000 -z -1.300000" "-0.100000" # size z 0 - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.400000 -z -1.300000" "-0.100000" # size z 0 - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.400000 -z -1.300000" "-0.100000" # size z 0 - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.200000 -z 0.100000" "-0.100000" # size z 0 - inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.200000 -z 0.100000" "-0.100000" # size z 0 - inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.300000 -z 0.100000" "-0.100000" # size z 0 - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.300000 -z 0.100000" "-0.100000" # size z 0 - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.200000 -z -1.400000" "-0.100000" # size z 0 - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.200000 -z -1.400000" "-0.100000" # size z 0 - inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.300000 -z -1.400000" "-0.100000" # size z 0 - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.300000 -z -1.400000" "-0.100000" # size z 0 - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y -0.100000 -z 0.100000" "0.100000" # size z 0 - outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y -0.100000 -z 0.100000" "0.100000" # size z 0 - outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.600000 -z 0.100000" "0.100000" # size z 0 - outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.600000 -z 0.100000" "0.100000" # size z 0 - outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y -0.100000 -z -1.400000" "0.100000" # size z 0 - outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y -0.100000 -z -1.400000" "0.100000" # size z 0 - outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.600000 -z -1.400000" "0.100000" # size z 0 - outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.600000 -z -1.400000" "0.100000" # size z 0 - outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.100000 -z -0.100000" "0.100000" # size z 0 - inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.100000 -z -0.100000" "0.100000" # size z 0 - inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.400000 -z -0.100000" "0.100000" # size z 0 - inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.400000 -z -0.100000" "0.100000" # size z 0 - inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.100000 -z -1.600000" "0.100000" # size z 0 - inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.100000 -z -1.600000" "0.100000" # size z 0 - inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.400000 -z -1.600000" "0.100000" # size z 0 - inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.400000 -z -1.600000" "0.100000" # size z 0 - inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y -0.100000 -z -0.200000" "0.223607" # size z 0 - outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y -0.100000 -z -0.200000" "0.223607" # size z 0 - outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.600000 -z -0.200000" "0.223607" # size z 0 - outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.600000 -z -0.200000" "0.223607" # size z 0 - outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y -0.100000 -z -1.700000" "0.223607" # size z 0 - outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y -0.100000 -z -1.700000" "0.223607" # size z 0 - outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.600000 -z -1.700000" "0.223607" # size z 0 - outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.600000 -z -1.700000" "0.223607" # size z 0 - outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.100000 -z 2.800000" "-0.100000" # size z 0 - inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.100000 -z 2.800000" "-0.100000" # size z 0 - inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.400000 -z 2.800000" "-0.100000" # size z 0 - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.400000 -z 2.800000" "-0.100000" # size z 0 - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.100000 -z 1.300000" "-0.100000" # size z 0 - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.100000 -z 1.300000" "-0.100000" # size z 0 - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.400000 -z 1.300000" "-0.100000" # size z 0 - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.400000 -z 1.300000" "-0.100000" # size z 0 - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.200000 -z 2.900000" "-0.100000" # size z 0 - inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.200000 -z 2.900000" "-0.100000" # size z 0 - inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.300000 -z 2.900000" "-0.100000" # size z 0 - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.300000 -z 2.900000" "-0.100000" # size z 0 - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.200000 -z 1.400000" "-0.100000" # size z 0 - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.200000 -z 1.400000" "-0.100000" # size z 0 - inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.300000 -z 1.400000" "-0.100000" # size z 0 - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.300000 -z 1.400000" "-0.100000" # size z 0 - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y -0.100000 -z 2.900000" "0.100000" # size z 0 - outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y -0.100000 -z 2.900000" "0.100000" # size z 0 - outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.600000 -z 2.900000" "0.100000" # size z 0 - outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.600000 -z 2.900000" "0.100000" # size z 0 - outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y -0.100000 -z 1.400000" "0.100000" # size z 0 - outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y -0.100000 -z 1.400000" "0.100000" # size z 0 - outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.600000 -z 1.400000" "0.100000" # size z 0 - outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.600000 -z 1.400000" "0.100000" # size z 0 - outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.100000 -z 3.100000" "0.100000" # size z 0 - inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.100000 -z 3.100000" "0.100000" # size z 0 - inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.400000 -z 3.100000" "0.100000" # size z 0 - inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.400000 -z 3.100000" "0.100000" # size z 0 - inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.100000 -z 1.600000" "0.100000" # size z 0 - inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.100000 -z 1.600000" "0.100000" # size z 0 - inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.400000 -z 1.600000" "0.100000" # size z 0 - inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.400000 -z 1.600000" "0.100000" # size z 0 - inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y -0.100000 -z 3.200000" "0.223607" # size z 0 - outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y -0.100000 -z 3.200000" "0.223607" # size z 0 - outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y -0.600000 -z 3.200000" "0.223607" # size z 0 - outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y -0.600000 -z 3.200000" "0.223607" # size z 0 - outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y -0.100000 -z 1.700000" "0.223607" # size z 0 - outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y -0.100000 -z 1.700000" "0.223607" # size z 0 - outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y -0.600000 -z 1.700000" "0.223607" # size z 0 - outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y -0.600000 -z 1.700000" "0.223607" # size z 0 - outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.900000 -z 1.500000" "-0.100000" # size z 0 + inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.900000 -z 1.500000" "-0.100000" # size z 0 + inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.400000 -z 1.500000" "-0.100000" # size z 0 + inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.400000 -z 1.500000" "-0.100000" # size z 0 + inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.900000" "-0.100000" # size z 0 + inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.900000" "-0.100000" # size z 0 + inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.400000" "-0.100000" # size z 0 + inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.400000" "-0.100000" # size z 0 + inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 1.100000 -z 1.500000" "0.100000" # size z 0 + outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 1.100000 -z 1.500000" "0.100000" # size z 0 + outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.600000 -z 1.500000" "0.100000" # size z 0 + outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.600000 -z 1.500000" "0.100000" # size z 0 + outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 1.100000" "0.100000" # size z 0 + outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 1.100000" "0.100000" # size z 0 + outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.600000" "0.100000" # size z 0 + outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.600000" "0.100000" # size z 0 + outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.900000 -z 0.200000" "-0.100000" # size z 0 + inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.900000 -z 0.200000" "-0.100000" # size z 0 + inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.400000 -z 0.200000" "-0.100000" # size z 0 + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.400000 -z 0.200000" "-0.100000" # size z 0 + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.900000 -z -1.300000" "-0.100000" # size z 0 + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.900000 -z -1.300000" "-0.100000" # size z 0 + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.400000 -z -1.300000" "-0.100000" # size z 0 + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.400000 -z -1.300000" "-0.100000" # size z 0 + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.800000 -z 0.100000" "-0.100000" # size z 0 + inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.800000 -z 0.100000" "-0.100000" # size z 0 + inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.300000 -z 0.100000" "-0.100000" # size z 0 + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.300000 -z 0.100000" "-0.100000" # size z 0 + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.800000 -z -1.400000" "-0.100000" # size z 0 + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.800000 -z -1.400000" "-0.100000" # size z 0 + inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.300000 -z -1.400000" "-0.100000" # size z 0 + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.300000 -z -1.400000" "-0.100000" # size z 0 + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 1.100000 -z 0.100000" "0.100000" # size z 0 + outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 1.100000 -z 0.100000" "0.100000" # size z 0 + outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.600000 -z 0.100000" "0.100000" # size z 0 + outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.600000 -z 0.100000" "0.100000" # size z 0 + outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 1.100000 -z -1.400000" "0.100000" # size z 0 + outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 1.100000 -z -1.400000" "0.100000" # size z 0 + outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.600000 -z -1.400000" "0.100000" # size z 0 + outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.600000 -z -1.400000" "0.100000" # size z 0 + outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.900000 -z -0.100000" "0.100000" # size z 0 + inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.900000 -z -0.100000" "0.100000" # size z 0 + inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.400000 -z -0.100000" "0.100000" # size z 0 + inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.400000 -z -0.100000" "0.100000" # size z 0 + inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.900000 -z -1.600000" "0.100000" # size z 0 + inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.900000 -z -1.600000" "0.100000" # size z 0 + inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.400000 -z -1.600000" "0.100000" # size z 0 + inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.400000 -z -1.600000" "0.100000" # size z 0 + inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 1.100000 -z -0.200000" "0.223607" # size z 0 + outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 1.100000 -z -0.200000" "0.223607" # size z 0 + outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.600000 -z -0.200000" "0.223607" # size z 0 + outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.600000 -z -0.200000" "0.223607" # size z 0 + outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 1.100000 -z -1.700000" "0.223607" # size z 0 + outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 1.100000 -z -1.700000" "0.223607" # size z 0 + outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.600000 -z -1.700000" "0.223607" # size z 0 + outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.600000 -z -1.700000" "0.223607" # size z 0 + outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.900000 -z 2.800000" "-0.100000" # size z 0 + inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.900000 -z 2.800000" "-0.100000" # size z 0 + inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.400000 -z 2.800000" "-0.100000" # size z 0 + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.400000 -z 2.800000" "-0.100000" # size z 0 + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.900000 -z 1.300000" "-0.100000" # size z 0 + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.900000 -z 1.300000" "-0.100000" # size z 0 + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.400000 -z 1.300000" "-0.100000" # size z 0 + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.400000 -z 1.300000" "-0.100000" # size z 0 + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.800000 -z 2.900000" "-0.100000" # size z 0 + inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.800000 -z 2.900000" "-0.100000" # size z 0 + inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.300000 -z 2.900000" "-0.100000" # size z 0 + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.300000 -z 2.900000" "-0.100000" # size z 0 + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.800000 -z 1.400000" "-0.100000" # size z 0 + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.800000 -z 1.400000" "-0.100000" # size z 0 + inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.300000 -z 1.400000" "-0.100000" # size z 0 + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.300000 -z 1.400000" "-0.100000" # size z 0 + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 1.100000 -z 2.900000" "0.100000" # size z 0 + outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 1.100000 -z 2.900000" "0.100000" # size z 0 + outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.600000 -z 2.900000" "0.100000" # size z 0 + outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.600000 -z 2.900000" "0.100000" # size z 0 + outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 1.100000 -z 1.400000" "0.100000" # size z 0 + outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 1.100000 -z 1.400000" "0.100000" # size z 0 + outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.600000 -z 1.400000" "0.100000" # size z 0 + outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.600000 -z 1.400000" "0.100000" # size z 0 + outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 0.900000 -z 3.100000" "0.100000" # size z 0 + inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 0.900000 -z 3.100000" "0.100000" # size z 0 + inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.400000 -z 3.100000" "0.100000" # size z 0 + inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.400000 -z 3.100000" "0.100000" # size z 0 + inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 0.900000 -z 1.600000" "0.100000" # size z 0 + inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 0.900000 -z 1.600000" "0.100000" # size z 0 + inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.400000 -z 1.600000" "0.100000" # size z 0 + inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.400000 -z 1.600000" "0.100000" # size z 0 + inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.500000 -y 1.100000 -z 3.200000" "0.223607" # size z 0 + outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.500000 -y 1.100000 -z 3.200000" "0.223607" # size z 0 + outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -y 0.600000 -z 3.200000" "0.223607" # size z 0 + outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -y 0.600000 -z 3.200000" "0.223607" # size z 0 + outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.500000 -y 1.100000 -z 1.700000" "0.223607" # size z 0 + outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.500000 -y 1.100000 -z 1.700000" "0.223607" # size z 0 + outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -y 0.600000 -z 1.700000" "0.223607" # size z 0 + outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -y 0.600000 -z 1.700000" "0.223607" # size z 0 + outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.100000 -y 0.500000 -z 1.500000" "-0.100000" # size z - 0 inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.100000 -y 0.500000 -z 1.500000" "-0.100000" # size z - 0 inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.400000 -z 1.500000" "-0.100000" # size z - 0 inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.400000 -z 1.500000" "-0.100000" # size z - 0 inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.100000 -y 0.500000" "-0.100000" # size z - 0 inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.100000 -y 0.500000" "-0.100000" # size z - 0 inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.400000" "-0.100000" # size z - 0 inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.400000" "-0.100000" # size z - 0 inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.100000 -y 0.500000 -z 1.500000" "0.100000" # size z - 0 outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.100000 -y 0.500000 -z 1.500000" "0.100000" # size z - 0 outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.600000 -z 1.500000" "0.100000" # size z - 0 outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.600000 -z 1.500000" "0.100000" # size z - 0 outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.100000 -y 0.500000" "0.100000" # size z - 0 outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.100000 -y 0.500000" "0.100000" # size z - 0 outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.600000" "0.100000" # size z - 0 outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.600000" "0.100000" # size z - 0 outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.100000 -y 0.500000 -z 0.200000" "-0.100000" # size z - 0 inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.100000 -y 0.500000 -z 0.200000" "-0.100000" # size z - 0 inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.400000 -z 0.200000" "-0.100000" # size z - 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.400000 -z 0.200000" "-0.100000" # size z - 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.100000 -y 0.500000 -z -1.300000" "-0.100000" # size z - 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.100000 -y 0.500000 -z -1.300000" "-0.100000" # size z - 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.400000 -z -1.300000" "-0.100000" # size z - 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.400000 -z -1.300000" "-0.100000" # size z - 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.200000 -y 0.500000 -z 0.100000" "-0.100000" # size z - 0 inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.200000 -y 0.500000 -z 0.100000" "-0.100000" # size z - 0 inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.300000 -z 0.100000" "-0.100000" # size z - 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.300000 -z 0.100000" "-0.100000" # size z - 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.200000 -y 0.500000 -z -1.400000" "-0.100000" # size z - 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.200000 -y 0.500000 -z -1.400000" "-0.100000" # size z - 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.300000 -z -1.400000" "-0.100000" # size z - 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.300000 -z -1.400000" "-0.100000" # size z - 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.100000 -y 0.500000 -z 0.100000" "0.100000" # size z - 0 outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.100000 -y 0.500000 -z 0.100000" "0.100000" # size z - 0 outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.600000 -z 0.100000" "0.100000" # size z - 0 outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.600000 -z 0.100000" "0.100000" # size z - 0 outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.100000 -y 0.500000 -z -1.400000" "0.100000" # size z - 0 outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.100000 -y 0.500000 -z -1.400000" "0.100000" # size z - 0 outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.600000 -z -1.400000" "0.100000" # size z - 0 outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.600000 -z -1.400000" "0.100000" # size z - 0 outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.100000 -y 0.500000 -z -0.100000" "0.100000" # size z - 0 inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.100000 -y 0.500000 -z -0.100000" "0.100000" # size z - 0 inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.400000 -z -0.100000" "0.100000" # size z - 0 inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.400000 -z -0.100000" "0.100000" # size z - 0 inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.100000 -y 0.500000 -z -1.600000" "0.100000" # size z - 0 inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.100000 -y 0.500000 -z -1.600000" "0.100000" # size z - 0 inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.400000 -z -1.600000" "0.100000" # size z - 0 inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.400000 -z -1.600000" "0.100000" # size z - 0 inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.100000 -y 0.500000 -z -0.200000" "0.223607" # size z - 0 outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.100000 -y 0.500000 -z -0.200000" "0.223607" # size z - 0 outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.600000 -z -0.200000" "0.223607" # size z - 0 outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.600000 -z -0.200000" "0.223607" # size z - 0 outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.100000 -y 0.500000 -z -1.700000" "0.223607" # size z - 0 outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.100000 -y 0.500000 -z -1.700000" "0.223607" # size z - 0 outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.600000 -z -1.700000" "0.223607" # size z - 0 outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.600000 -z -1.700000" "0.223607" # size z - 0 outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.100000 -y 0.500000 -z 2.800000" "-0.100000" # size z - 0 inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.100000 -y 0.500000 -z 2.800000" "-0.100000" # size z - 0 inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.400000 -z 2.800000" "-0.100000" # size z - 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.400000 -z 2.800000" "-0.100000" # size z - 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.100000 -y 0.500000 -z 1.300000" "-0.100000" # size z - 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.100000 -y 0.500000 -z 1.300000" "-0.100000" # size z - 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.400000 -z 1.300000" "-0.100000" # size z - 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.400000 -z 1.300000" "-0.100000" # size z - 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.200000 -y 0.500000 -z 2.900000" "-0.100000" # size z - 0 inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.200000 -y 0.500000 -z 2.900000" "-0.100000" # size z - 0 inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.300000 -z 2.900000" "-0.100000" # size z - 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.300000 -z 2.900000" "-0.100000" # size z - 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.200000 -y 0.500000 -z 1.400000" "-0.100000" # size z - 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.200000 -y 0.500000 -z 1.400000" "-0.100000" # size z - 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.300000 -z 1.400000" "-0.100000" # size z - 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.300000 -z 1.400000" "-0.100000" # size z - 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.100000 -y 0.500000 -z 2.900000" "0.100000" # size z - 0 outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.100000 -y 0.500000 -z 2.900000" "0.100000" # size z - 0 outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.600000 -z 2.900000" "0.100000" # size z - 0 outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.600000 -z 2.900000" "0.100000" # size z - 0 outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.100000 -y 0.500000 -z 1.400000" "0.100000" # size z - 0 outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.100000 -y 0.500000 -z 1.400000" "0.100000" # size z - 0 outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.600000 -z 1.400000" "0.100000" # size z - 0 outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.600000 -z 1.400000" "0.100000" # size z - 0 outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.100000 -y 0.500000 -z 3.100000" "0.100000" # size z - 0 inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.100000 -y 0.500000 -z 3.100000" "0.100000" # size z - 0 inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.400000 -z 3.100000" "0.100000" # size z - 0 inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.400000 -z 3.100000" "0.100000" # size z - 0 inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.100000 -y 0.500000 -z 1.600000" "0.100000" # size z - 0 inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.100000 -y 0.500000 -z 1.600000" "0.100000" # size z - 0 inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.400000 -z 1.600000" "0.100000" # size z - 0 inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.400000 -z 1.600000" "0.100000" # size z - 0 inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.100000 -y 0.500000 -z 3.200000" "0.223607" # size z - 0 outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.100000 -y 0.500000 -z 3.200000" "0.223607" # size z - 0 outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.600000 -z 3.200000" "0.223607" # size z - 0 outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.600000 -z 3.200000" "0.223607" # size z - 0 outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.100000 -y 0.500000 -z 1.700000" "0.223607" # size z - 0 outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.100000 -y 0.500000 -z 1.700000" "0.223607" # size z - 0 outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.600000 -z 1.700000" "0.223607" # size z - 0 outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.600000 -z 1.700000" "0.223607" # size z - 0 outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.900000 -y 0.500000 -z 1.500000" "-0.100000" # size z + 0 inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.900000 -y 0.500000 -z 1.500000" "-0.100000" # size z + 0 inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.400000 -z 1.500000" "-0.100000" # size z + 0 inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.400000 -z 1.500000" "-0.100000" # size z + 0 inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.900000 -y 0.500000" "-0.100000" # size z + 0 inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.900000 -y 0.500000" "-0.100000" # size z + 0 inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.400000" "-0.100000" # size z + 0 inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.400000" "-0.100000" # size z + 0 inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.100000 -y 0.500000 -z 1.500000" "0.100000" # size z + 0 outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.100000 -y 0.500000 -z 1.500000" "0.100000" # size z + 0 outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.600000 -z 1.500000" "0.100000" # size z + 0 outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.600000 -z 1.500000" "0.100000" # size z + 0 outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.100000 -y 0.500000" "0.100000" # size z + 0 outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.100000 -y 0.500000" "0.100000" # size z + 0 outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.600000" "0.100000" # size z + 0 outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.600000" "0.100000" # size z + 0 outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.900000 -y 0.500000 -z 0.200000" "-0.100000" # size z + 0 inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.900000 -y 0.500000 -z 0.200000" "-0.100000" # size z + 0 inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.400000 -z 0.200000" "-0.100000" # size z + 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.400000 -z 0.200000" "-0.100000" # size z + 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.900000 -y 0.500000 -z -1.300000" "-0.100000" # size z + 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.900000 -y 0.500000 -z -1.300000" "-0.100000" # size z + 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.400000 -z -1.300000" "-0.100000" # size z + 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.400000 -z -1.300000" "-0.100000" # size z + 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.800000 -y 0.500000 -z 0.100000" "-0.100000" # size z + 0 inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.800000 -y 0.500000 -z 0.100000" "-0.100000" # size z + 0 inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.300000 -z 0.100000" "-0.100000" # size z + 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.300000 -z 0.100000" "-0.100000" # size z + 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.800000 -y 0.500000 -z -1.400000" "-0.100000" # size z + 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.800000 -y 0.500000 -z -1.400000" "-0.100000" # size z + 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.300000 -z -1.400000" "-0.100000" # size z + 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.300000 -z -1.400000" "-0.100000" # size z + 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.100000 -y 0.500000 -z 0.100000" "0.100000" # size z + 0 outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.100000 -y 0.500000 -z 0.100000" "0.100000" # size z + 0 outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.600000 -z 0.100000" "0.100000" # size z + 0 outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.600000 -z 0.100000" "0.100000" # size z + 0 outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.100000 -y 0.500000 -z -1.400000" "0.100000" # size z + 0 outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.100000 -y 0.500000 -z -1.400000" "0.100000" # size z + 0 outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.600000 -z -1.400000" "0.100000" # size z + 0 outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.600000 -z -1.400000" "0.100000" # size z + 0 outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.900000 -y 0.500000 -z -0.100000" "0.100000" # size z + 0 inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.900000 -y 0.500000 -z -0.100000" "0.100000" # size z + 0 inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.400000 -z -0.100000" "0.100000" # size z + 0 inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.400000 -z -0.100000" "0.100000" # size z + 0 inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.900000 -y 0.500000 -z -1.600000" "0.100000" # size z + 0 inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.900000 -y 0.500000 -z -1.600000" "0.100000" # size z + 0 inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.400000 -z -1.600000" "0.100000" # size z + 0 inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.400000 -z -1.600000" "0.100000" # size z + 0 inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.100000 -y 0.500000 -z -0.200000" "0.223607" # size z + 0 outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.100000 -y 0.500000 -z -0.200000" "0.223607" # size z + 0 outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.600000 -z -0.200000" "0.223607" # size z + 0 outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.600000 -z -0.200000" "0.223607" # size z + 0 outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.100000 -y 0.500000 -z -1.700000" "0.223607" # size z + 0 outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.100000 -y 0.500000 -z -1.700000" "0.223607" # size z + 0 outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.600000 -z -1.700000" "0.223607" # size z + 0 outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.600000 -z -1.700000" "0.223607" # size z + 0 outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.900000 -y 0.500000 -z 2.800000" "-0.100000" # size z + 0 inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.900000 -y 0.500000 -z 2.800000" "-0.100000" # size z + 0 inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.400000 -z 2.800000" "-0.100000" # size z + 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.400000 -z 2.800000" "-0.100000" # size z + 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.900000 -y 0.500000 -z 1.300000" "-0.100000" # size z + 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.900000 -y 0.500000 -z 1.300000" "-0.100000" # size z + 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.400000 -z 1.300000" "-0.100000" # size z + 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.400000 -z 1.300000" "-0.100000" # size z + 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.800000 -y 0.500000 -z 2.900000" "-0.100000" # size z + 0 inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.800000 -y 0.500000 -z 2.900000" "-0.100000" # size z + 0 inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.300000 -z 2.900000" "-0.100000" # size z + 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.300000 -z 2.900000" "-0.100000" # size z + 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.800000 -y 0.500000 -z 1.400000" "-0.100000" # size z + 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.800000 -y 0.500000 -z 1.400000" "-0.100000" # size z + 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.300000 -z 1.400000" "-0.100000" # size z + 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.300000 -z 1.400000" "-0.100000" # size z + 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.100000 -y 0.500000 -z 2.900000" "0.100000" # size z + 0 outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.100000 -y 0.500000 -z 2.900000" "0.100000" # size z + 0 outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.600000 -z 2.900000" "0.100000" # size z + 0 outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.600000 -z 2.900000" "0.100000" # size z + 0 outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.100000 -y 0.500000 -z 1.400000" "0.100000" # size z + 0 outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.100000 -y 0.500000 -z 1.400000" "0.100000" # size z + 0 outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.600000 -z 1.400000" "0.100000" # size z + 0 outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.600000 -z 1.400000" "0.100000" # size z + 0 outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.900000 -y 0.500000 -z 3.100000" "0.100000" # size z + 0 inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.900000 -y 0.500000 -z 3.100000" "0.100000" # size z + 0 inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.400000 -z 3.100000" "0.100000" # size z + 0 inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.400000 -z 3.100000" "0.100000" # size z + 0 inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.900000 -y 0.500000 -z 1.600000" "0.100000" # size z + 0 inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.900000 -y 0.500000 -z 1.600000" "0.100000" # size z + 0 inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.400000 -z 1.600000" "0.100000" # size z + 0 inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.400000 -z 1.600000" "0.100000" # size z + 0 inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.100000 -y 0.500000 -z 3.200000" "0.223607" # size z + 0 outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.100000 -y 0.500000 -z 3.200000" "0.223607" # size z + 0 outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.600000 -z 3.200000" "0.223607" # size z + 0 outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.600000 -z 3.200000" "0.223607" # size z + 0 outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.100000 -y 0.500000 -z 1.700000" "0.223607" # size z + 0 outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.100000 -y 0.500000 -z 1.700000" "0.223607" # size z + 0 outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.600000 -z 1.700000" "0.223607" # size z + 0 outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.600000 -z 1.700000" "0.223607" # size z + 0 outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.283879 -z 1.500000" "-0.100000" # size z - - inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.283879 -z 1.500000" "-0.100000" # size z - - inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y -0.216121 -z 1.500000" "-0.100000" # size z - - inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 1.500000" "-0.100000" # size z - - inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.283879" "-0.100000" # size z - - inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.283879" "-0.100000" # size z - - inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y -0.216121" "-0.100000" # size z - - inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121" "-0.100000" # size z - - inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.175819 -z 1.500000" "0.100000" # size z - - outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.175819 -z 1.500000" "0.100000" # size z - - outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y -0.324181 -z 1.500000" "0.100000" # size z - - outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 1.500000" "0.100000" # size z - - outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.175819" "0.100000" # size z - - outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.175819" "0.100000" # size z - - outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y -0.324181" "0.100000" # size z - - outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181" "0.100000" # size z - - outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.283879 -z 0.200000" "-0.100000" # size z - - inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.283879 -z 0.200000" "-0.100000" # size z - - inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y -0.216121 -z 0.200000" "-0.100000" # size z - - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 0.200000" "-0.100000" # size z - - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.283879 -z -1.300000" "-0.100000" # size z - - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.283879 -z -1.300000" "-0.100000" # size z - - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z -1.300000" "-0.100000" # size z - - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z -1.300000" "-0.100000" # size z - - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.247559 -y 0.337909 -z 0.100000" "-0.100000" # size z - - inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.247559 -y 0.337909 -z 0.100000" "-0.100000" # size z - - inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.252441 -y -0.162091 -z 0.100000" "-0.100000" # size z - - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.252441 -y -0.162091 -z 0.100000" "-0.100000" # size z - - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.247559 -y 0.337909 -z -1.400000" "-0.100000" # size z - - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.247559 -y 0.337909 -z -1.400000" "-0.100000" # size z - - inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.252441 -y -0.162091 -z -1.400000" "-0.100000" # size z - - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.252441 -y -0.162091 -z -1.400000" "-0.100000" # size z - - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.175819 -z 0.100000" "0.100000" # size z - - outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.175819 -z 0.100000" "0.100000" # size z - - outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y -0.324181 -z 0.100000" "0.100000" # size z - - outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 0.100000" "0.100000" # size z - - outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.175819 -z -1.400000" "0.100000" # size z - - outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.175819 -z -1.400000" "0.100000" # size z - - outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z -1.400000" "0.100000" # size z - - outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z -1.400000" "0.100000" # size z - - outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.283879 -z -0.100000" "0.100000" # size z - - inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.283879 -z -0.100000" "0.100000" # size z - - inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y -0.216121 -z -0.100000" "0.100000" # size z - - inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y -0.216121 -z -0.100000" "0.100000" # size z - - inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.283879 -z -1.600000" "0.100000" # size z - - inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.283879 -z -1.600000" "0.100000" # size z - - inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z -1.600000" "0.100000" # size z - - inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z -1.600000" "0.100000" # size z - - inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.175819 -z -0.200000" "0.223607" # size z - - outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.175819 -z -0.200000" "0.223607" # size z - - outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y -0.324181 -z -0.200000" "0.223607" # size z - - outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y -0.324181 -z -0.200000" "0.223607" # size z - - outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.175819 -z -1.700000" "0.223607" # size z - - outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.175819 -z -1.700000" "0.223607" # size z - - outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z -1.700000" "0.223607" # size z - - outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z -1.700000" "0.223607" # size z - - outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.283879 -z 2.800000" "-0.100000" # size z - - inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.283879 -z 2.800000" "-0.100000" # size z - - inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y -0.216121 -z 2.800000" "-0.100000" # size z - - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 2.800000" "-0.100000" # size z - - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.283879 -z 1.300000" "-0.100000" # size z - - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.283879 -z 1.300000" "-0.100000" # size z - - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z 1.300000" "-0.100000" # size z - - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z 1.300000" "-0.100000" # size z - - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.247559 -y 0.337909 -z 2.900000" "-0.100000" # size z - - inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.247559 -y 0.337909 -z 2.900000" "-0.100000" # size z - - inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.252441 -y -0.162091 -z 2.900000" "-0.100000" # size z - - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.252441 -y -0.162091 -z 2.900000" "-0.100000" # size z - - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.247559 -y 0.337909 -z 1.400000" "-0.100000" # size z - - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.247559 -y 0.337909 -z 1.400000" "-0.100000" # size z - - inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.252441 -y -0.162091 -z 1.400000" "-0.100000" # size z - - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.252441 -y -0.162091 -z 1.400000" "-0.100000" # size z - - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.175819 -z 2.900000" "0.100000" # size z - - outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.175819 -z 2.900000" "0.100000" # size z - - outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y -0.324181 -z 2.900000" "0.100000" # size z - - outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 2.900000" "0.100000" # size z - - outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.175819 -z 1.400000" "0.100000" # size z - - outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.175819 -z 1.400000" "0.100000" # size z - - outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z 1.400000" "0.100000" # size z - - outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z 1.400000" "0.100000" # size z - - outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.283879 -z 3.100000" "0.100000" # size z - - inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.283879 -z 3.100000" "0.100000" # size z - - inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y -0.216121 -z 3.100000" "0.100000" # size z - - inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y -0.216121 -z 3.100000" "0.100000" # size z - - inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.283879 -z 1.600000" "0.100000" # size z - - inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.283879 -z 1.600000" "0.100000" # size z - - inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y -0.216121 -z 1.600000" "0.100000" # size z - - inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y -0.216121 -z 1.600000" "0.100000" # size z - - inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.175819 -z 3.200000" "0.223607" # size z - - outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.175819 -z 3.200000" "0.223607" # size z - - outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y -0.324181 -z 3.200000" "0.223607" # size z - - outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y -0.324181 -z 3.200000" "0.223607" # size z - - outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.175819 -z 1.700000" "0.223607" # size z - - outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.175819 -z 1.700000" "0.223607" # size z - - outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y -0.324181 -z 1.700000" "0.223607" # size z - - outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y -0.324181 -z 1.700000" "0.223607" # size z - - outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.716121 -z 1.500000" "-0.100000" # size z - + inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.716121 -z 1.500000" "-0.100000" # size z - + inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y 0.216121 -z 1.500000" "-0.100000" # size z - + inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 1.500000" "-0.100000" # size z - + inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.716121" "-0.100000" # size z - + inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.716121" "-0.100000" # size z - + inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y 0.216121" "-0.100000" # size z - + inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121" "-0.100000" # size z - + inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.824181 -z 1.500000" "0.100000" # size z - + outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.824181 -z 1.500000" "0.100000" # size z - + outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y 0.324181 -z 1.500000" "0.100000" # size z - + outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 1.500000" "0.100000" # size z - + outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.824181" "0.100000" # size z - + outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.824181" "0.100000" # size z - + outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y 0.324181" "0.100000" # size z - + outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181" "0.100000" # size z - + outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.716121 -z 0.200000" "-0.100000" # size z - + inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.716121 -z 0.200000" "-0.100000" # size z - + inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y 0.216121 -z 0.200000" "-0.100000" # size z - + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 0.200000" "-0.100000" # size z - + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.716121 -z -1.300000" "-0.100000" # size z - + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.716121 -z -1.300000" "-0.100000" # size z - + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z -1.300000" "-0.100000" # size z - + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z -1.300000" "-0.100000" # size z - + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.247559 -y 0.662091 -z 0.100000" "-0.100000" # size z - + inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.247559 -y 0.662091 -z 0.100000" "-0.100000" # size z - + inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.252441 -y 0.162091 -z 0.100000" "-0.100000" # size z - + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.252441 -y 0.162091 -z 0.100000" "-0.100000" # size z - + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.247559 -y 0.662091 -z -1.400000" "-0.100000" # size z - + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.247559 -y 0.662091 -z -1.400000" "-0.100000" # size z - + inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.252441 -y 0.162091 -z -1.400000" "-0.100000" # size z - + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.252441 -y 0.162091 -z -1.400000" "-0.100000" # size z - + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.824181 -z 0.100000" "0.100000" # size z - + outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.824181 -z 0.100000" "0.100000" # size z - + outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y 0.324181 -z 0.100000" "0.100000" # size z - + outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 0.100000" "0.100000" # size z - + outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.824181 -z -1.400000" "0.100000" # size z - + outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.824181 -z -1.400000" "0.100000" # size z - + outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z -1.400000" "0.100000" # size z - + outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z -1.400000" "0.100000" # size z - + outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.716121 -z -0.100000" "0.100000" # size z - + inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.716121 -z -0.100000" "0.100000" # size z - + inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y 0.216121 -z -0.100000" "0.100000" # size z - + inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y 0.216121 -z -0.100000" "0.100000" # size z - + inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.716121 -z -1.600000" "0.100000" # size z - + inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.716121 -z -1.600000" "0.100000" # size z - + inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z -1.600000" "0.100000" # size z - + inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z -1.600000" "0.100000" # size z - + inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.824181 -z -0.200000" "0.223607" # size z - + outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.824181 -z -0.200000" "0.223607" # size z - + outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y 0.324181 -z -0.200000" "0.223607" # size z - + outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y 0.324181 -z -0.200000" "0.223607" # size z - + outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.824181 -z -1.700000" "0.223607" # size z - + outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.824181 -z -1.700000" "0.223607" # size z - + outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z -1.700000" "0.223607" # size z - + outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z -1.700000" "0.223607" # size z - + outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.716121 -z 2.800000" "-0.100000" # size z - + inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.716121 -z 2.800000" "-0.100000" # size z - + inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y 0.216121 -z 2.800000" "-0.100000" # size z - + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 2.800000" "-0.100000" # size z - + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.716121 -z 1.300000" "-0.100000" # size z - + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.716121 -z 1.300000" "-0.100000" # size z - + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z 1.300000" "-0.100000" # size z - + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z 1.300000" "-0.100000" # size z - + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.247559 -y 0.662091 -z 2.900000" "-0.100000" # size z - + inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.247559 -y 0.662091 -z 2.900000" "-0.100000" # size z - + inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.252441 -y 0.162091 -z 2.900000" "-0.100000" # size z - + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.252441 -y 0.162091 -z 2.900000" "-0.100000" # size z - + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.247559 -y 0.662091 -z 1.400000" "-0.100000" # size z - + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.247559 -y 0.662091 -z 1.400000" "-0.100000" # size z - + inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.252441 -y 0.162091 -z 1.400000" "-0.100000" # size z - + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.252441 -y 0.162091 -z 1.400000" "-0.100000" # size z - + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.824181 -z 2.900000" "0.100000" # size z - + outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.824181 -z 2.900000" "0.100000" # size z - + outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y 0.324181 -z 2.900000" "0.100000" # size z - + outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 2.900000" "0.100000" # size z - + outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.824181 -z 1.400000" "0.100000" # size z - + outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.824181 -z 1.400000" "0.100000" # size z - + outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z 1.400000" "0.100000" # size z - + outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z 1.400000" "0.100000" # size z - + outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.163412 -y 0.716121 -z 3.100000" "0.100000" # size z - + inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.163412 -y 0.716121 -z 3.100000" "0.100000" # size z - + inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.336588 -y 0.216121 -z 3.100000" "0.100000" # size z - + inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.336588 -y 0.216121 -z 3.100000" "0.100000" # size z - + inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.163412 -y 0.716121 -z 1.600000" "0.100000" # size z - + inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.163412 -y 0.716121 -z 1.600000" "0.100000" # size z - + inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.336588 -y 0.216121 -z 1.600000" "0.100000" # size z - + inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.336588 -y 0.216121 -z 1.600000" "0.100000" # size z - + inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x -0.004883 -y 0.824181 -z 3.200000" "0.223607" # size z - + outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x -0.004883 -y 0.824181 -z 3.200000" "0.223607" # size z - + outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x -0.504883 -y 0.324181 -z 3.200000" "0.223607" # size z - + outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x -0.504883 -y 0.324181 -z 3.200000" "0.223607" # size z - + outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x -0.004883 -y 0.824181 -z 1.700000" "0.223607" # size z - + outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x -0.004883 -y 0.824181 -z 1.700000" "0.223607" # size z - + outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x -0.504883 -y 0.324181 -z 1.700000" "0.223607" # size z - + outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x -0.504883 -y 0.324181 -z 1.700000" "0.223607" # size z - + outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.283879 -z 1.500000" "-0.100000" # size z + - inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.283879 -z 1.500000" "-0.100000" # size z + - inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y -0.216121 -z 1.500000" "-0.100000" # size z + - inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 1.500000" "-0.100000" # size z + - inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.283879" "-0.100000" # size z + - inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.283879" "-0.100000" # size z + - inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y -0.216121" "-0.100000" # size z + - inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121" "-0.100000" # size z + - inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.175819 -z 1.500000" "0.100000" # size z + - outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.175819 -z 1.500000" "0.100000" # size z + - outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y -0.324181 -z 1.500000" "0.100000" # size z + - outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 1.500000" "0.100000" # size z + - outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.175819" "0.100000" # size z + - outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.175819" "0.100000" # size z + - outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y -0.324181" "0.100000" # size z + - outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181" "0.100000" # size z + - outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.283879 -z 0.200000" "-0.100000" # size z + - inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.283879 -z 0.200000" "-0.100000" # size z + - inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y -0.216121 -z 0.200000" "-0.100000" # size z + - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 0.200000" "-0.100000" # size z + - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.283879 -z -1.300000" "-0.100000" # size z + - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.283879 -z -1.300000" "-0.100000" # size z + - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z -1.300000" "-0.100000" # size z + - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z -1.300000" "-0.100000" # size z + - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.752441 -y 0.337909 -z 0.100000" "-0.100000" # size z + - inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.752441 -y 0.337909 -z 0.100000" "-0.100000" # size z + - inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.252441 -y -0.162091 -z 0.100000" "-0.100000" # size z + - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.252441 -y -0.162091 -z 0.100000" "-0.100000" # size z + - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.752441 -y 0.337909 -z -1.400000" "-0.100000" # size z + - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.752441 -y 0.337909 -z -1.400000" "-0.100000" # size z + - inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.252441 -y -0.162091 -z -1.400000" "-0.100000" # size z + - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.252441 -y -0.162091 -z -1.400000" "-0.100000" # size z + - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.175819 -z 0.100000" "0.100000" # size z + - outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.175819 -z 0.100000" "0.100000" # size z + - outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y -0.324181 -z 0.100000" "0.100000" # size z + - outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 0.100000" "0.100000" # size z + - outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.175819 -z -1.400000" "0.100000" # size z + - outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.175819 -z -1.400000" "0.100000" # size z + - outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z -1.400000" "0.100000" # size z + - outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z -1.400000" "0.100000" # size z + - outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.283879 -z -0.100000" "0.100000" # size z + - inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.283879 -z -0.100000" "0.100000" # size z + - inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y -0.216121 -z -0.100000" "0.100000" # size z + - inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y -0.216121 -z -0.100000" "0.100000" # size z + - inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.283879 -z -1.600000" "0.100000" # size z + - inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.283879 -z -1.600000" "0.100000" # size z + - inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z -1.600000" "0.100000" # size z + - inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z -1.600000" "0.100000" # size z + - inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.175819 -z -0.200000" "0.223607" # size z + - outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.175819 -z -0.200000" "0.223607" # size z + - outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y -0.324181 -z -0.200000" "0.223607" # size z + - outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y -0.324181 -z -0.200000" "0.223607" # size z + - outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.175819 -z -1.700000" "0.223607" # size z + - outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.175819 -z -1.700000" "0.223607" # size z + - outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z -1.700000" "0.223607" # size z + - outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z -1.700000" "0.223607" # size z + - outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.283879 -z 2.800000" "-0.100000" # size z + - inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.283879 -z 2.800000" "-0.100000" # size z + - inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y -0.216121 -z 2.800000" "-0.100000" # size z + - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 2.800000" "-0.100000" # size z + - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.283879 -z 1.300000" "-0.100000" # size z + - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.283879 -z 1.300000" "-0.100000" # size z + - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z 1.300000" "-0.100000" # size z + - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z 1.300000" "-0.100000" # size z + - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.752441 -y 0.337909 -z 2.900000" "-0.100000" # size z + - inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.752441 -y 0.337909 -z 2.900000" "-0.100000" # size z + - inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.252441 -y -0.162091 -z 2.900000" "-0.100000" # size z + - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.252441 -y -0.162091 -z 2.900000" "-0.100000" # size z + - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.752441 -y 0.337909 -z 1.400000" "-0.100000" # size z + - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.752441 -y 0.337909 -z 1.400000" "-0.100000" # size z + - inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.252441 -y -0.162091 -z 1.400000" "-0.100000" # size z + - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.252441 -y -0.162091 -z 1.400000" "-0.100000" # size z + - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.175819 -z 2.900000" "0.100000" # size z + - outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.175819 -z 2.900000" "0.100000" # size z + - outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y -0.324181 -z 2.900000" "0.100000" # size z + - outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 2.900000" "0.100000" # size z + - outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.175819 -z 1.400000" "0.100000" # size z + - outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.175819 -z 1.400000" "0.100000" # size z + - outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z 1.400000" "0.100000" # size z + - outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z 1.400000" "0.100000" # size z + - outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.283879 -z 3.100000" "0.100000" # size z + - inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.283879 -z 3.100000" "0.100000" # size z + - inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y -0.216121 -z 3.100000" "0.100000" # size z + - inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y -0.216121 -z 3.100000" "0.100000" # size z + - inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.283879 -z 1.600000" "0.100000" # size z + - inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.283879 -z 1.600000" "0.100000" # size z + - inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y -0.216121 -z 1.600000" "0.100000" # size z + - inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y -0.216121 -z 1.600000" "0.100000" # size z + - inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.175819 -z 3.200000" "0.223607" # size z + - outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.175819 -z 3.200000" "0.223607" # size z + - outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y -0.324181 -z 3.200000" "0.223607" # size z + - outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y -0.324181 -z 3.200000" "0.223607" # size z + - outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.175819 -z 1.700000" "0.223607" # size z + - outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.175819 -z 1.700000" "0.223607" # size z + - outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y -0.324181 -z 1.700000" "0.223607" # size z + - outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y -0.324181 -z 1.700000" "0.223607" # size z + - outside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.716121 -z 1.500000" "-0.100000" # size z + + inside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.716121 -z 1.500000" "-0.100000" # size z + + inside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y 0.216121 -z 1.500000" "-0.100000" # size z + + inside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 1.500000" "-0.100000" # size z + + inside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.716121" "-0.100000" # size z + + inside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.716121" "-0.100000" # size z + + inside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y 0.216121" "-0.100000" # size z + + inside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121" "-0.100000" # size z + + inside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.824181 -z 1.500000" "0.100000" # size z + + outside 0 short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.824181 -z 1.500000" "0.100000" # size z + + outside 0 long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y 0.324181 -z 1.500000" "0.100000" # size z + + outside 0 center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 1.500000" "0.100000" # size z + + outside 0 center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.824181" "0.100000" # size z + + outside 0 center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.824181" "0.100000" # size z + + outside 0 center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y 0.324181" "0.100000" # size z + + outside 0 center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181" "0.100000" # size z + + outside 0 center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.716121 -z 0.200000" "-0.100000" # size z + + inside - inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.716121 -z 0.200000" "-0.100000" # size z + + inside - inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y 0.216121 -z 0.200000" "-0.100000" # size z + + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 0.200000" "-0.100000" # size z + + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.716121 -z -1.300000" "-0.100000" # size z + + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.716121 -z -1.300000" "-0.100000" # size z + + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z -1.300000" "-0.100000" # size z + + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z -1.300000" "-0.100000" # size z + + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.752441 -y 0.662091 -z 0.100000" "-0.100000" # size z + + inside - inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.752441 -y 0.662091 -z 0.100000" "-0.100000" # size z + + inside - inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.252441 -y 0.162091 -z 0.100000" "-0.100000" # size z + + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.252441 -y 0.162091 -z 0.100000" "-0.100000" # size z + + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.752441 -y 0.662091 -z -1.400000" "-0.100000" # size z + + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.752441 -y 0.662091 -z -1.400000" "-0.100000" # size z + + inside - inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.252441 -y 0.162091 -z -1.400000" "-0.100000" # size z + + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.252441 -y 0.162091 -z -1.400000" "-0.100000" # size z + + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.824181 -z 0.100000" "0.100000" # size z + + outside - inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.824181 -z 0.100000" "0.100000" # size z + + outside - inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y 0.324181 -z 0.100000" "0.100000" # size z + + outside - inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 0.100000" "0.100000" # size z + + outside - inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.824181 -z -1.400000" "0.100000" # size z + + outside - inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.824181 -z -1.400000" "0.100000" # size z + + outside - inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z -1.400000" "0.100000" # size z + + outside - inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z -1.400000" "0.100000" # size z + + outside - inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.716121 -z -0.100000" "0.100000" # size z + + inside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.716121 -z -0.100000" "0.100000" # size z + + inside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y 0.216121 -z -0.100000" "0.100000" # size z + + inside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y 0.216121 -z -0.100000" "0.100000" # size z + + inside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.716121 -z -1.600000" "0.100000" # size z + + inside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.716121 -z -1.600000" "0.100000" # size z + + inside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z -1.600000" "0.100000" # size z + + inside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z -1.600000" "0.100000" # size z + + inside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.824181 -z -0.200000" "0.223607" # size z + + outside - outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.824181 -z -0.200000" "0.223607" # size z + + outside - outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y 0.324181 -z -0.200000" "0.223607" # size z + + outside - outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y 0.324181 -z -0.200000" "0.223607" # size z + + outside - outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.824181 -z -1.700000" "0.223607" # size z + + outside - outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.824181 -z -1.700000" "0.223607" # size z + + outside - outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z -1.700000" "0.223607" # size z + + outside - outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z -1.700000" "0.223607" # size z + + outside - outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.716121 -z 2.800000" "-0.100000" # size z + + inside + inside closer to xy short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.716121 -z 2.800000" "-0.100000" # size z + + inside + inside closer to xy long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y 0.216121 -z 2.800000" "-0.100000" # size z + + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 2.800000" "-0.100000" # size z + + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.716121 -z 1.300000" "-0.100000" # size z + + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.716121 -z 1.300000" "-0.100000" # size z + + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z 1.300000" "-0.100000" # size z + + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z 1.300000" "-0.100000" # size z + + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.752441 -y 0.662091 -z 2.900000" "-0.100000" # size z + + inside + inside closer to z short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.752441 -y 0.662091 -z 2.900000" "-0.100000" # size z + + inside + inside closer to z long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.252441 -y 0.162091 -z 2.900000" "-0.100000" # size z + + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.252441 -y 0.162091 -z 2.900000" "-0.100000" # size z + + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.752441 -y 0.662091 -z 1.400000" "-0.100000" # size z + + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.752441 -y 0.662091 -z 1.400000" "-0.100000" # size z + + inside + inside closer to z center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.252441 -y 0.162091 -z 1.400000" "-0.100000" # size z + + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.252441 -y 0.162091 -z 1.400000" "-0.100000" # size z + + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.824181 -z 2.900000" "0.100000" # size z + + outside + inside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.824181 -z 2.900000" "0.100000" # size z + + outside + inside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y 0.324181 -z 2.900000" "0.100000" # size z + + outside + inside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 2.900000" "0.100000" # size z + + outside + inside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.824181 -z 1.400000" "0.100000" # size z + + outside + inside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.824181 -z 1.400000" "0.100000" # size z + + outside + inside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z 1.400000" "0.100000" # size z + + outside + inside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z 1.400000" "0.100000" # size z + + outside + inside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 0.836588 -y 0.716121 -z 3.100000" "0.100000" # size z + + inside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 0.836588 -y 0.716121 -z 3.100000" "0.100000" # size z + + inside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.336588 -y 0.216121 -z 3.100000" "0.100000" # size z + + inside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.336588 -y 0.216121 -z 3.100000" "0.100000" # size z + + inside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 0.836588 -y 0.716121 -z 1.600000" "0.100000" # size z + + inside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 0.836588 -y 0.716121 -z 1.600000" "0.100000" # size z + + inside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.336588 -y 0.216121 -z 1.600000" "0.100000" # size z + + inside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.336588 -y 0.216121 -z 1.600000" "0.100000" # size z + + inside + outside center xyz long
  check_successful "bin/cylinder -sz 3 | bin/sample -x 1.004883 -y 0.824181 -z 3.200000" "0.223607" # size z + + outside + outside short
  check_successful "bin/cylinder --size-z 3 | bin/sample -x 1.004883 -y 0.824181 -z 3.200000" "0.223607" # size z + + outside + outside long
  check_successful "bin/cylinder -sz 3 -cxy | bin/sample -x 0.504883 -y 0.324181 -z 3.200000" "0.223607" # size z + + outside + outside center xy short
  check_successful "bin/cylinder --size-z 3 --center-xy | bin/sample -x 0.504883 -y 0.324181 -z 3.200000" "0.223607" # size z + + outside + outside center xy long
  check_successful "bin/cylinder -sz 3 -cz | bin/sample -x 1.004883 -y 0.824181 -z 1.700000" "0.223607" # size z + + outside + outside center z short
  check_successful "bin/cylinder --size-z 3 --center-z | bin/sample -x 1.004883 -y 0.824181 -z 1.700000" "0.223607" # size z + + outside + outside center z long
  check_successful "bin/cylinder -sz 3 -cxy -cz | bin/sample -x 0.504883 -y 0.324181 -z 1.700000" "0.223607" # size z + + outside + outside center xyz short
  check_successful "bin/cylinder --size-z 3 --center-xy --center-z | bin/sample -x 0.504883 -y 0.324181 -z 1.700000" "0.223607" # size z + + outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.000000 -z 0.100000" "-0.100000" # size x y 0 0 - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.000000 -z 0.100000" "-0.100000" # size x y 0 0 - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -z 0.100000" "-0.100000" # size x y 0 0 - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -z 0.100000" "-0.100000" # size x y 0 0 - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.000000 -z -0.400000" "-0.100000" # size x y 0 0 - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -0.400000" "-0.100000" # size x y 0 0 - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -z -0.400000" "-0.100000" # size x y 0 0 - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -z -0.400000" "-0.100000" # size x y 0 0 - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.000000 -z -0.100000" "0.100000" # size x y 0 0 - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.000000 -z -0.100000" "0.100000" # size x y 0 0 - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -z -0.100000" "0.100000" # size x y 0 0 - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -z -0.100000" "0.100000" # size x y 0 0 - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.000000 -z -0.600000" "0.100000" # size x y 0 0 - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -0.600000" "0.100000" # size x y 0 0 - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -z -0.600000" "0.100000" # size x y 0 0 - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -z -0.600000" "0.100000" # size x y 0 0 - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.000000 -z 0.900000" "-0.100000" # size x y 0 0 + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.000000 -z 0.900000" "-0.100000" # size x y 0 0 + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -z 0.900000" "-0.100000" # size x y 0 0 + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -z 0.900000" "-0.100000" # size x y 0 0 + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.000000 -z 0.400000" "-0.100000" # size x y 0 0 + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.000000 -z 0.400000" "-0.100000" # size x y 0 0 + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -z 0.400000" "-0.100000" # size x y 0 0 + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -z 0.400000" "-0.100000" # size x y 0 0 + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.000000 -z 1.100000" "0.100000" # size x y 0 0 + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.000000 -z 1.100000" "0.100000" # size x y 0 0 + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -z 1.100000" "0.100000" # size x y 0 0 + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -z 1.100000" "0.100000" # size x y 0 0 + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.000000 -z 0.600000" "0.100000" # size x y 0 0 + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.000000 -z 0.600000" "0.100000" # size x y 0 0 + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -z 0.600000" "0.100000" # size x y 0 0 + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -z 0.600000" "0.100000" # size x y 0 0 + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.100000 -z 0.500000" "-0.100000" # size x y 0 - inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.100000 -z 0.500000" "-0.100000" # size x y 0 - inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.900000 -z 0.500000" "-0.100000" # size x y 0 - inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.900000 -z 0.500000" "-0.100000" # size x y 0 - inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.100000" "-0.100000" # size x y 0 - inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.100000" "-0.100000" # size x y 0 - inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.900000" "-0.100000" # size x y 0 - inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.900000" "-0.100000" # size x y 0 - inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y -0.100000 -z 0.500000" "0.100000" # size x y 0 - outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y -0.100000 -z 0.500000" "0.100000" # size x y 0 - outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -1.100000 -z 0.500000" "0.100000" # size x y 0 - outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -1.100000 -z 0.500000" "0.100000" # size x y 0 - outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y -0.100000" "0.100000" # size x y 0 - outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y -0.100000" "0.100000" # size x y 0 - outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -1.100000" "0.100000" # size x y 0 - outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -1.100000" "0.100000" # size x y 0 - outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.100000 -z 0.200000" "-0.100000" # size x y 0 - inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.100000 -z 0.200000" "-0.100000" # size x y 0 - inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.900000 -z 0.200000" "-0.100000" # size x y 0 - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.900000 -z 0.200000" "-0.100000" # size x y 0 - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.100000 -z -0.300000" "-0.100000" # size x y 0 - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.100000 -z -0.300000" "-0.100000" # size x y 0 - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.900000 -z -0.300000" "-0.100000" # size x y 0 - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.900000 -z -0.300000" "-0.100000" # size x y 0 - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.200000 -z 0.100000" "-0.100000" # size x y 0 - inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.200000 -z 0.100000" "-0.100000" # size x y 0 - inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.800000 -z 0.100000" "-0.100000" # size x y 0 - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.800000 -z 0.100000" "-0.100000" # size x y 0 - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.200000 -z -0.400000" "-0.100000" # size x y 0 - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.200000 -z -0.400000" "-0.100000" # size x y 0 - inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.800000 -z -0.400000" "-0.100000" # size x y 0 - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.800000 -z -0.400000" "-0.100000" # size x y 0 - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y -0.100000 -z 0.100000" "0.100000" # size x y 0 - outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y -0.100000 -z 0.100000" "0.100000" # size x y 0 - outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -1.100000 -z 0.100000" "0.100000" # size x y 0 - outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -1.100000 -z 0.100000" "0.100000" # size x y 0 - outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y -0.100000 -z -0.400000" "0.100000" # size x y 0 - outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y -0.100000 -z -0.400000" "0.100000" # size x y 0 - outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -1.100000 -z -0.400000" "0.100000" # size x y 0 - outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -1.100000 -z -0.400000" "0.100000" # size x y 0 - outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.100000 -z -0.100000" "0.100000" # size x y 0 - inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.100000 -z -0.100000" "0.100000" # size x y 0 - inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.900000 -z -0.100000" "0.100000" # size x y 0 - inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.900000 -z -0.100000" "0.100000" # size x y 0 - inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.100000 -z -0.600000" "0.100000" # size x y 0 - inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.100000 -z -0.600000" "0.100000" # size x y 0 - inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.900000 -z -0.600000" "0.100000" # size x y 0 - inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.900000 -z -0.600000" "0.100000" # size x y 0 - inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y -0.100000 -z -0.200000" "0.223607" # size x y 0 - outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y -0.100000 -z -0.200000" "0.223607" # size x y 0 - outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -1.100000 -z -0.200000" "0.223607" # size x y 0 - outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -1.100000 -z -0.200000" "0.223607" # size x y 0 - outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y -0.100000 -z -0.700000" "0.223607" # size x y 0 - outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y -0.100000 -z -0.700000" "0.223607" # size x y 0 - outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -1.100000 -z -0.700000" "0.223607" # size x y 0 - outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -1.100000 -z -0.700000" "0.223607" # size x y 0 - outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.100000 -z 0.800000" "-0.100000" # size x y 0 - inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.100000 -z 0.800000" "-0.100000" # size x y 0 - inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.900000 -z 0.800000" "-0.100000" # size x y 0 - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.900000 -z 0.800000" "-0.100000" # size x y 0 - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.100000 -z 0.300000" "-0.100000" # size x y 0 - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.100000 -z 0.300000" "-0.100000" # size x y 0 - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.900000 -z 0.300000" "-0.100000" # size x y 0 - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.900000 -z 0.300000" "-0.100000" # size x y 0 - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.200000 -z 0.900000" "-0.100000" # size x y 0 - inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.200000 -z 0.900000" "-0.100000" # size x y 0 - inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.800000 -z 0.900000" "-0.100000" # size x y 0 - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.800000 -z 0.900000" "-0.100000" # size x y 0 - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.200000 -z 0.400000" "-0.100000" # size x y 0 - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.200000 -z 0.400000" "-0.100000" # size x y 0 - inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.800000 -z 0.400000" "-0.100000" # size x y 0 - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.800000 -z 0.400000" "-0.100000" # size x y 0 - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y -0.100000 -z 0.900000" "0.100000" # size x y 0 - outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y -0.100000 -z 0.900000" "0.100000" # size x y 0 - outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -1.100000 -z 0.900000" "0.100000" # size x y 0 - outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -1.100000 -z 0.900000" "0.100000" # size x y 0 - outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y -0.100000 -z 0.400000" "0.100000" # size x y 0 - outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y -0.100000 -z 0.400000" "0.100000" # size x y 0 - outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -1.100000 -z 0.400000" "0.100000" # size x y 0 - outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -1.100000 -z 0.400000" "0.100000" # size x y 0 - outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 0.100000 -z 1.100000" "0.100000" # size x y 0 - inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 0.100000 -z 1.100000" "0.100000" # size x y 0 - inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -0.900000 -z 1.100000" "0.100000" # size x y 0 - inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -0.900000 -z 1.100000" "0.100000" # size x y 0 - inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 0.100000 -z 0.600000" "0.100000" # size x y 0 - inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 0.100000 -z 0.600000" "0.100000" # size x y 0 - inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -0.900000 -z 0.600000" "0.100000" # size x y 0 - inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -0.900000 -z 0.600000" "0.100000" # size x y 0 - inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y -0.100000 -z 1.200000" "0.223607" # size x y 0 - outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y -0.100000 -z 1.200000" "0.223607" # size x y 0 - outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y -1.100000 -z 1.200000" "0.223607" # size x y 0 - outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y -1.100000 -z 1.200000" "0.223607" # size x y 0 - outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y -0.100000 -z 0.700000" "0.223607" # size x y 0 - outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y -0.100000 -z 0.700000" "0.223607" # size x y 0 - outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y -1.100000 -z 0.700000" "0.223607" # size x y 0 - outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y -1.100000 -z 0.700000" "0.223607" # size x y 0 - outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.900000 -z 0.500000" "-0.100000" # size x y 0 + inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.900000 -z 0.500000" "-0.100000" # size x y 0 + inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.900000 -z 0.500000" "-0.100000" # size x y 0 + inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.900000 -z 0.500000" "-0.100000" # size x y 0 + inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.900000" "-0.100000" # size x y 0 + inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.900000" "-0.100000" # size x y 0 + inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.900000" "-0.100000" # size x y 0 + inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.900000" "-0.100000" # size x y 0 + inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 2.100000 -z 0.500000" "0.100000" # size x y 0 + outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 2.100000 -z 0.500000" "0.100000" # size x y 0 + outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 1.100000 -z 0.500000" "0.100000" # size x y 0 + outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 1.100000 -z 0.500000" "0.100000" # size x y 0 + outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 2.100000" "0.100000" # size x y 0 + outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 2.100000" "0.100000" # size x y 0 + outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 1.100000" "0.100000" # size x y 0 + outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 1.100000" "0.100000" # size x y 0 + outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.900000 -z 0.200000" "-0.100000" # size x y 0 + inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.900000 -z 0.200000" "-0.100000" # size x y 0 + inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.900000 -z 0.200000" "-0.100000" # size x y 0 + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.900000 -z 0.200000" "-0.100000" # size x y 0 + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.900000 -z -0.300000" "-0.100000" # size x y 0 + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.900000 -z -0.300000" "-0.100000" # size x y 0 + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.900000 -z -0.300000" "-0.100000" # size x y 0 + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.900000 -z -0.300000" "-0.100000" # size x y 0 + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.800000 -z 0.100000" "-0.100000" # size x y 0 + inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.800000 -z 0.100000" "-0.100000" # size x y 0 + inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.800000 -z 0.100000" "-0.100000" # size x y 0 + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.800000 -z 0.100000" "-0.100000" # size x y 0 + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.800000 -z -0.400000" "-0.100000" # size x y 0 + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.800000 -z -0.400000" "-0.100000" # size x y 0 + inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.800000 -z -0.400000" "-0.100000" # size x y 0 + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.800000 -z -0.400000" "-0.100000" # size x y 0 + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 2.100000 -z 0.100000" "0.100000" # size x y 0 + outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 2.100000 -z 0.100000" "0.100000" # size x y 0 + outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 1.100000 -z 0.100000" "0.100000" # size x y 0 + outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 1.100000 -z 0.100000" "0.100000" # size x y 0 + outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 2.100000 -z -0.400000" "0.100000" # size x y 0 + outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 2.100000 -z -0.400000" "0.100000" # size x y 0 + outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 1.100000 -z -0.400000" "0.100000" # size x y 0 + outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 1.100000 -z -0.400000" "0.100000" # size x y 0 + outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.900000 -z -0.100000" "0.100000" # size x y 0 + inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.900000 -z -0.100000" "0.100000" # size x y 0 + inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.900000 -z -0.100000" "0.100000" # size x y 0 + inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.900000 -z -0.100000" "0.100000" # size x y 0 + inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.900000 -z -0.600000" "0.100000" # size x y 0 + inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.900000 -z -0.600000" "0.100000" # size x y 0 + inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.900000 -z -0.600000" "0.100000" # size x y 0 + inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.900000 -z -0.600000" "0.100000" # size x y 0 + inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 2.100000 -z -0.200000" "0.223607" # size x y 0 + outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 2.100000 -z -0.200000" "0.223607" # size x y 0 + outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 1.100000 -z -0.200000" "0.223607" # size x y 0 + outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 1.100000 -z -0.200000" "0.223607" # size x y 0 + outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 2.100000 -z -0.700000" "0.223607" # size x y 0 + outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 2.100000 -z -0.700000" "0.223607" # size x y 0 + outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 1.100000 -z -0.700000" "0.223607" # size x y 0 + outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 1.100000 -z -0.700000" "0.223607" # size x y 0 + outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.900000 -z 0.800000" "-0.100000" # size x y 0 + inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.900000 -z 0.800000" "-0.100000" # size x y 0 + inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.900000 -z 0.800000" "-0.100000" # size x y 0 + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.900000 -z 0.800000" "-0.100000" # size x y 0 + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.900000 -z 0.300000" "-0.100000" # size x y 0 + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.900000 -z 0.300000" "-0.100000" # size x y 0 + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.900000 -z 0.300000" "-0.100000" # size x y 0 + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.900000 -z 0.300000" "-0.100000" # size x y 0 + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.800000 -z 0.900000" "-0.100000" # size x y 0 + inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.800000 -z 0.900000" "-0.100000" # size x y 0 + inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.800000 -z 0.900000" "-0.100000" # size x y 0 + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.800000 -z 0.900000" "-0.100000" # size x y 0 + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.800000 -z 0.400000" "-0.100000" # size x y 0 + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.800000 -z 0.400000" "-0.100000" # size x y 0 + inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.800000 -z 0.400000" "-0.100000" # size x y 0 + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.800000 -z 0.400000" "-0.100000" # size x y 0 + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 2.100000 -z 0.900000" "0.100000" # size x y 0 + outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 2.100000 -z 0.900000" "0.100000" # size x y 0 + outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 1.100000 -z 0.900000" "0.100000" # size x y 0 + outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 1.100000 -z 0.900000" "0.100000" # size x y 0 + outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 2.100000 -z 0.400000" "0.100000" # size x y 0 + outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 2.100000 -z 0.400000" "0.100000" # size x y 0 + outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 1.100000 -z 0.400000" "0.100000" # size x y 0 + outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 1.100000 -z 0.400000" "0.100000" # size x y 0 + outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 1.900000 -z 1.100000" "0.100000" # size x y 0 + inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 1.900000 -z 1.100000" "0.100000" # size x y 0 + inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 0.900000 -z 1.100000" "0.100000" # size x y 0 + inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 0.900000 -z 1.100000" "0.100000" # size x y 0 + inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 1.900000 -z 0.600000" "0.100000" # size x y 0 + inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 1.900000 -z 0.600000" "0.100000" # size x y 0 + inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 0.900000 -z 0.600000" "0.100000" # size x y 0 + inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 0.900000 -z 0.600000" "0.100000" # size x y 0 + inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.000000 -y 2.100000 -z 1.200000" "0.223607" # size x y 0 + outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.000000 -y 2.100000 -z 1.200000" "0.223607" # size x y 0 + outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -y 1.100000 -z 1.200000" "0.223607" # size x y 0 + outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -y 1.100000 -z 1.200000" "0.223607" # size x y 0 + outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.000000 -y 2.100000 -z 0.700000" "0.223607" # size x y 0 + outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.000000 -y 2.100000 -z 0.700000" "0.223607" # size x y 0 + outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -y 1.100000 -z 0.700000" "0.223607" # size x y 0 + outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -y 1.100000 -z 0.700000" "0.223607" # size x y 0 + outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.100000 -y 1.000000 -z 0.500000" "-0.100000" # size x y - 0 inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.100000 -y 1.000000 -z 0.500000" "-0.100000" # size x y - 0 inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.900000 -z 0.500000" "-0.100000" # size x y - 0 inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.900000 -z 0.500000" "-0.100000" # size x y - 0 inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.100000 -y 1.000000" "-0.100000" # size x y - 0 inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.100000 -y 1.000000" "-0.100000" # size x y - 0 inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.900000" "-0.100000" # size x y - 0 inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.900000" "-0.100000" # size x y - 0 inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x -0.100000 -y 1.000000 -z 0.500000" "0.100000" # size x y - 0 outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x -0.100000 -y 1.000000 -z 0.500000" "0.100000" # size x y - 0 outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -1.100000 -z 0.500000" "0.100000" # size x y - 0 outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -1.100000 -z 0.500000" "0.100000" # size x y - 0 outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x -0.100000 -y 1.000000" "0.100000" # size x y - 0 outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x -0.100000 -y 1.000000" "0.100000" # size x y - 0 outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -1.100000" "0.100000" # size x y - 0 outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -1.100000" "0.100000" # size x y - 0 outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.100000 -y 1.000000 -z 0.200000" "-0.100000" # size x y - 0 inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.100000 -y 1.000000 -z 0.200000" "-0.100000" # size x y - 0 inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.900000 -z 0.200000" "-0.100000" # size x y - 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.900000 -z 0.200000" "-0.100000" # size x y - 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.100000 -y 1.000000 -z -0.300000" "-0.100000" # size x y - 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.100000 -y 1.000000 -z -0.300000" "-0.100000" # size x y - 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.900000 -z -0.300000" "-0.100000" # size x y - 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.900000 -z -0.300000" "-0.100000" # size x y - 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.200000 -y 1.000000 -z 0.100000" "-0.100000" # size x y - 0 inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.200000 -y 1.000000 -z 0.100000" "-0.100000" # size x y - 0 inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.800000 -z 0.100000" "-0.100000" # size x y - 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.800000 -z 0.100000" "-0.100000" # size x y - 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.200000 -y 1.000000 -z -0.400000" "-0.100000" # size x y - 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.200000 -y 1.000000 -z -0.400000" "-0.100000" # size x y - 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.800000 -z -0.400000" "-0.100000" # size x y - 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.800000 -z -0.400000" "-0.100000" # size x y - 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x -0.100000 -y 1.000000 -z 0.100000" "0.100000" # size x y - 0 outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x -0.100000 -y 1.000000 -z 0.100000" "0.100000" # size x y - 0 outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -1.100000 -z 0.100000" "0.100000" # size x y - 0 outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -1.100000 -z 0.100000" "0.100000" # size x y - 0 outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x -0.100000 -y 1.000000 -z -0.400000" "0.100000" # size x y - 0 outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x -0.100000 -y 1.000000 -z -0.400000" "0.100000" # size x y - 0 outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -1.100000 -z -0.400000" "0.100000" # size x y - 0 outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -1.100000 -z -0.400000" "0.100000" # size x y - 0 outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.100000 -y 1.000000 -z -0.100000" "0.100000" # size x y - 0 inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.100000 -y 1.000000 -z -0.100000" "0.100000" # size x y - 0 inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.900000 -z -0.100000" "0.100000" # size x y - 0 inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.900000 -z -0.100000" "0.100000" # size x y - 0 inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.100000 -y 1.000000 -z -0.600000" "0.100000" # size x y - 0 inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.100000 -y 1.000000 -z -0.600000" "0.100000" # size x y - 0 inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.900000 -z -0.600000" "0.100000" # size x y - 0 inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.900000 -z -0.600000" "0.100000" # size x y - 0 inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x -0.100000 -y 1.000000 -z -0.200000" "0.223607" # size x y - 0 outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x -0.100000 -y 1.000000 -z -0.200000" "0.223607" # size x y - 0 outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -1.100000 -z -0.200000" "0.223607" # size x y - 0 outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -1.100000 -z -0.200000" "0.223607" # size x y - 0 outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x -0.100000 -y 1.000000 -z -0.700000" "0.223607" # size x y - 0 outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x -0.100000 -y 1.000000 -z -0.700000" "0.223607" # size x y - 0 outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -1.100000 -z -0.700000" "0.223607" # size x y - 0 outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -1.100000 -z -0.700000" "0.223607" # size x y - 0 outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.100000 -y 1.000000 -z 0.800000" "-0.100000" # size x y - 0 inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.100000 -y 1.000000 -z 0.800000" "-0.100000" # size x y - 0 inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.900000 -z 0.800000" "-0.100000" # size x y - 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.900000 -z 0.800000" "-0.100000" # size x y - 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.100000 -y 1.000000 -z 0.300000" "-0.100000" # size x y - 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.100000 -y 1.000000 -z 0.300000" "-0.100000" # size x y - 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.900000 -z 0.300000" "-0.100000" # size x y - 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.900000 -z 0.300000" "-0.100000" # size x y - 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.200000 -y 1.000000 -z 0.900000" "-0.100000" # size x y - 0 inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.200000 -y 1.000000 -z 0.900000" "-0.100000" # size x y - 0 inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.800000 -z 0.900000" "-0.100000" # size x y - 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.800000 -z 0.900000" "-0.100000" # size x y - 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.200000 -y 1.000000 -z 0.400000" "-0.100000" # size x y - 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.200000 -y 1.000000 -z 0.400000" "-0.100000" # size x y - 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.800000 -z 0.400000" "-0.100000" # size x y - 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.800000 -z 0.400000" "-0.100000" # size x y - 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x -0.100000 -y 1.000000 -z 0.900000" "0.100000" # size x y - 0 outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x -0.100000 -y 1.000000 -z 0.900000" "0.100000" # size x y - 0 outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -1.100000 -z 0.900000" "0.100000" # size x y - 0 outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -1.100000 -z 0.900000" "0.100000" # size x y - 0 outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x -0.100000 -y 1.000000 -z 0.400000" "0.100000" # size x y - 0 outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x -0.100000 -y 1.000000 -z 0.400000" "0.100000" # size x y - 0 outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -1.100000 -z 0.400000" "0.100000" # size x y - 0 outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -1.100000 -z 0.400000" "0.100000" # size x y - 0 outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.100000 -y 1.000000 -z 1.100000" "0.100000" # size x y - 0 inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.100000 -y 1.000000 -z 1.100000" "0.100000" # size x y - 0 inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.900000 -z 1.100000" "0.100000" # size x y - 0 inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.900000 -z 1.100000" "0.100000" # size x y - 0 inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.100000 -y 1.000000 -z 0.600000" "0.100000" # size x y - 0 inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.100000 -y 1.000000 -z 0.600000" "0.100000" # size x y - 0 inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.900000 -z 0.600000" "0.100000" # size x y - 0 inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.900000 -z 0.600000" "0.100000" # size x y - 0 inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x -0.100000 -y 1.000000 -z 1.200000" "0.223607" # size x y - 0 outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x -0.100000 -y 1.000000 -z 1.200000" "0.223607" # size x y - 0 outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -1.100000 -z 1.200000" "0.223607" # size x y - 0 outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -1.100000 -z 1.200000" "0.223607" # size x y - 0 outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x -0.100000 -y 1.000000 -z 0.700000" "0.223607" # size x y - 0 outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x -0.100000 -y 1.000000 -z 0.700000" "0.223607" # size x y - 0 outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -1.100000 -z 0.700000" "0.223607" # size x y - 0 outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -1.100000 -z 0.700000" "0.223607" # size x y - 0 outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.900000 -y 1.000000 -z 0.500000" "-0.100000" # size x y + 0 inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.900000 -y 1.000000 -z 0.500000" "-0.100000" # size x y + 0 inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.900000 -z 0.500000" "-0.100000" # size x y + 0 inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.900000 -z 0.500000" "-0.100000" # size x y + 0 inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.900000 -y 1.000000" "-0.100000" # size x y + 0 inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.900000 -y 1.000000" "-0.100000" # size x y + 0 inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.900000" "-0.100000" # size x y + 0 inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.900000" "-0.100000" # size x y + 0 inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 2.100000 -y 1.000000 -z 0.500000" "0.100000" # size x y + 0 outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 2.100000 -y 1.000000 -z 0.500000" "0.100000" # size x y + 0 outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 1.100000 -z 0.500000" "0.100000" # size x y + 0 outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 1.100000 -z 0.500000" "0.100000" # size x y + 0 outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 2.100000 -y 1.000000" "0.100000" # size x y + 0 outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 2.100000 -y 1.000000" "0.100000" # size x y + 0 outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 1.100000" "0.100000" # size x y + 0 outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 1.100000" "0.100000" # size x y + 0 outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.900000 -y 1.000000 -z 0.200000" "-0.100000" # size x y + 0 inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.900000 -y 1.000000 -z 0.200000" "-0.100000" # size x y + 0 inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.900000 -z 0.200000" "-0.100000" # size x y + 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.900000 -z 0.200000" "-0.100000" # size x y + 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.900000 -y 1.000000 -z -0.300000" "-0.100000" # size x y + 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.900000 -y 1.000000 -z -0.300000" "-0.100000" # size x y + 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.900000 -z -0.300000" "-0.100000" # size x y + 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.900000 -z -0.300000" "-0.100000" # size x y + 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.800000 -y 1.000000 -z 0.100000" "-0.100000" # size x y + 0 inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.800000 -y 1.000000 -z 0.100000" "-0.100000" # size x y + 0 inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.800000 -z 0.100000" "-0.100000" # size x y + 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.800000 -z 0.100000" "-0.100000" # size x y + 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.800000 -y 1.000000 -z -0.400000" "-0.100000" # size x y + 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.800000 -y 1.000000 -z -0.400000" "-0.100000" # size x y + 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.800000 -z -0.400000" "-0.100000" # size x y + 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.800000 -z -0.400000" "-0.100000" # size x y + 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 2.100000 -y 1.000000 -z 0.100000" "0.100000" # size x y + 0 outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 2.100000 -y 1.000000 -z 0.100000" "0.100000" # size x y + 0 outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 1.100000 -z 0.100000" "0.100000" # size x y + 0 outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 1.100000 -z 0.100000" "0.100000" # size x y + 0 outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 2.100000 -y 1.000000 -z -0.400000" "0.100000" # size x y + 0 outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 2.100000 -y 1.000000 -z -0.400000" "0.100000" # size x y + 0 outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 1.100000 -z -0.400000" "0.100000" # size x y + 0 outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 1.100000 -z -0.400000" "0.100000" # size x y + 0 outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.900000 -y 1.000000 -z -0.100000" "0.100000" # size x y + 0 inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.900000 -y 1.000000 -z -0.100000" "0.100000" # size x y + 0 inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.900000 -z -0.100000" "0.100000" # size x y + 0 inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.900000 -z -0.100000" "0.100000" # size x y + 0 inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.900000 -y 1.000000 -z -0.600000" "0.100000" # size x y + 0 inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.900000 -y 1.000000 -z -0.600000" "0.100000" # size x y + 0 inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.900000 -z -0.600000" "0.100000" # size x y + 0 inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.900000 -z -0.600000" "0.100000" # size x y + 0 inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 2.100000 -y 1.000000 -z -0.200000" "0.223607" # size x y + 0 outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 2.100000 -y 1.000000 -z -0.200000" "0.223607" # size x y + 0 outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 1.100000 -z -0.200000" "0.223607" # size x y + 0 outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 1.100000 -z -0.200000" "0.223607" # size x y + 0 outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 2.100000 -y 1.000000 -z -0.700000" "0.223607" # size x y + 0 outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 2.100000 -y 1.000000 -z -0.700000" "0.223607" # size x y + 0 outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 1.100000 -z -0.700000" "0.223607" # size x y + 0 outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 1.100000 -z -0.700000" "0.223607" # size x y + 0 outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.900000 -y 1.000000 -z 0.800000" "-0.100000" # size x y + 0 inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.900000 -y 1.000000 -z 0.800000" "-0.100000" # size x y + 0 inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.900000 -z 0.800000" "-0.100000" # size x y + 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.900000 -z 0.800000" "-0.100000" # size x y + 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.900000 -y 1.000000 -z 0.300000" "-0.100000" # size x y + 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.900000 -y 1.000000 -z 0.300000" "-0.100000" # size x y + 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.900000 -z 0.300000" "-0.100000" # size x y + 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.900000 -z 0.300000" "-0.100000" # size x y + 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.800000 -y 1.000000 -z 0.900000" "-0.100000" # size x y + 0 inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.800000 -y 1.000000 -z 0.900000" "-0.100000" # size x y + 0 inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.800000 -z 0.900000" "-0.100000" # size x y + 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.800000 -z 0.900000" "-0.100000" # size x y + 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.800000 -y 1.000000 -z 0.400000" "-0.100000" # size x y + 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.800000 -y 1.000000 -z 0.400000" "-0.100000" # size x y + 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.800000 -z 0.400000" "-0.100000" # size x y + 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.800000 -z 0.400000" "-0.100000" # size x y + 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 2.100000 -y 1.000000 -z 0.900000" "0.100000" # size x y + 0 outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 2.100000 -y 1.000000 -z 0.900000" "0.100000" # size x y + 0 outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 1.100000 -z 0.900000" "0.100000" # size x y + 0 outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 1.100000 -z 0.900000" "0.100000" # size x y + 0 outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 2.100000 -y 1.000000 -z 0.400000" "0.100000" # size x y + 0 outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 2.100000 -y 1.000000 -z 0.400000" "0.100000" # size x y + 0 outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 1.100000 -z 0.400000" "0.100000" # size x y + 0 outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 1.100000 -z 0.400000" "0.100000" # size x y + 0 outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.900000 -y 1.000000 -z 1.100000" "0.100000" # size x y + 0 inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.900000 -y 1.000000 -z 1.100000" "0.100000" # size x y + 0 inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.900000 -z 1.100000" "0.100000" # size x y + 0 inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.900000 -z 1.100000" "0.100000" # size x y + 0 inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.900000 -y 1.000000 -z 0.600000" "0.100000" # size x y + 0 inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.900000 -y 1.000000 -z 0.600000" "0.100000" # size x y + 0 inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.900000 -z 0.600000" "0.100000" # size x y + 0 inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.900000 -z 0.600000" "0.100000" # size x y + 0 inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 2.100000 -y 1.000000 -z 1.200000" "0.223607" # size x y + 0 outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 2.100000 -y 1.000000 -z 1.200000" "0.223607" # size x y + 0 outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 1.100000 -z 1.200000" "0.223607" # size x y + 0 outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 1.100000 -z 1.200000" "0.223607" # size x y + 0 outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 2.100000 -y 1.000000 -z 0.700000" "0.223607" # size x y + 0 outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 2.100000 -y 1.000000 -z 0.700000" "0.223607" # size x y + 0 outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 1.100000 -z 0.700000" "0.223607" # size x y + 0 outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 1.100000 -z 0.700000" "0.223607" # size x y + 0 outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 0.513728 -z 0.500000" "-0.100000" # size x y - - inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 0.513728 -z 0.500000" "-0.100000" # size x y - - inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 0.500000" "-0.100000" # size x y - - inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 0.500000" "-0.100000" # size x y - - inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 0.513728" "-0.100000" # size x y - - inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 0.513728" "-0.100000" # size x y - - inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y -0.486272" "-0.100000" # size x y - - inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272" "-0.100000" # size x y - - inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 0.405667 -z 0.500000" "0.100000" # size x y - - outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 0.405667 -z 0.500000" "0.100000" # size x y - - outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 0.500000" "0.100000" # size x y - - outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 0.500000" "0.100000" # size x y - - outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 0.405667" "0.100000" # size x y - - outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 0.405667" "0.100000" # size x y - - outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y -0.594333" "0.100000" # size x y - - outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333" "0.100000" # size x y - - outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 0.513728 -z 0.200000" "-0.100000" # size x y - - inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 0.513728 -z 0.200000" "-0.100000" # size x y - - inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size x y - - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size x y - - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 0.513728 -z -0.300000" "-0.100000" # size x y - - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 0.513728 -z -0.300000" "-0.100000" # size x y - - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z -0.300000" "-0.100000" # size x y - - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z -0.300000" "-0.100000" # size x y - - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.326823 -y 0.567758 -z 0.100000" "-0.100000" # size x y - - inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.326823 -y 0.567758 -z 0.100000" "-0.100000" # size x y - - inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size x y - - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size x y - - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.326823 -y 0.567758 -z -0.400000" "-0.100000" # size x y - - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.326823 -y 0.567758 -z -0.400000" "-0.100000" # size x y - - inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.673177 -y -0.432242 -z -0.400000" "-0.100000" # size x y - - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.673177 -y -0.432242 -z -0.400000" "-0.100000" # size x y - - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 0.405667 -z 0.100000" "0.100000" # size x y - - outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 0.405667 -z 0.100000" "0.100000" # size x y - - outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 0.100000" "0.100000" # size x y - - outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 0.100000" "0.100000" # size x y - - outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 0.405667 -z -0.400000" "0.100000" # size x y - - outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 0.405667 -z -0.400000" "0.100000" # size x y - - outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z -0.400000" "0.100000" # size x y - - outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z -0.400000" "0.100000" # size x y - - outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 0.513728 -z -0.100000" "0.100000" # size x y - - inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 0.513728 -z -0.100000" "0.100000" # size x y - - inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y -0.486272 -z -0.100000" "0.100000" # size x y - - inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z -0.100000" "0.100000" # size x y - - inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 0.513728 -z -0.600000" "0.100000" # size x y - - inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 0.513728 -z -0.600000" "0.100000" # size x y - - inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z -0.600000" "0.100000" # size x y - - inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z -0.600000" "0.100000" # size x y - - inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 0.405667 -z -0.200000" "0.223607" # size x y - - outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 0.405667 -z -0.200000" "0.223607" # size x y - - outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y -0.594333 -z -0.200000" "0.223607" # size x y - - outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z -0.200000" "0.223607" # size x y - - outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 0.405667 -z -0.700000" "0.223607" # size x y - - outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 0.405667 -z -0.700000" "0.223607" # size x y - - outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z -0.700000" "0.223607" # size x y - - outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z -0.700000" "0.223607" # size x y - - outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 0.513728 -z 0.800000" "-0.100000" # size x y - - inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 0.513728 -z 0.800000" "-0.100000" # size x y - - inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 0.800000" "-0.100000" # size x y - - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 0.800000" "-0.100000" # size x y - - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 0.513728 -z 0.300000" "-0.100000" # size x y - - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 0.513728 -z 0.300000" "-0.100000" # size x y - - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z 0.300000" "-0.100000" # size x y - - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z 0.300000" "-0.100000" # size x y - - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.326823 -y 0.567758 -z 0.900000" "-0.100000" # size x y - - inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.326823 -y 0.567758 -z 0.900000" "-0.100000" # size x y - - inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.673177 -y -0.432242 -z 0.900000" "-0.100000" # size x y - - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.673177 -y -0.432242 -z 0.900000" "-0.100000" # size x y - - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.326823 -y 0.567758 -z 0.400000" "-0.100000" # size x y - - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.326823 -y 0.567758 -z 0.400000" "-0.100000" # size x y - - inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.673177 -y -0.432242 -z 0.400000" "-0.100000" # size x y - - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.673177 -y -0.432242 -z 0.400000" "-0.100000" # size x y - - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 0.405667 -z 0.900000" "0.100000" # size x y - - outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 0.405667 -z 0.900000" "0.100000" # size x y - - outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 0.900000" "0.100000" # size x y - - outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 0.900000" "0.100000" # size x y - - outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 0.405667 -z 0.400000" "0.100000" # size x y - - outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 0.405667 -z 0.400000" "0.100000" # size x y - - outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z 0.400000" "0.100000" # size x y - - outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z 0.400000" "0.100000" # size x y - - outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 0.513728 -z 1.100000" "0.100000" # size x y - - inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 0.513728 -z 1.100000" "0.100000" # size x y - - inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 1.100000" "0.100000" # size x y - - inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 1.100000" "0.100000" # size x y - - inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 0.513728 -z 0.600000" "0.100000" # size x y - - inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 0.513728 -z 0.600000" "0.100000" # size x y - - inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z 0.600000" "0.100000" # size x y - - inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z 0.600000" "0.100000" # size x y - - inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 0.405667 -z 1.200000" "0.223607" # size x y - - outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 0.405667 -z 1.200000" "0.223607" # size x y - - outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 1.200000" "0.223607" # size x y - - outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 1.200000" "0.223607" # size x y - - outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 0.405667 -z 0.700000" "0.223607" # size x y - - outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 0.405667 -z 0.700000" "0.223607" # size x y - - outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z 0.700000" "0.223607" # size x y - - outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z 0.700000" "0.223607" # size x y - - outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 1.486272 -z 0.500000" "-0.100000" # size x y - + inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 1.486272 -z 0.500000" "-0.100000" # size x y - + inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 0.500000" "-0.100000" # size x y - + inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 0.500000" "-0.100000" # size x y - + inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 1.486272" "-0.100000" # size x y - + inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 1.486272" "-0.100000" # size x y - + inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y 0.486272" "-0.100000" # size x y - + inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272" "-0.100000" # size x y - + inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 1.594333 -z 0.500000" "0.100000" # size x y - + outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 1.594333 -z 0.500000" "0.100000" # size x y - + outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 0.500000" "0.100000" # size x y - + outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 0.500000" "0.100000" # size x y - + outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 1.594333" "0.100000" # size x y - + outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 1.594333" "0.100000" # size x y - + outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y 0.594333" "0.100000" # size x y - + outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333" "0.100000" # size x y - + outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 1.486272 -z 0.200000" "-0.100000" # size x y - + inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 1.486272 -z 0.200000" "-0.100000" # size x y - + inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size x y - + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size x y - + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 1.486272 -z -0.300000" "-0.100000" # size x y - + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 1.486272 -z -0.300000" "-0.100000" # size x y - + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z -0.300000" "-0.100000" # size x y - + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z -0.300000" "-0.100000" # size x y - + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.326823 -y 1.432242 -z 0.100000" "-0.100000" # size x y - + inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.326823 -y 1.432242 -z 0.100000" "-0.100000" # size x y - + inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size x y - + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size x y - + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.326823 -y 1.432242 -z -0.400000" "-0.100000" # size x y - + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.326823 -y 1.432242 -z -0.400000" "-0.100000" # size x y - + inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.673177 -y 0.432242 -z -0.400000" "-0.100000" # size x y - + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.673177 -y 0.432242 -z -0.400000" "-0.100000" # size x y - + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 1.594333 -z 0.100000" "0.100000" # size x y - + outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 1.594333 -z 0.100000" "0.100000" # size x y - + outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 0.100000" "0.100000" # size x y - + outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 0.100000" "0.100000" # size x y - + outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 1.594333 -z -0.400000" "0.100000" # size x y - + outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 1.594333 -z -0.400000" "0.100000" # size x y - + outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z -0.400000" "0.100000" # size x y - + outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z -0.400000" "0.100000" # size x y - + outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 1.486272 -z -0.100000" "0.100000" # size x y - + inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 1.486272 -z -0.100000" "0.100000" # size x y - + inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y 0.486272 -z -0.100000" "0.100000" # size x y - + inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z -0.100000" "0.100000" # size x y - + inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 1.486272 -z -0.600000" "0.100000" # size x y - + inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 1.486272 -z -0.600000" "0.100000" # size x y - + inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z -0.600000" "0.100000" # size x y - + inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z -0.600000" "0.100000" # size x y - + inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 1.594333 -z -0.200000" "0.223607" # size x y - + outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 1.594333 -z -0.200000" "0.223607" # size x y - + outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y 0.594333 -z -0.200000" "0.223607" # size x y - + outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z -0.200000" "0.223607" # size x y - + outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 1.594333 -z -0.700000" "0.223607" # size x y - + outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 1.594333 -z -0.700000" "0.223607" # size x y - + outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z -0.700000" "0.223607" # size x y - + outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z -0.700000" "0.223607" # size x y - + outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 1.486272 -z 0.800000" "-0.100000" # size x y - + inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 1.486272 -z 0.800000" "-0.100000" # size x y - + inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 0.800000" "-0.100000" # size x y - + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 0.800000" "-0.100000" # size x y - + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 1.486272 -z 0.300000" "-0.100000" # size x y - + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 1.486272 -z 0.300000" "-0.100000" # size x y - + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z 0.300000" "-0.100000" # size x y - + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z 0.300000" "-0.100000" # size x y - + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.326823 -y 1.432242 -z 0.900000" "-0.100000" # size x y - + inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.326823 -y 1.432242 -z 0.900000" "-0.100000" # size x y - + inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.673177 -y 0.432242 -z 0.900000" "-0.100000" # size x y - + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.673177 -y 0.432242 -z 0.900000" "-0.100000" # size x y - + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.326823 -y 1.432242 -z 0.400000" "-0.100000" # size x y - + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.326823 -y 1.432242 -z 0.400000" "-0.100000" # size x y - + inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.673177 -y 0.432242 -z 0.400000" "-0.100000" # size x y - + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.673177 -y 0.432242 -z 0.400000" "-0.100000" # size x y - + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 1.594333 -z 0.900000" "0.100000" # size x y - + outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 1.594333 -z 0.900000" "0.100000" # size x y - + outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 0.900000" "0.100000" # size x y - + outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 0.900000" "0.100000" # size x y - + outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 1.594333 -z 0.400000" "0.100000" # size x y - + outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 1.594333 -z 0.400000" "0.100000" # size x y - + outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z 0.400000" "0.100000" # size x y - + outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z 0.400000" "0.100000" # size x y - + outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.242676 -y 1.486272 -z 1.100000" "0.100000" # size x y - + inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.242676 -y 1.486272 -z 1.100000" "0.100000" # size x y - + inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 1.100000" "0.100000" # size x y - + inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 1.100000" "0.100000" # size x y - + inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.242676 -y 1.486272 -z 0.600000" "0.100000" # size x y - + inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.242676 -y 1.486272 -z 0.600000" "0.100000" # size x y - + inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z 0.600000" "0.100000" # size x y - + inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z 0.600000" "0.100000" # size x y - + inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 0.074382 -y 1.594333 -z 1.200000" "0.223607" # size x y - + outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 0.074382 -y 1.594333 -z 1.200000" "0.223607" # size x y - + outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 1.200000" "0.223607" # size x y - + outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 1.200000" "0.223607" # size x y - + outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 0.074382 -y 1.594333 -z 0.700000" "0.223607" # size x y - + outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 0.074382 -y 1.594333 -z 0.700000" "0.223607" # size x y - + outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z 0.700000" "0.223607" # size x y - + outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z 0.700000" "0.223607" # size x y - + outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 0.513728 -z 0.500000" "-0.100000" # size x y + - inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 0.513728 -z 0.500000" "-0.100000" # size x y + - inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 0.500000" "-0.100000" # size x y + - inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 0.500000" "-0.100000" # size x y + - inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 0.513728" "-0.100000" # size x y + - inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 0.513728" "-0.100000" # size x y + - inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y -0.486272" "-0.100000" # size x y + - inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272" "-0.100000" # size x y + - inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 0.405667 -z 0.500000" "0.100000" # size x y + - outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 0.405667 -z 0.500000" "0.100000" # size x y + - outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 0.500000" "0.100000" # size x y + - outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 0.500000" "0.100000" # size x y + - outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 0.405667" "0.100000" # size x y + - outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 0.405667" "0.100000" # size x y + - outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y -0.594333" "0.100000" # size x y + - outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333" "0.100000" # size x y + - outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 0.513728 -z 0.200000" "-0.100000" # size x y + - inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 0.513728 -z 0.200000" "-0.100000" # size x y + - inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size x y + - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size x y + - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 0.513728 -z -0.300000" "-0.100000" # size x y + - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 0.513728 -z -0.300000" "-0.100000" # size x y + - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z -0.300000" "-0.100000" # size x y + - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z -0.300000" "-0.100000" # size x y + - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.673177 -y 0.567758 -z 0.100000" "-0.100000" # size x y + - inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.673177 -y 0.567758 -z 0.100000" "-0.100000" # size x y + - inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size x y + - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size x y + - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.673177 -y 0.567758 -z -0.400000" "-0.100000" # size x y + - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.673177 -y 0.567758 -z -0.400000" "-0.100000" # size x y + - inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.673177 -y -0.432242 -z -0.400000" "-0.100000" # size x y + - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.673177 -y -0.432242 -z -0.400000" "-0.100000" # size x y + - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 0.405667 -z 0.100000" "0.100000" # size x y + - outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 0.405667 -z 0.100000" "0.100000" # size x y + - outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 0.100000" "0.100000" # size x y + - outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 0.100000" "0.100000" # size x y + - outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 0.405667 -z -0.400000" "0.100000" # size x y + - outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 0.405667 -z -0.400000" "0.100000" # size x y + - outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z -0.400000" "0.100000" # size x y + - outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z -0.400000" "0.100000" # size x y + - outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 0.513728 -z -0.100000" "0.100000" # size x y + - inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 0.513728 -z -0.100000" "0.100000" # size x y + - inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y -0.486272 -z -0.100000" "0.100000" # size x y + - inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z -0.100000" "0.100000" # size x y + - inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 0.513728 -z -0.600000" "0.100000" # size x y + - inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 0.513728 -z -0.600000" "0.100000" # size x y + - inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z -0.600000" "0.100000" # size x y + - inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z -0.600000" "0.100000" # size x y + - inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 0.405667 -z -0.200000" "0.223607" # size x y + - outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 0.405667 -z -0.200000" "0.223607" # size x y + - outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y -0.594333 -z -0.200000" "0.223607" # size x y + - outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z -0.200000" "0.223607" # size x y + - outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 0.405667 -z -0.700000" "0.223607" # size x y + - outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 0.405667 -z -0.700000" "0.223607" # size x y + - outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z -0.700000" "0.223607" # size x y + - outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z -0.700000" "0.223607" # size x y + - outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 0.513728 -z 0.800000" "-0.100000" # size x y + - inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 0.513728 -z 0.800000" "-0.100000" # size x y + - inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 0.800000" "-0.100000" # size x y + - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 0.800000" "-0.100000" # size x y + - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 0.513728 -z 0.300000" "-0.100000" # size x y + - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 0.513728 -z 0.300000" "-0.100000" # size x y + - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z 0.300000" "-0.100000" # size x y + - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z 0.300000" "-0.100000" # size x y + - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.673177 -y 0.567758 -z 0.900000" "-0.100000" # size x y + - inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.673177 -y 0.567758 -z 0.900000" "-0.100000" # size x y + - inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.673177 -y -0.432242 -z 0.900000" "-0.100000" # size x y + - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.673177 -y -0.432242 -z 0.900000" "-0.100000" # size x y + - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.673177 -y 0.567758 -z 0.400000" "-0.100000" # size x y + - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.673177 -y 0.567758 -z 0.400000" "-0.100000" # size x y + - inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.673177 -y -0.432242 -z 0.400000" "-0.100000" # size x y + - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.673177 -y -0.432242 -z 0.400000" "-0.100000" # size x y + - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 0.405667 -z 0.900000" "0.100000" # size x y + - outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 0.405667 -z 0.900000" "0.100000" # size x y + - outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 0.900000" "0.100000" # size x y + - outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 0.900000" "0.100000" # size x y + - outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 0.405667 -z 0.400000" "0.100000" # size x y + - outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 0.405667 -z 0.400000" "0.100000" # size x y + - outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z 0.400000" "0.100000" # size x y + - outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z 0.400000" "0.100000" # size x y + - outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 0.513728 -z 1.100000" "0.100000" # size x y + - inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 0.513728 -z 1.100000" "0.100000" # size x y + - inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 1.100000" "0.100000" # size x y + - inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 1.100000" "0.100000" # size x y + - inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 0.513728 -z 0.600000" "0.100000" # size x y + - inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 0.513728 -z 0.600000" "0.100000" # size x y + - inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z 0.600000" "0.100000" # size x y + - inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z 0.600000" "0.100000" # size x y + - inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 0.405667 -z 1.200000" "0.223607" # size x y + - outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 0.405667 -z 1.200000" "0.223607" # size x y + - outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 1.200000" "0.223607" # size x y + - outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 1.200000" "0.223607" # size x y + - outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 0.405667 -z 0.700000" "0.223607" # size x y + - outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 0.405667 -z 0.700000" "0.223607" # size x y + - outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z 0.700000" "0.223607" # size x y + - outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z 0.700000" "0.223607" # size x y + - outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 1.486272 -z 0.500000" "-0.100000" # size x y + + inside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 1.486272 -z 0.500000" "-0.100000" # size x y + + inside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 0.500000" "-0.100000" # size x y + + inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 0.500000" "-0.100000" # size x y + + inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 1.486272" "-0.100000" # size x y + + inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 1.486272" "-0.100000" # size x y + + inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y 0.486272" "-0.100000" # size x y + + inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272" "-0.100000" # size x y + + inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 1.594333 -z 0.500000" "0.100000" # size x y + + outside 0 short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 1.594333 -z 0.500000" "0.100000" # size x y + + outside 0 long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 0.500000" "0.100000" # size x y + + outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 0.500000" "0.100000" # size x y + + outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 1.594333" "0.100000" # size x y + + outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 1.594333" "0.100000" # size x y + + outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y 0.594333" "0.100000" # size x y + + outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333" "0.100000" # size x y + + outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 1.486272 -z 0.200000" "-0.100000" # size x y + + inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 1.486272 -z 0.200000" "-0.100000" # size x y + + inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size x y + + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size x y + + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 1.486272 -z -0.300000" "-0.100000" # size x y + + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 1.486272 -z -0.300000" "-0.100000" # size x y + + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z -0.300000" "-0.100000" # size x y + + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z -0.300000" "-0.100000" # size x y + + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.673177 -y 1.432242 -z 0.100000" "-0.100000" # size x y + + inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.673177 -y 1.432242 -z 0.100000" "-0.100000" # size x y + + inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size x y + + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size x y + + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.673177 -y 1.432242 -z -0.400000" "-0.100000" # size x y + + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.673177 -y 1.432242 -z -0.400000" "-0.100000" # size x y + + inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.673177 -y 0.432242 -z -0.400000" "-0.100000" # size x y + + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.673177 -y 0.432242 -z -0.400000" "-0.100000" # size x y + + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 1.594333 -z 0.100000" "0.100000" # size x y + + outside - inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 1.594333 -z 0.100000" "0.100000" # size x y + + outside - inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 0.100000" "0.100000" # size x y + + outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 0.100000" "0.100000" # size x y + + outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 1.594333 -z -0.400000" "0.100000" # size x y + + outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 1.594333 -z -0.400000" "0.100000" # size x y + + outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z -0.400000" "0.100000" # size x y + + outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z -0.400000" "0.100000" # size x y + + outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 1.486272 -z -0.100000" "0.100000" # size x y + + inside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 1.486272 -z -0.100000" "0.100000" # size x y + + inside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y 0.486272 -z -0.100000" "0.100000" # size x y + + inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z -0.100000" "0.100000" # size x y + + inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 1.486272 -z -0.600000" "0.100000" # size x y + + inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 1.486272 -z -0.600000" "0.100000" # size x y + + inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z -0.600000" "0.100000" # size x y + + inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z -0.600000" "0.100000" # size x y + + inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 1.594333 -z -0.200000" "0.223607" # size x y + + outside - outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 1.594333 -z -0.200000" "0.223607" # size x y + + outside - outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y 0.594333 -z -0.200000" "0.223607" # size x y + + outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z -0.200000" "0.223607" # size x y + + outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 1.594333 -z -0.700000" "0.223607" # size x y + + outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 1.594333 -z -0.700000" "0.223607" # size x y + + outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z -0.700000" "0.223607" # size x y + + outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z -0.700000" "0.223607" # size x y + + outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 1.486272 -z 0.800000" "-0.100000" # size x y + + inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 1.486272 -z 0.800000" "-0.100000" # size x y + + inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 0.800000" "-0.100000" # size x y + + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 0.800000" "-0.100000" # size x y + + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 1.486272 -z 0.300000" "-0.100000" # size x y + + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 1.486272 -z 0.300000" "-0.100000" # size x y + + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z 0.300000" "-0.100000" # size x y + + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z 0.300000" "-0.100000" # size x y + + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.673177 -y 1.432242 -z 0.900000" "-0.100000" # size x y + + inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.673177 -y 1.432242 -z 0.900000" "-0.100000" # size x y + + inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.673177 -y 0.432242 -z 0.900000" "-0.100000" # size x y + + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.673177 -y 0.432242 -z 0.900000" "-0.100000" # size x y + + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.673177 -y 1.432242 -z 0.400000" "-0.100000" # size x y + + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.673177 -y 1.432242 -z 0.400000" "-0.100000" # size x y + + inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.673177 -y 0.432242 -z 0.400000" "-0.100000" # size x y + + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.673177 -y 0.432242 -z 0.400000" "-0.100000" # size x y + + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 1.594333 -z 0.900000" "0.100000" # size x y + + outside + inside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 1.594333 -z 0.900000" "0.100000" # size x y + + outside + inside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 0.900000" "0.100000" # size x y + + outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 0.900000" "0.100000" # size x y + + outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 1.594333 -z 0.400000" "0.100000" # size x y + + outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 1.594333 -z 0.400000" "0.100000" # size x y + + outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z 0.400000" "0.100000" # size x y + + outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z 0.400000" "0.100000" # size x y + + outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.757324 -y 1.486272 -z 1.100000" "0.100000" # size x y + + inside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.757324 -y 1.486272 -z 1.100000" "0.100000" # size x y + + inside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 1.100000" "0.100000" # size x y + + inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 1.100000" "0.100000" # size x y + + inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.757324 -y 1.486272 -z 0.600000" "0.100000" # size x y + + inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.757324 -y 1.486272 -z 0.600000" "0.100000" # size x y + + inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z 0.600000" "0.100000" # size x y + + inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z 0.600000" "0.100000" # size x y + + inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 | bin/sample -x 1.925618 -y 1.594333 -z 1.200000" "0.223607" # size x y + + outside + outside short
  check_successful "bin/cylinder --size-xy 2 | bin/sample -x 1.925618 -y 1.594333 -z 1.200000" "0.223607" # size x y + + outside + outside long
  check_successful "bin/cylinder -sxy 2 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 1.200000" "0.223607" # size x y + + outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 1.200000" "0.223607" # size x y + + outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -cz | bin/sample -x 1.925618 -y 1.594333 -z 0.700000" "0.223607" # size x y + + outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --center-z | bin/sample -x 1.925618 -y 1.594333 -z 0.700000" "0.223607" # size x y + + outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z 0.700000" "0.223607" # size x y + + outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z 0.700000" "0.223607" # size x y + + outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.000000 -z 0.100000" "-0.100000" # size z size x y 0 0 - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.000000 -z 0.100000" "-0.100000" # size z size x y 0 0 - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -z 0.100000" "-0.100000" # size z size x y 0 0 - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -z 0.100000" "-0.100000" # size z size x y 0 0 - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.000000 -z -1.400000" "-0.100000" # size z size x y 0 0 - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -1.400000" "-0.100000" # size z size x y 0 0 - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -z -1.400000" "-0.100000" # size z size x y 0 0 - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -z -1.400000" "-0.100000" # size z size x y 0 0 - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.000000 -z -0.100000" "0.100000" # size z size x y 0 0 - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.000000 -z -0.100000" "0.100000" # size z size x y 0 0 - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -z -0.100000" "0.100000" # size z size x y 0 0 - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -z -0.100000" "0.100000" # size z size x y 0 0 - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.000000 -z -1.600000" "0.100000" # size z size x y 0 0 - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.000000 -z -1.600000" "0.100000" # size z size x y 0 0 - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -z -1.600000" "0.100000" # size z size x y 0 0 - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -z -1.600000" "0.100000" # size z size x y 0 0 - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.000000 -z 2.900000" "-0.100000" # size z size x y 0 0 + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.000000 -z 2.900000" "-0.100000" # size z size x y 0 0 + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -z 2.900000" "-0.100000" # size z size x y 0 0 + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -z 2.900000" "-0.100000" # size z size x y 0 0 + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.000000 -z 1.400000" "-0.100000" # size z size x y 0 0 + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.000000 -z 1.400000" "-0.100000" # size z size x y 0 0 + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -z 1.400000" "-0.100000" # size z size x y 0 0 + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -z 1.400000" "-0.100000" # size z size x y 0 0 + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.000000 -z 3.100000" "0.100000" # size z size x y 0 0 + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.000000 -z 3.100000" "0.100000" # size z size x y 0 0 + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -z 3.100000" "0.100000" # size z size x y 0 0 + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -z 3.100000" "0.100000" # size z size x y 0 0 + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.000000 -z 1.600000" "0.100000" # size z size x y 0 0 + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.000000 -z 1.600000" "0.100000" # size z size x y 0 0 + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -z 1.600000" "0.100000" # size z size x y 0 0 + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -z 1.600000" "0.100000" # size z size x y 0 0 + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.100000 -z 1.500000" "-0.100000" # size z size x y 0 - inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.100000 -z 1.500000" "-0.100000" # size z size x y 0 - inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.900000 -z 1.500000" "-0.100000" # size z size x y 0 - inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.900000 -z 1.500000" "-0.100000" # size z size x y 0 - inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.100000" "-0.100000" # size z size x y 0 - inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.100000" "-0.100000" # size z size x y 0 - inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.900000" "-0.100000" # size z size x y 0 - inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.900000" "-0.100000" # size z size x y 0 - inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y -0.100000 -z 1.500000" "0.100000" # size z size x y 0 - outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y -0.100000 -z 1.500000" "0.100000" # size z size x y 0 - outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -1.100000 -z 1.500000" "0.100000" # size z size x y 0 - outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -1.100000 -z 1.500000" "0.100000" # size z size x y 0 - outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y -0.100000" "0.100000" # size z size x y 0 - outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y -0.100000" "0.100000" # size z size x y 0 - outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -1.100000" "0.100000" # size z size x y 0 - outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -1.100000" "0.100000" # size z size x y 0 - outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.100000 -z 0.200000" "-0.100000" # size z size x y 0 - inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.100000 -z 0.200000" "-0.100000" # size z size x y 0 - inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.900000 -z 0.200000" "-0.100000" # size z size x y 0 - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.900000 -z 0.200000" "-0.100000" # size z size x y 0 - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.100000 -z -1.300000" "-0.100000" # size z size x y 0 - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.100000 -z -1.300000" "-0.100000" # size z size x y 0 - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.900000 -z -1.300000" "-0.100000" # size z size x y 0 - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.900000 -z -1.300000" "-0.100000" # size z size x y 0 - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.200000 -z 0.100000" "-0.100000" # size z size x y 0 - inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.200000 -z 0.100000" "-0.100000" # size z size x y 0 - inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.800000 -z 0.100000" "-0.100000" # size z size x y 0 - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.800000 -z 0.100000" "-0.100000" # size z size x y 0 - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.200000 -z -1.400000" "-0.100000" # size z size x y 0 - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.200000 -z -1.400000" "-0.100000" # size z size x y 0 - inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.800000 -z -1.400000" "-0.100000" # size z size x y 0 - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.800000 -z -1.400000" "-0.100000" # size z size x y 0 - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y -0.100000 -z 0.100000" "0.100000" # size z size x y 0 - outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y -0.100000 -z 0.100000" "0.100000" # size z size x y 0 - outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -1.100000 -z 0.100000" "0.100000" # size z size x y 0 - outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -1.100000 -z 0.100000" "0.100000" # size z size x y 0 - outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y -0.100000 -z -1.400000" "0.100000" # size z size x y 0 - outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y -0.100000 -z -1.400000" "0.100000" # size z size x y 0 - outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -1.100000 -z -1.400000" "0.100000" # size z size x y 0 - outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -1.100000 -z -1.400000" "0.100000" # size z size x y 0 - outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.100000 -z -0.100000" "0.100000" # size z size x y 0 - inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.100000 -z -0.100000" "0.100000" # size z size x y 0 - inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.900000 -z -0.100000" "0.100000" # size z size x y 0 - inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.900000 -z -0.100000" "0.100000" # size z size x y 0 - inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.100000 -z -1.600000" "0.100000" # size z size x y 0 - inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.100000 -z -1.600000" "0.100000" # size z size x y 0 - inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.900000 -z -1.600000" "0.100000" # size z size x y 0 - inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.900000 -z -1.600000" "0.100000" # size z size x y 0 - inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y -0.100000 -z -0.200000" "0.223607" # size z size x y 0 - outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y -0.100000 -z -0.200000" "0.223607" # size z size x y 0 - outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -1.100000 -z -0.200000" "0.223607" # size z size x y 0 - outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -1.100000 -z -0.200000" "0.223607" # size z size x y 0 - outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y -0.100000 -z -1.700000" "0.223607" # size z size x y 0 - outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y -0.100000 -z -1.700000" "0.223607" # size z size x y 0 - outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -1.100000 -z -1.700000" "0.223607" # size z size x y 0 - outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -1.100000 -z -1.700000" "0.223607" # size z size x y 0 - outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.100000 -z 2.800000" "-0.100000" # size z size x y 0 - inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.100000 -z 2.800000" "-0.100000" # size z size x y 0 - inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.900000 -z 2.800000" "-0.100000" # size z size x y 0 - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.900000 -z 2.800000" "-0.100000" # size z size x y 0 - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.100000 -z 1.300000" "-0.100000" # size z size x y 0 - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.100000 -z 1.300000" "-0.100000" # size z size x y 0 - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.900000 -z 1.300000" "-0.100000" # size z size x y 0 - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.900000 -z 1.300000" "-0.100000" # size z size x y 0 - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.200000 -z 2.900000" "-0.100000" # size z size x y 0 - inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.200000 -z 2.900000" "-0.100000" # size z size x y 0 - inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.800000 -z 2.900000" "-0.100000" # size z size x y 0 - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.800000 -z 2.900000" "-0.100000" # size z size x y 0 - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.200000 -z 1.400000" "-0.100000" # size z size x y 0 - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.200000 -z 1.400000" "-0.100000" # size z size x y 0 - inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.800000 -z 1.400000" "-0.100000" # size z size x y 0 - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.800000 -z 1.400000" "-0.100000" # size z size x y 0 - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y -0.100000 -z 2.900000" "0.100000" # size z size x y 0 - outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y -0.100000 -z 2.900000" "0.100000" # size z size x y 0 - outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -1.100000 -z 2.900000" "0.100000" # size z size x y 0 - outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -1.100000 -z 2.900000" "0.100000" # size z size x y 0 - outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y -0.100000 -z 1.400000" "0.100000" # size z size x y 0 - outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y -0.100000 -z 1.400000" "0.100000" # size z size x y 0 - outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -1.100000 -z 1.400000" "0.100000" # size z size x y 0 - outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -1.100000 -z 1.400000" "0.100000" # size z size x y 0 - outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 0.100000 -z 3.100000" "0.100000" # size z size x y 0 - inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 0.100000 -z 3.100000" "0.100000" # size z size x y 0 - inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -0.900000 -z 3.100000" "0.100000" # size z size x y 0 - inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -0.900000 -z 3.100000" "0.100000" # size z size x y 0 - inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 0.100000 -z 1.600000" "0.100000" # size z size x y 0 - inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 0.100000 -z 1.600000" "0.100000" # size z size x y 0 - inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -0.900000 -z 1.600000" "0.100000" # size z size x y 0 - inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -0.900000 -z 1.600000" "0.100000" # size z size x y 0 - inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y -0.100000 -z 3.200000" "0.223607" # size z size x y 0 - outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y -0.100000 -z 3.200000" "0.223607" # size z size x y 0 - outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y -1.100000 -z 3.200000" "0.223607" # size z size x y 0 - outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y -1.100000 -z 3.200000" "0.223607" # size z size x y 0 - outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y -0.100000 -z 1.700000" "0.223607" # size z size x y 0 - outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y -0.100000 -z 1.700000" "0.223607" # size z size x y 0 - outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y -1.100000 -z 1.700000" "0.223607" # size z size x y 0 - outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y -1.100000 -z 1.700000" "0.223607" # size z size x y 0 - outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.900000 -z 1.500000" "-0.100000" # size z size x y 0 + inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.900000 -z 1.500000" "-0.100000" # size z size x y 0 + inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.900000 -z 1.500000" "-0.100000" # size z size x y 0 + inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.900000 -z 1.500000" "-0.100000" # size z size x y 0 + inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.900000" "-0.100000" # size z size x y 0 + inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.900000" "-0.100000" # size z size x y 0 + inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.900000" "-0.100000" # size z size x y 0 + inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.900000" "-0.100000" # size z size x y 0 + inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 2.100000 -z 1.500000" "0.100000" # size z size x y 0 + outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 2.100000 -z 1.500000" "0.100000" # size z size x y 0 + outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 1.100000 -z 1.500000" "0.100000" # size z size x y 0 + outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 1.100000 -z 1.500000" "0.100000" # size z size x y 0 + outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 2.100000" "0.100000" # size z size x y 0 + outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 2.100000" "0.100000" # size z size x y 0 + outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 1.100000" "0.100000" # size z size x y 0 + outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 1.100000" "0.100000" # size z size x y 0 + outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.900000 -z 0.200000" "-0.100000" # size z size x y 0 + inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.900000 -z 0.200000" "-0.100000" # size z size x y 0 + inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.900000 -z 0.200000" "-0.100000" # size z size x y 0 + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.900000 -z 0.200000" "-0.100000" # size z size x y 0 + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.900000 -z -1.300000" "-0.100000" # size z size x y 0 + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.900000 -z -1.300000" "-0.100000" # size z size x y 0 + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.900000 -z -1.300000" "-0.100000" # size z size x y 0 + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.900000 -z -1.300000" "-0.100000" # size z size x y 0 + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.800000 -z 0.100000" "-0.100000" # size z size x y 0 + inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.800000 -z 0.100000" "-0.100000" # size z size x y 0 + inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.800000 -z 0.100000" "-0.100000" # size z size x y 0 + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.800000 -z 0.100000" "-0.100000" # size z size x y 0 + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.800000 -z -1.400000" "-0.100000" # size z size x y 0 + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.800000 -z -1.400000" "-0.100000" # size z size x y 0 + inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.800000 -z -1.400000" "-0.100000" # size z size x y 0 + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.800000 -z -1.400000" "-0.100000" # size z size x y 0 + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 2.100000 -z 0.100000" "0.100000" # size z size x y 0 + outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 2.100000 -z 0.100000" "0.100000" # size z size x y 0 + outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 1.100000 -z 0.100000" "0.100000" # size z size x y 0 + outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 1.100000 -z 0.100000" "0.100000" # size z size x y 0 + outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 2.100000 -z -1.400000" "0.100000" # size z size x y 0 + outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 2.100000 -z -1.400000" "0.100000" # size z size x y 0 + outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 1.100000 -z -1.400000" "0.100000" # size z size x y 0 + outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 1.100000 -z -1.400000" "0.100000" # size z size x y 0 + outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.900000 -z -0.100000" "0.100000" # size z size x y 0 + inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.900000 -z -0.100000" "0.100000" # size z size x y 0 + inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.900000 -z -0.100000" "0.100000" # size z size x y 0 + inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.900000 -z -0.100000" "0.100000" # size z size x y 0 + inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.900000 -z -1.600000" "0.100000" # size z size x y 0 + inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.900000 -z -1.600000" "0.100000" # size z size x y 0 + inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.900000 -z -1.600000" "0.100000" # size z size x y 0 + inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.900000 -z -1.600000" "0.100000" # size z size x y 0 + inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 2.100000 -z -0.200000" "0.223607" # size z size x y 0 + outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 2.100000 -z -0.200000" "0.223607" # size z size x y 0 + outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 1.100000 -z -0.200000" "0.223607" # size z size x y 0 + outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 1.100000 -z -0.200000" "0.223607" # size z size x y 0 + outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 2.100000 -z -1.700000" "0.223607" # size z size x y 0 + outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 2.100000 -z -1.700000" "0.223607" # size z size x y 0 + outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 1.100000 -z -1.700000" "0.223607" # size z size x y 0 + outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 1.100000 -z -1.700000" "0.223607" # size z size x y 0 + outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.900000 -z 2.800000" "-0.100000" # size z size x y 0 + inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.900000 -z 2.800000" "-0.100000" # size z size x y 0 + inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.900000 -z 2.800000" "-0.100000" # size z size x y 0 + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.900000 -z 2.800000" "-0.100000" # size z size x y 0 + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.900000 -z 1.300000" "-0.100000" # size z size x y 0 + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.900000 -z 1.300000" "-0.100000" # size z size x y 0 + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.900000 -z 1.300000" "-0.100000" # size z size x y 0 + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.900000 -z 1.300000" "-0.100000" # size z size x y 0 + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.800000 -z 2.900000" "-0.100000" # size z size x y 0 + inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.800000 -z 2.900000" "-0.100000" # size z size x y 0 + inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.800000 -z 2.900000" "-0.100000" # size z size x y 0 + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.800000 -z 2.900000" "-0.100000" # size z size x y 0 + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.800000 -z 1.400000" "-0.100000" # size z size x y 0 + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.800000 -z 1.400000" "-0.100000" # size z size x y 0 + inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.800000 -z 1.400000" "-0.100000" # size z size x y 0 + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.800000 -z 1.400000" "-0.100000" # size z size x y 0 + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 2.100000 -z 2.900000" "0.100000" # size z size x y 0 + outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 2.100000 -z 2.900000" "0.100000" # size z size x y 0 + outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 1.100000 -z 2.900000" "0.100000" # size z size x y 0 + outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 1.100000 -z 2.900000" "0.100000" # size z size x y 0 + outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 2.100000 -z 1.400000" "0.100000" # size z size x y 0 + outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 2.100000 -z 1.400000" "0.100000" # size z size x y 0 + outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 1.100000 -z 1.400000" "0.100000" # size z size x y 0 + outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 1.100000 -z 1.400000" "0.100000" # size z size x y 0 + outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 1.900000 -z 3.100000" "0.100000" # size z size x y 0 + inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 1.900000 -z 3.100000" "0.100000" # size z size x y 0 + inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 0.900000 -z 3.100000" "0.100000" # size z size x y 0 + inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 0.900000 -z 3.100000" "0.100000" # size z size x y 0 + inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 1.900000 -z 1.600000" "0.100000" # size z size x y 0 + inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 1.900000 -z 1.600000" "0.100000" # size z size x y 0 + inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 0.900000 -z 1.600000" "0.100000" # size z size x y 0 + inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 0.900000 -z 1.600000" "0.100000" # size z size x y 0 + inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.000000 -y 2.100000 -z 3.200000" "0.223607" # size z size x y 0 + outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.000000 -y 2.100000 -z 3.200000" "0.223607" # size z size x y 0 + outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -y 1.100000 -z 3.200000" "0.223607" # size z size x y 0 + outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -y 1.100000 -z 3.200000" "0.223607" # size z size x y 0 + outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.000000 -y 2.100000 -z 1.700000" "0.223607" # size z size x y 0 + outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.000000 -y 2.100000 -z 1.700000" "0.223607" # size z size x y 0 + outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -y 1.100000 -z 1.700000" "0.223607" # size z size x y 0 + outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -y 1.100000 -z 1.700000" "0.223607" # size z size x y 0 + outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.100000 -y 1.000000 -z 1.500000" "-0.100000" # size z size x y - 0 inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.100000 -y 1.000000 -z 1.500000" "-0.100000" # size z size x y - 0 inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.900000 -z 1.500000" "-0.100000" # size z size x y - 0 inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.900000 -z 1.500000" "-0.100000" # size z size x y - 0 inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.100000 -y 1.000000" "-0.100000" # size z size x y - 0 inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.100000 -y 1.000000" "-0.100000" # size z size x y - 0 inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.900000" "-0.100000" # size z size x y - 0 inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.900000" "-0.100000" # size z size x y - 0 inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x -0.100000 -y 1.000000 -z 1.500000" "0.100000" # size z size x y - 0 outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x -0.100000 -y 1.000000 -z 1.500000" "0.100000" # size z size x y - 0 outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -1.100000 -z 1.500000" "0.100000" # size z size x y - 0 outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -1.100000 -z 1.500000" "0.100000" # size z size x y - 0 outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x -0.100000 -y 1.000000" "0.100000" # size z size x y - 0 outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x -0.100000 -y 1.000000" "0.100000" # size z size x y - 0 outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -1.100000" "0.100000" # size z size x y - 0 outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -1.100000" "0.100000" # size z size x y - 0 outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.100000 -y 1.000000 -z 0.200000" "-0.100000" # size z size x y - 0 inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.100000 -y 1.000000 -z 0.200000" "-0.100000" # size z size x y - 0 inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.900000 -z 0.200000" "-0.100000" # size z size x y - 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.900000 -z 0.200000" "-0.100000" # size z size x y - 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.100000 -y 1.000000 -z -1.300000" "-0.100000" # size z size x y - 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.100000 -y 1.000000 -z -1.300000" "-0.100000" # size z size x y - 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.900000 -z -1.300000" "-0.100000" # size z size x y - 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.900000 -z -1.300000" "-0.100000" # size z size x y - 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.200000 -y 1.000000 -z 0.100000" "-0.100000" # size z size x y - 0 inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.200000 -y 1.000000 -z 0.100000" "-0.100000" # size z size x y - 0 inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.800000 -z 0.100000" "-0.100000" # size z size x y - 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.800000 -z 0.100000" "-0.100000" # size z size x y - 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.200000 -y 1.000000 -z -1.400000" "-0.100000" # size z size x y - 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.200000 -y 1.000000 -z -1.400000" "-0.100000" # size z size x y - 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.800000 -z -1.400000" "-0.100000" # size z size x y - 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.800000 -z -1.400000" "-0.100000" # size z size x y - 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x -0.100000 -y 1.000000 -z 0.100000" "0.100000" # size z size x y - 0 outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x -0.100000 -y 1.000000 -z 0.100000" "0.100000" # size z size x y - 0 outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -1.100000 -z 0.100000" "0.100000" # size z size x y - 0 outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -1.100000 -z 0.100000" "0.100000" # size z size x y - 0 outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x -0.100000 -y 1.000000 -z -1.400000" "0.100000" # size z size x y - 0 outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x -0.100000 -y 1.000000 -z -1.400000" "0.100000" # size z size x y - 0 outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -1.100000 -z -1.400000" "0.100000" # size z size x y - 0 outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -1.100000 -z -1.400000" "0.100000" # size z size x y - 0 outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.100000 -y 1.000000 -z -0.100000" "0.100000" # size z size x y - 0 inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.100000 -y 1.000000 -z -0.100000" "0.100000" # size z size x y - 0 inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.900000 -z -0.100000" "0.100000" # size z size x y - 0 inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.900000 -z -0.100000" "0.100000" # size z size x y - 0 inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.100000 -y 1.000000 -z -1.600000" "0.100000" # size z size x y - 0 inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.100000 -y 1.000000 -z -1.600000" "0.100000" # size z size x y - 0 inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.900000 -z -1.600000" "0.100000" # size z size x y - 0 inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.900000 -z -1.600000" "0.100000" # size z size x y - 0 inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x -0.100000 -y 1.000000 -z -0.200000" "0.223607" # size z size x y - 0 outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x -0.100000 -y 1.000000 -z -0.200000" "0.223607" # size z size x y - 0 outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -1.100000 -z -0.200000" "0.223607" # size z size x y - 0 outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -1.100000 -z -0.200000" "0.223607" # size z size x y - 0 outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x -0.100000 -y 1.000000 -z -1.700000" "0.223607" # size z size x y - 0 outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x -0.100000 -y 1.000000 -z -1.700000" "0.223607" # size z size x y - 0 outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -1.100000 -z -1.700000" "0.223607" # size z size x y - 0 outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -1.100000 -z -1.700000" "0.223607" # size z size x y - 0 outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.100000 -y 1.000000 -z 2.800000" "-0.100000" # size z size x y - 0 inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.100000 -y 1.000000 -z 2.800000" "-0.100000" # size z size x y - 0 inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.900000 -z 2.800000" "-0.100000" # size z size x y - 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.900000 -z 2.800000" "-0.100000" # size z size x y - 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.100000 -y 1.000000 -z 1.300000" "-0.100000" # size z size x y - 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.100000 -y 1.000000 -z 1.300000" "-0.100000" # size z size x y - 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.900000 -z 1.300000" "-0.100000" # size z size x y - 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.900000 -z 1.300000" "-0.100000" # size z size x y - 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.200000 -y 1.000000 -z 2.900000" "-0.100000" # size z size x y - 0 inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.200000 -y 1.000000 -z 2.900000" "-0.100000" # size z size x y - 0 inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.800000 -z 2.900000" "-0.100000" # size z size x y - 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.800000 -z 2.900000" "-0.100000" # size z size x y - 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.200000 -y 1.000000 -z 1.400000" "-0.100000" # size z size x y - 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.200000 -y 1.000000 -z 1.400000" "-0.100000" # size z size x y - 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.800000 -z 1.400000" "-0.100000" # size z size x y - 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.800000 -z 1.400000" "-0.100000" # size z size x y - 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x -0.100000 -y 1.000000 -z 2.900000" "0.100000" # size z size x y - 0 outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x -0.100000 -y 1.000000 -z 2.900000" "0.100000" # size z size x y - 0 outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -1.100000 -z 2.900000" "0.100000" # size z size x y - 0 outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -1.100000 -z 2.900000" "0.100000" # size z size x y - 0 outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x -0.100000 -y 1.000000 -z 1.400000" "0.100000" # size z size x y - 0 outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x -0.100000 -y 1.000000 -z 1.400000" "0.100000" # size z size x y - 0 outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -1.100000 -z 1.400000" "0.100000" # size z size x y - 0 outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -1.100000 -z 1.400000" "0.100000" # size z size x y - 0 outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.100000 -y 1.000000 -z 3.100000" "0.100000" # size z size x y - 0 inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.100000 -y 1.000000 -z 3.100000" "0.100000" # size z size x y - 0 inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.900000 -z 3.100000" "0.100000" # size z size x y - 0 inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.900000 -z 3.100000" "0.100000" # size z size x y - 0 inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.100000 -y 1.000000 -z 1.600000" "0.100000" # size z size x y - 0 inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.100000 -y 1.000000 -z 1.600000" "0.100000" # size z size x y - 0 inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.900000 -z 1.600000" "0.100000" # size z size x y - 0 inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.900000 -z 1.600000" "0.100000" # size z size x y - 0 inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x -0.100000 -y 1.000000 -z 3.200000" "0.223607" # size z size x y - 0 outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x -0.100000 -y 1.000000 -z 3.200000" "0.223607" # size z size x y - 0 outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -1.100000 -z 3.200000" "0.223607" # size z size x y - 0 outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -1.100000 -z 3.200000" "0.223607" # size z size x y - 0 outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x -0.100000 -y 1.000000 -z 1.700000" "0.223607" # size z size x y - 0 outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x -0.100000 -y 1.000000 -z 1.700000" "0.223607" # size z size x y - 0 outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -1.100000 -z 1.700000" "0.223607" # size z size x y - 0 outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -1.100000 -z 1.700000" "0.223607" # size z size x y - 0 outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.900000 -y 1.000000 -z 1.500000" "-0.100000" # size z size x y + 0 inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.900000 -y 1.000000 -z 1.500000" "-0.100000" # size z size x y + 0 inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.900000 -z 1.500000" "-0.100000" # size z size x y + 0 inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.900000 -z 1.500000" "-0.100000" # size z size x y + 0 inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.900000 -y 1.000000" "-0.100000" # size z size x y + 0 inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.900000 -y 1.000000" "-0.100000" # size z size x y + 0 inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.900000" "-0.100000" # size z size x y + 0 inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.900000" "-0.100000" # size z size x y + 0 inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 2.100000 -y 1.000000 -z 1.500000" "0.100000" # size z size x y + 0 outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 2.100000 -y 1.000000 -z 1.500000" "0.100000" # size z size x y + 0 outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 1.100000 -z 1.500000" "0.100000" # size z size x y + 0 outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 1.100000 -z 1.500000" "0.100000" # size z size x y + 0 outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 2.100000 -y 1.000000" "0.100000" # size z size x y + 0 outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 2.100000 -y 1.000000" "0.100000" # size z size x y + 0 outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 1.100000" "0.100000" # size z size x y + 0 outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 1.100000" "0.100000" # size z size x y + 0 outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.900000 -y 1.000000 -z 0.200000" "-0.100000" # size z size x y + 0 inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.900000 -y 1.000000 -z 0.200000" "-0.100000" # size z size x y + 0 inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.900000 -z 0.200000" "-0.100000" # size z size x y + 0 inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.900000 -z 0.200000" "-0.100000" # size z size x y + 0 inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.900000 -y 1.000000 -z -1.300000" "-0.100000" # size z size x y + 0 inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.900000 -y 1.000000 -z -1.300000" "-0.100000" # size z size x y + 0 inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.900000 -z -1.300000" "-0.100000" # size z size x y + 0 inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.900000 -z -1.300000" "-0.100000" # size z size x y + 0 inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.800000 -y 1.000000 -z 0.100000" "-0.100000" # size z size x y + 0 inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.800000 -y 1.000000 -z 0.100000" "-0.100000" # size z size x y + 0 inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.800000 -z 0.100000" "-0.100000" # size z size x y + 0 inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.800000 -z 0.100000" "-0.100000" # size z size x y + 0 inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.800000 -y 1.000000 -z -1.400000" "-0.100000" # size z size x y + 0 inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.800000 -y 1.000000 -z -1.400000" "-0.100000" # size z size x y + 0 inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.800000 -z -1.400000" "-0.100000" # size z size x y + 0 inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.800000 -z -1.400000" "-0.100000" # size z size x y + 0 inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 2.100000 -y 1.000000 -z 0.100000" "0.100000" # size z size x y + 0 outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 2.100000 -y 1.000000 -z 0.100000" "0.100000" # size z size x y + 0 outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 1.100000 -z 0.100000" "0.100000" # size z size x y + 0 outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 1.100000 -z 0.100000" "0.100000" # size z size x y + 0 outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 2.100000 -y 1.000000 -z -1.400000" "0.100000" # size z size x y + 0 outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 2.100000 -y 1.000000 -z -1.400000" "0.100000" # size z size x y + 0 outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 1.100000 -z -1.400000" "0.100000" # size z size x y + 0 outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 1.100000 -z -1.400000" "0.100000" # size z size x y + 0 outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.900000 -y 1.000000 -z -0.100000" "0.100000" # size z size x y + 0 inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.900000 -y 1.000000 -z -0.100000" "0.100000" # size z size x y + 0 inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.900000 -z -0.100000" "0.100000" # size z size x y + 0 inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.900000 -z -0.100000" "0.100000" # size z size x y + 0 inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.900000 -y 1.000000 -z -1.600000" "0.100000" # size z size x y + 0 inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.900000 -y 1.000000 -z -1.600000" "0.100000" # size z size x y + 0 inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.900000 -z -1.600000" "0.100000" # size z size x y + 0 inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.900000 -z -1.600000" "0.100000" # size z size x y + 0 inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 2.100000 -y 1.000000 -z -0.200000" "0.223607" # size z size x y + 0 outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 2.100000 -y 1.000000 -z -0.200000" "0.223607" # size z size x y + 0 outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 1.100000 -z -0.200000" "0.223607" # size z size x y + 0 outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 1.100000 -z -0.200000" "0.223607" # size z size x y + 0 outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 2.100000 -y 1.000000 -z -1.700000" "0.223607" # size z size x y + 0 outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 2.100000 -y 1.000000 -z -1.700000" "0.223607" # size z size x y + 0 outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 1.100000 -z -1.700000" "0.223607" # size z size x y + 0 outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 1.100000 -z -1.700000" "0.223607" # size z size x y + 0 outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.900000 -y 1.000000 -z 2.800000" "-0.100000" # size z size x y + 0 inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.900000 -y 1.000000 -z 2.800000" "-0.100000" # size z size x y + 0 inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.900000 -z 2.800000" "-0.100000" # size z size x y + 0 inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.900000 -z 2.800000" "-0.100000" # size z size x y + 0 inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.900000 -y 1.000000 -z 1.300000" "-0.100000" # size z size x y + 0 inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.900000 -y 1.000000 -z 1.300000" "-0.100000" # size z size x y + 0 inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.900000 -z 1.300000" "-0.100000" # size z size x y + 0 inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.900000 -z 1.300000" "-0.100000" # size z size x y + 0 inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.800000 -y 1.000000 -z 2.900000" "-0.100000" # size z size x y + 0 inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.800000 -y 1.000000 -z 2.900000" "-0.100000" # size z size x y + 0 inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.800000 -z 2.900000" "-0.100000" # size z size x y + 0 inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.800000 -z 2.900000" "-0.100000" # size z size x y + 0 inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.800000 -y 1.000000 -z 1.400000" "-0.100000" # size z size x y + 0 inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.800000 -y 1.000000 -z 1.400000" "-0.100000" # size z size x y + 0 inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.800000 -z 1.400000" "-0.100000" # size z size x y + 0 inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.800000 -z 1.400000" "-0.100000" # size z size x y + 0 inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 2.100000 -y 1.000000 -z 2.900000" "0.100000" # size z size x y + 0 outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 2.100000 -y 1.000000 -z 2.900000" "0.100000" # size z size x y + 0 outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 1.100000 -z 2.900000" "0.100000" # size z size x y + 0 outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 1.100000 -z 2.900000" "0.100000" # size z size x y + 0 outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 2.100000 -y 1.000000 -z 1.400000" "0.100000" # size z size x y + 0 outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 2.100000 -y 1.000000 -z 1.400000" "0.100000" # size z size x y + 0 outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 1.100000 -z 1.400000" "0.100000" # size z size x y + 0 outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 1.100000 -z 1.400000" "0.100000" # size z size x y + 0 outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.900000 -y 1.000000 -z 3.100000" "0.100000" # size z size x y + 0 inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.900000 -y 1.000000 -z 3.100000" "0.100000" # size z size x y + 0 inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.900000 -z 3.100000" "0.100000" # size z size x y + 0 inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.900000 -z 3.100000" "0.100000" # size z size x y + 0 inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.900000 -y 1.000000 -z 1.600000" "0.100000" # size z size x y + 0 inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.900000 -y 1.000000 -z 1.600000" "0.100000" # size z size x y + 0 inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.900000 -z 1.600000" "0.100000" # size z size x y + 0 inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.900000 -z 1.600000" "0.100000" # size z size x y + 0 inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 2.100000 -y 1.000000 -z 3.200000" "0.223607" # size z size x y + 0 outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 2.100000 -y 1.000000 -z 3.200000" "0.223607" # size z size x y + 0 outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 1.100000 -z 3.200000" "0.223607" # size z size x y + 0 outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 1.100000 -z 3.200000" "0.223607" # size z size x y + 0 outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 2.100000 -y 1.000000 -z 1.700000" "0.223607" # size z size x y + 0 outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 2.100000 -y 1.000000 -z 1.700000" "0.223607" # size z size x y + 0 outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 1.100000 -z 1.700000" "0.223607" # size z size x y + 0 outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 1.100000 -z 1.700000" "0.223607" # size z size x y + 0 outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 0.513728 -z 1.500000" "-0.100000" # size z size x y - - inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 0.513728 -z 1.500000" "-0.100000" # size z size x y - - inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 1.500000" "-0.100000" # size z size x y - - inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 1.500000" "-0.100000" # size z size x y - - inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 0.513728" "-0.100000" # size z size x y - - inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 0.513728" "-0.100000" # size z size x y - - inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y -0.486272" "-0.100000" # size z size x y - - inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272" "-0.100000" # size z size x y - - inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 0.405667 -z 1.500000" "0.100000" # size z size x y - - outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 0.405667 -z 1.500000" "0.100000" # size z size x y - - outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 1.500000" "0.100000" # size z size x y - - outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 1.500000" "0.100000" # size z size x y - - outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 0.405667" "0.100000" # size z size x y - - outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 0.405667" "0.100000" # size z size x y - - outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y -0.594333" "0.100000" # size z size x y - - outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333" "0.100000" # size z size x y - - outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 0.513728 -z 0.200000" "-0.100000" # size z size x y - - inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 0.513728 -z 0.200000" "-0.100000" # size z size x y - - inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size z size x y - - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size z size x y - - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 0.513728 -z -1.300000" "-0.100000" # size z size x y - - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 0.513728 -z -1.300000" "-0.100000" # size z size x y - - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z -1.300000" "-0.100000" # size z size x y - - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z -1.300000" "-0.100000" # size z size x y - - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.326823 -y 0.567758 -z 0.100000" "-0.100000" # size z size x y - - inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.326823 -y 0.567758 -z 0.100000" "-0.100000" # size z size x y - - inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size z size x y - - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size z size x y - - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.326823 -y 0.567758 -z -1.400000" "-0.100000" # size z size x y - - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.326823 -y 0.567758 -z -1.400000" "-0.100000" # size z size x y - - inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.673177 -y -0.432242 -z -1.400000" "-0.100000" # size z size x y - - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.673177 -y -0.432242 -z -1.400000" "-0.100000" # size z size x y - - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 0.405667 -z 0.100000" "0.100000" # size z size x y - - outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 0.405667 -z 0.100000" "0.100000" # size z size x y - - outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 0.100000" "0.100000" # size z size x y - - outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 0.100000" "0.100000" # size z size x y - - outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 0.405667 -z -1.400000" "0.100000" # size z size x y - - outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 0.405667 -z -1.400000" "0.100000" # size z size x y - - outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z -1.400000" "0.100000" # size z size x y - - outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z -1.400000" "0.100000" # size z size x y - - outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 0.513728 -z -0.100000" "0.100000" # size z size x y - - inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 0.513728 -z -0.100000" "0.100000" # size z size x y - - inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y -0.486272 -z -0.100000" "0.100000" # size z size x y - - inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z -0.100000" "0.100000" # size z size x y - - inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 0.513728 -z -1.600000" "0.100000" # size z size x y - - inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 0.513728 -z -1.600000" "0.100000" # size z size x y - - inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z -1.600000" "0.100000" # size z size x y - - inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z -1.600000" "0.100000" # size z size x y - - inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 0.405667 -z -0.200000" "0.223607" # size z size x y - - outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 0.405667 -z -0.200000" "0.223607" # size z size x y - - outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y -0.594333 -z -0.200000" "0.223607" # size z size x y - - outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z -0.200000" "0.223607" # size z size x y - - outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 0.405667 -z -1.700000" "0.223607" # size z size x y - - outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 0.405667 -z -1.700000" "0.223607" # size z size x y - - outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z -1.700000" "0.223607" # size z size x y - - outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z -1.700000" "0.223607" # size z size x y - - outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 0.513728 -z 2.800000" "-0.100000" # size z size x y - - inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 0.513728 -z 2.800000" "-0.100000" # size z size x y - - inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 2.800000" "-0.100000" # size z size x y - - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 2.800000" "-0.100000" # size z size x y - - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 0.513728 -z 1.300000" "-0.100000" # size z size x y - - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 0.513728 -z 1.300000" "-0.100000" # size z size x y - - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z 1.300000" "-0.100000" # size z size x y - - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z 1.300000" "-0.100000" # size z size x y - - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.326823 -y 0.567758 -z 2.900000" "-0.100000" # size z size x y - - inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.326823 -y 0.567758 -z 2.900000" "-0.100000" # size z size x y - - inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.673177 -y -0.432242 -z 2.900000" "-0.100000" # size z size x y - - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.673177 -y -0.432242 -z 2.900000" "-0.100000" # size z size x y - - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.326823 -y 0.567758 -z 1.400000" "-0.100000" # size z size x y - - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.326823 -y 0.567758 -z 1.400000" "-0.100000" # size z size x y - - inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.673177 -y -0.432242 -z 1.400000" "-0.100000" # size z size x y - - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.673177 -y -0.432242 -z 1.400000" "-0.100000" # size z size x y - - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 0.405667 -z 2.900000" "0.100000" # size z size x y - - outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 0.405667 -z 2.900000" "0.100000" # size z size x y - - outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 2.900000" "0.100000" # size z size x y - - outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 2.900000" "0.100000" # size z size x y - - outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 0.405667 -z 1.400000" "0.100000" # size z size x y - - outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 0.405667 -z 1.400000" "0.100000" # size z size x y - - outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z 1.400000" "0.100000" # size z size x y - - outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z 1.400000" "0.100000" # size z size x y - - outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 0.513728 -z 3.100000" "0.100000" # size z size x y - - inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 0.513728 -z 3.100000" "0.100000" # size z size x y - - inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y -0.486272 -z 3.100000" "0.100000" # size z size x y - - inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y -0.486272 -z 3.100000" "0.100000" # size z size x y - - inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 0.513728 -z 1.600000" "0.100000" # size z size x y - - inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 0.513728 -z 1.600000" "0.100000" # size z size x y - - inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y -0.486272 -z 1.600000" "0.100000" # size z size x y - - inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y -0.486272 -z 1.600000" "0.100000" # size z size x y - - inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 0.405667 -z 3.200000" "0.223607" # size z size x y - - outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 0.405667 -z 3.200000" "0.223607" # size z size x y - - outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y -0.594333 -z 3.200000" "0.223607" # size z size x y - - outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y -0.594333 -z 3.200000" "0.223607" # size z size x y - - outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 0.405667 -z 1.700000" "0.223607" # size z size x y - - outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 0.405667 -z 1.700000" "0.223607" # size z size x y - - outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y -0.594333 -z 1.700000" "0.223607" # size z size x y - - outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y -0.594333 -z 1.700000" "0.223607" # size z size x y - - outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 1.486272 -z 1.500000" "-0.100000" # size z size x y - + inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 1.486272 -z 1.500000" "-0.100000" # size z size x y - + inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 1.500000" "-0.100000" # size z size x y - + inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 1.500000" "-0.100000" # size z size x y - + inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 1.486272" "-0.100000" # size z size x y - + inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 1.486272" "-0.100000" # size z size x y - + inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y 0.486272" "-0.100000" # size z size x y - + inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272" "-0.100000" # size z size x y - + inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 1.594333 -z 1.500000" "0.100000" # size z size x y - + outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 1.594333 -z 1.500000" "0.100000" # size z size x y - + outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 1.500000" "0.100000" # size z size x y - + outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 1.500000" "0.100000" # size z size x y - + outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 1.594333" "0.100000" # size z size x y - + outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 1.594333" "0.100000" # size z size x y - + outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y 0.594333" "0.100000" # size z size x y - + outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333" "0.100000" # size z size x y - + outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 1.486272 -z 0.200000" "-0.100000" # size z size x y - + inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 1.486272 -z 0.200000" "-0.100000" # size z size x y - + inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size z size x y - + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size z size x y - + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 1.486272 -z -1.300000" "-0.100000" # size z size x y - + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 1.486272 -z -1.300000" "-0.100000" # size z size x y - + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z -1.300000" "-0.100000" # size z size x y - + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z -1.300000" "-0.100000" # size z size x y - + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.326823 -y 1.432242 -z 0.100000" "-0.100000" # size z size x y - + inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.326823 -y 1.432242 -z 0.100000" "-0.100000" # size z size x y - + inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size z size x y - + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size z size x y - + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.326823 -y 1.432242 -z -1.400000" "-0.100000" # size z size x y - + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.326823 -y 1.432242 -z -1.400000" "-0.100000" # size z size x y - + inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.673177 -y 0.432242 -z -1.400000" "-0.100000" # size z size x y - + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.673177 -y 0.432242 -z -1.400000" "-0.100000" # size z size x y - + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 1.594333 -z 0.100000" "0.100000" # size z size x y - + outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 1.594333 -z 0.100000" "0.100000" # size z size x y - + outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 0.100000" "0.100000" # size z size x y - + outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 0.100000" "0.100000" # size z size x y - + outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 1.594333 -z -1.400000" "0.100000" # size z size x y - + outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 1.594333 -z -1.400000" "0.100000" # size z size x y - + outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z -1.400000" "0.100000" # size z size x y - + outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z -1.400000" "0.100000" # size z size x y - + outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 1.486272 -z -0.100000" "0.100000" # size z size x y - + inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 1.486272 -z -0.100000" "0.100000" # size z size x y - + inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y 0.486272 -z -0.100000" "0.100000" # size z size x y - + inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z -0.100000" "0.100000" # size z size x y - + inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 1.486272 -z -1.600000" "0.100000" # size z size x y - + inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 1.486272 -z -1.600000" "0.100000" # size z size x y - + inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z -1.600000" "0.100000" # size z size x y - + inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z -1.600000" "0.100000" # size z size x y - + inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 1.594333 -z -0.200000" "0.223607" # size z size x y - + outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 1.594333 -z -0.200000" "0.223607" # size z size x y - + outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y 0.594333 -z -0.200000" "0.223607" # size z size x y - + outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z -0.200000" "0.223607" # size z size x y - + outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 1.594333 -z -1.700000" "0.223607" # size z size x y - + outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 1.594333 -z -1.700000" "0.223607" # size z size x y - + outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z -1.700000" "0.223607" # size z size x y - + outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z -1.700000" "0.223607" # size z size x y - + outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 1.486272 -z 2.800000" "-0.100000" # size z size x y - + inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 1.486272 -z 2.800000" "-0.100000" # size z size x y - + inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 2.800000" "-0.100000" # size z size x y - + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 2.800000" "-0.100000" # size z size x y - + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 1.486272 -z 1.300000" "-0.100000" # size z size x y - + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 1.486272 -z 1.300000" "-0.100000" # size z size x y - + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z 1.300000" "-0.100000" # size z size x y - + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z 1.300000" "-0.100000" # size z size x y - + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.326823 -y 1.432242 -z 2.900000" "-0.100000" # size z size x y - + inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.326823 -y 1.432242 -z 2.900000" "-0.100000" # size z size x y - + inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.673177 -y 0.432242 -z 2.900000" "-0.100000" # size z size x y - + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.673177 -y 0.432242 -z 2.900000" "-0.100000" # size z size x y - + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.326823 -y 1.432242 -z 1.400000" "-0.100000" # size z size x y - + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.326823 -y 1.432242 -z 1.400000" "-0.100000" # size z size x y - + inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.673177 -y 0.432242 -z 1.400000" "-0.100000" # size z size x y - + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.673177 -y 0.432242 -z 1.400000" "-0.100000" # size z size x y - + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 1.594333 -z 2.900000" "0.100000" # size z size x y - + outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 1.594333 -z 2.900000" "0.100000" # size z size x y - + outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 2.900000" "0.100000" # size z size x y - + outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 2.900000" "0.100000" # size z size x y - + outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 1.594333 -z 1.400000" "0.100000" # size z size x y - + outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 1.594333 -z 1.400000" "0.100000" # size z size x y - + outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z 1.400000" "0.100000" # size z size x y - + outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z 1.400000" "0.100000" # size z size x y - + outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.242676 -y 1.486272 -z 3.100000" "0.100000" # size z size x y - + inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.242676 -y 1.486272 -z 3.100000" "0.100000" # size z size x y - + inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.757324 -y 0.486272 -z 3.100000" "0.100000" # size z size x y - + inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.757324 -y 0.486272 -z 3.100000" "0.100000" # size z size x y - + inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.242676 -y 1.486272 -z 1.600000" "0.100000" # size z size x y - + inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.242676 -y 1.486272 -z 1.600000" "0.100000" # size z size x y - + inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.757324 -y 0.486272 -z 1.600000" "0.100000" # size z size x y - + inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.757324 -y 0.486272 -z 1.600000" "0.100000" # size z size x y - + inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 0.074382 -y 1.594333 -z 3.200000" "0.223607" # size z size x y - + outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 0.074382 -y 1.594333 -z 3.200000" "0.223607" # size z size x y - + outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x -0.925618 -y 0.594333 -z 3.200000" "0.223607" # size z size x y - + outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x -0.925618 -y 0.594333 -z 3.200000" "0.223607" # size z size x y - + outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 0.074382 -y 1.594333 -z 1.700000" "0.223607" # size z size x y - + outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 0.074382 -y 1.594333 -z 1.700000" "0.223607" # size z size x y - + outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x -0.925618 -y 0.594333 -z 1.700000" "0.223607" # size z size x y - + outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x -0.925618 -y 0.594333 -z 1.700000" "0.223607" # size z size x y - + outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 0.513728 -z 1.500000" "-0.100000" # size z size x y + - inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 0.513728 -z 1.500000" "-0.100000" # size z size x y + - inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 1.500000" "-0.100000" # size z size x y + - inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 1.500000" "-0.100000" # size z size x y + - inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 0.513728" "-0.100000" # size z size x y + - inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 0.513728" "-0.100000" # size z size x y + - inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y -0.486272" "-0.100000" # size z size x y + - inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272" "-0.100000" # size z size x y + - inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 0.405667 -z 1.500000" "0.100000" # size z size x y + - outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 0.405667 -z 1.500000" "0.100000" # size z size x y + - outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 1.500000" "0.100000" # size z size x y + - outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 1.500000" "0.100000" # size z size x y + - outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 0.405667" "0.100000" # size z size x y + - outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 0.405667" "0.100000" # size z size x y + - outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y -0.594333" "0.100000" # size z size x y + - outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333" "0.100000" # size z size x y + - outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 0.513728 -z 0.200000" "-0.100000" # size z size x y + - inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 0.513728 -z 0.200000" "-0.100000" # size z size x y + - inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size z size x y + - inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 0.200000" "-0.100000" # size z size x y + - inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 0.513728 -z -1.300000" "-0.100000" # size z size x y + - inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 0.513728 -z -1.300000" "-0.100000" # size z size x y + - inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z -1.300000" "-0.100000" # size z size x y + - inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z -1.300000" "-0.100000" # size z size x y + - inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.673177 -y 0.567758 -z 0.100000" "-0.100000" # size z size x y + - inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.673177 -y 0.567758 -z 0.100000" "-0.100000" # size z size x y + - inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size z size x y + - inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.673177 -y -0.432242 -z 0.100000" "-0.100000" # size z size x y + - inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.673177 -y 0.567758 -z -1.400000" "-0.100000" # size z size x y + - inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.673177 -y 0.567758 -z -1.400000" "-0.100000" # size z size x y + - inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.673177 -y -0.432242 -z -1.400000" "-0.100000" # size z size x y + - inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.673177 -y -0.432242 -z -1.400000" "-0.100000" # size z size x y + - inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 0.405667 -z 0.100000" "0.100000" # size z size x y + - outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 0.405667 -z 0.100000" "0.100000" # size z size x y + - outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 0.100000" "0.100000" # size z size x y + - outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 0.100000" "0.100000" # size z size x y + - outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 0.405667 -z -1.400000" "0.100000" # size z size x y + - outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 0.405667 -z -1.400000" "0.100000" # size z size x y + - outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z -1.400000" "0.100000" # size z size x y + - outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z -1.400000" "0.100000" # size z size x y + - outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 0.513728 -z -0.100000" "0.100000" # size z size x y + - inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 0.513728 -z -0.100000" "0.100000" # size z size x y + - inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y -0.486272 -z -0.100000" "0.100000" # size z size x y + - inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z -0.100000" "0.100000" # size z size x y + - inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 0.513728 -z -1.600000" "0.100000" # size z size x y + - inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 0.513728 -z -1.600000" "0.100000" # size z size x y + - inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z -1.600000" "0.100000" # size z size x y + - inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z -1.600000" "0.100000" # size z size x y + - inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 0.405667 -z -0.200000" "0.223607" # size z size x y + - outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 0.405667 -z -0.200000" "0.223607" # size z size x y + - outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y -0.594333 -z -0.200000" "0.223607" # size z size x y + - outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z -0.200000" "0.223607" # size z size x y + - outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 0.405667 -z -1.700000" "0.223607" # size z size x y + - outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 0.405667 -z -1.700000" "0.223607" # size z size x y + - outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z -1.700000" "0.223607" # size z size x y + - outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z -1.700000" "0.223607" # size z size x y + - outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 0.513728 -z 2.800000" "-0.100000" # size z size x y + - inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 0.513728 -z 2.800000" "-0.100000" # size z size x y + - inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 2.800000" "-0.100000" # size z size x y + - inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 2.800000" "-0.100000" # size z size x y + - inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 0.513728 -z 1.300000" "-0.100000" # size z size x y + - inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 0.513728 -z 1.300000" "-0.100000" # size z size x y + - inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z 1.300000" "-0.100000" # size z size x y + - inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z 1.300000" "-0.100000" # size z size x y + - inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.673177 -y 0.567758 -z 2.900000" "-0.100000" # size z size x y + - inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.673177 -y 0.567758 -z 2.900000" "-0.100000" # size z size x y + - inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.673177 -y -0.432242 -z 2.900000" "-0.100000" # size z size x y + - inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.673177 -y -0.432242 -z 2.900000" "-0.100000" # size z size x y + - inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.673177 -y 0.567758 -z 1.400000" "-0.100000" # size z size x y + - inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.673177 -y 0.567758 -z 1.400000" "-0.100000" # size z size x y + - inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.673177 -y -0.432242 -z 1.400000" "-0.100000" # size z size x y + - inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.673177 -y -0.432242 -z 1.400000" "-0.100000" # size z size x y + - inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 0.405667 -z 2.900000" "0.100000" # size z size x y + - outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 0.405667 -z 2.900000" "0.100000" # size z size x y + - outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 2.900000" "0.100000" # size z size x y + - outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 2.900000" "0.100000" # size z size x y + - outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 0.405667 -z 1.400000" "0.100000" # size z size x y + - outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 0.405667 -z 1.400000" "0.100000" # size z size x y + - outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z 1.400000" "0.100000" # size z size x y + - outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z 1.400000" "0.100000" # size z size x y + - outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 0.513728 -z 3.100000" "0.100000" # size z size x y + - inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 0.513728 -z 3.100000" "0.100000" # size z size x y + - inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y -0.486272 -z 3.100000" "0.100000" # size z size x y + - inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y -0.486272 -z 3.100000" "0.100000" # size z size x y + - inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 0.513728 -z 1.600000" "0.100000" # size z size x y + - inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 0.513728 -z 1.600000" "0.100000" # size z size x y + - inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y -0.486272 -z 1.600000" "0.100000" # size z size x y + - inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y -0.486272 -z 1.600000" "0.100000" # size z size x y + - inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 0.405667 -z 3.200000" "0.223607" # size z size x y + - outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 0.405667 -z 3.200000" "0.223607" # size z size x y + - outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y -0.594333 -z 3.200000" "0.223607" # size z size x y + - outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y -0.594333 -z 3.200000" "0.223607" # size z size x y + - outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 0.405667 -z 1.700000" "0.223607" # size z size x y + - outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 0.405667 -z 1.700000" "0.223607" # size z size x y + - outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y -0.594333 -z 1.700000" "0.223607" # size z size x y + - outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y -0.594333 -z 1.700000" "0.223607" # size z size x y + - outside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 1.486272 -z 1.500000" "-0.100000" # size z size x y + + inside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 1.486272 -z 1.500000" "-0.100000" # size z size x y + + inside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 1.500000" "-0.100000" # size z size x y + + inside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 1.500000" "-0.100000" # size z size x y + + inside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 1.486272" "-0.100000" # size z size x y + + inside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 1.486272" "-0.100000" # size z size x y + + inside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y 0.486272" "-0.100000" # size z size x y + + inside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272" "-0.100000" # size z size x y + + inside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 1.594333 -z 1.500000" "0.100000" # size z size x y + + outside 0 short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 1.594333 -z 1.500000" "0.100000" # size z size x y + + outside 0 long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 1.500000" "0.100000" # size z size x y + + outside 0 center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 1.500000" "0.100000" # size z size x y + + outside 0 center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 1.594333" "0.100000" # size z size x y + + outside 0 center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 1.594333" "0.100000" # size z size x y + + outside 0 center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y 0.594333" "0.100000" # size z size x y + + outside 0 center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333" "0.100000" # size z size x y + + outside 0 center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 1.486272 -z 0.200000" "-0.100000" # size z size x y + + inside - inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 1.486272 -z 0.200000" "-0.100000" # size z size x y + + inside - inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size z size x y + + inside - inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 0.200000" "-0.100000" # size z size x y + + inside - inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 1.486272 -z -1.300000" "-0.100000" # size z size x y + + inside - inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 1.486272 -z -1.300000" "-0.100000" # size z size x y + + inside - inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z -1.300000" "-0.100000" # size z size x y + + inside - inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z -1.300000" "-0.100000" # size z size x y + + inside - inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.673177 -y 1.432242 -z 0.100000" "-0.100000" # size z size x y + + inside - inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.673177 -y 1.432242 -z 0.100000" "-0.100000" # size z size x y + + inside - inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size z size x y + + inside - inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.673177 -y 0.432242 -z 0.100000" "-0.100000" # size z size x y + + inside - inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.673177 -y 1.432242 -z -1.400000" "-0.100000" # size z size x y + + inside - inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.673177 -y 1.432242 -z -1.400000" "-0.100000" # size z size x y + + inside - inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.673177 -y 0.432242 -z -1.400000" "-0.100000" # size z size x y + + inside - inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.673177 -y 0.432242 -z -1.400000" "-0.100000" # size z size x y + + inside - inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 1.594333 -z 0.100000" "0.100000" # size z size x y + + outside - inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 1.594333 -z 0.100000" "0.100000" # size z size x y + + outside - inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 0.100000" "0.100000" # size z size x y + + outside - inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 0.100000" "0.100000" # size z size x y + + outside - inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 1.594333 -z -1.400000" "0.100000" # size z size x y + + outside - inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 1.594333 -z -1.400000" "0.100000" # size z size x y + + outside - inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z -1.400000" "0.100000" # size z size x y + + outside - inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z -1.400000" "0.100000" # size z size x y + + outside - inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 1.486272 -z -0.100000" "0.100000" # size z size x y + + inside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 1.486272 -z -0.100000" "0.100000" # size z size x y + + inside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y 0.486272 -z -0.100000" "0.100000" # size z size x y + + inside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z -0.100000" "0.100000" # size z size x y + + inside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 1.486272 -z -1.600000" "0.100000" # size z size x y + + inside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 1.486272 -z -1.600000" "0.100000" # size z size x y + + inside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z -1.600000" "0.100000" # size z size x y + + inside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z -1.600000" "0.100000" # size z size x y + + inside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 1.594333 -z -0.200000" "0.223607" # size z size x y + + outside - outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 1.594333 -z -0.200000" "0.223607" # size z size x y + + outside - outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y 0.594333 -z -0.200000" "0.223607" # size z size x y + + outside - outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z -0.200000" "0.223607" # size z size x y + + outside - outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 1.594333 -z -1.700000" "0.223607" # size z size x y + + outside - outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 1.594333 -z -1.700000" "0.223607" # size z size x y + + outside - outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z -1.700000" "0.223607" # size z size x y + + outside - outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z -1.700000" "0.223607" # size z size x y + + outside - outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 1.486272 -z 2.800000" "-0.100000" # size z size x y + + inside + inside closer to xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 1.486272 -z 2.800000" "-0.100000" # size z size x y + + inside + inside closer to xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 2.800000" "-0.100000" # size z size x y + + inside + inside closer to xy center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 2.800000" "-0.100000" # size z size x y + + inside + inside closer to xy center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 1.486272 -z 1.300000" "-0.100000" # size z size x y + + inside + inside closer to xy center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 1.486272 -z 1.300000" "-0.100000" # size z size x y + + inside + inside closer to xy center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z 1.300000" "-0.100000" # size z size x y + + inside + inside closer to xy center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z 1.300000" "-0.100000" # size z size x y + + inside + inside closer to xy center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.673177 -y 1.432242 -z 2.900000" "-0.100000" # size z size x y + + inside + inside closer to z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.673177 -y 1.432242 -z 2.900000" "-0.100000" # size z size x y + + inside + inside closer to z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.673177 -y 0.432242 -z 2.900000" "-0.100000" # size z size x y + + inside + inside closer to z center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.673177 -y 0.432242 -z 2.900000" "-0.100000" # size z size x y + + inside + inside closer to z center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.673177 -y 1.432242 -z 1.400000" "-0.100000" # size z size x y + + inside + inside closer to z center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.673177 -y 1.432242 -z 1.400000" "-0.100000" # size z size x y + + inside + inside closer to z center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.673177 -y 0.432242 -z 1.400000" "-0.100000" # size z size x y + + inside + inside closer to z center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.673177 -y 0.432242 -z 1.400000" "-0.100000" # size z size x y + + inside + inside closer to z center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 1.594333 -z 2.900000" "0.100000" # size z size x y + + outside + inside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 1.594333 -z 2.900000" "0.100000" # size z size x y + + outside + inside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 2.900000" "0.100000" # size z size x y + + outside + inside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 2.900000" "0.100000" # size z size x y + + outside + inside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 1.594333 -z 1.400000" "0.100000" # size z size x y + + outside + inside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 1.594333 -z 1.400000" "0.100000" # size z size x y + + outside + inside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z 1.400000" "0.100000" # size z size x y + + outside + inside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z 1.400000" "0.100000" # size z size x y + + outside + inside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.757324 -y 1.486272 -z 3.100000" "0.100000" # size z size x y + + inside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.757324 -y 1.486272 -z 3.100000" "0.100000" # size z size x y + + inside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.757324 -y 0.486272 -z 3.100000" "0.100000" # size z size x y + + inside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.757324 -y 0.486272 -z 3.100000" "0.100000" # size z size x y + + inside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.757324 -y 1.486272 -z 1.600000" "0.100000" # size z size x y + + inside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.757324 -y 1.486272 -z 1.600000" "0.100000" # size z size x y + + inside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.757324 -y 0.486272 -z 1.600000" "0.100000" # size z size x y + + inside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.757324 -y 0.486272 -z 1.600000" "0.100000" # size z size x y + + inside + outside center xyz long
  check_successful "bin/cylinder -sxy 2 -sz 3 | bin/sample -x 1.925618 -y 1.594333 -z 3.200000" "0.223607" # size z size x y + + outside + outside short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 | bin/sample -x 1.925618 -y 1.594333 -z 3.200000" "0.223607" # size z size x y + + outside + outside long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy | bin/sample -x 0.925618 -y 0.594333 -z 3.200000" "0.223607" # size z size x y + + outside + outside center xy short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy | bin/sample -x 0.925618 -y 0.594333 -z 3.200000" "0.223607" # size z size x y + + outside + outside center xy long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cz | bin/sample -x 1.925618 -y 1.594333 -z 1.700000" "0.223607" # size z size x y + + outside + outside center z short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-z | bin/sample -x 1.925618 -y 1.594333 -z 1.700000" "0.223607" # size z size x y + + outside + outside center z long
  check_successful "bin/cylinder -sxy 2 -sz 3 -cxy -cz | bin/sample -x 0.925618 -y 0.594333 -z 1.700000" "0.223607" # size z size x y + + outside + outside center xyz short
  check_successful "bin/cylinder --size-xy 2 --size-z 3 --center-xy --center-z | bin/sample -x 0.925618 -y 0.594333 -z 1.700000" "0.223607" # size z size x y + + outside + outside center xyz long
}
