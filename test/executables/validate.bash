load "../framework/main"

executable_name=validate
executable_help="validate - ensures that a sdf stream is valid before passing it on
  usage: [sdf stream] | validate [options] | [consumer of sdf stream]
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

@test "empty" {
  check_successful "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/empty.sdf" ""
}

@test "valid" {
  check_successful "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/valid.sdf" `cat test/sdf/valid.sdf`
}

@test "truncated opcode" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/truncated_opcode.sdf" "unexpected eof reading opcode"
}

@test "unary argument a missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "unary argument a truncated" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "unary argument a constant missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated a" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated b" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated c" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "binary argument a missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "binary argument a truncated" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "binary argument a constant missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated a" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated b" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated c" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "binary argument b missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_missing.sdf" "unexpected eof reading argument b"
}

@test "binary argument b truncated" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_truncated.sdf" "unexpected eof reading argument b"
}

@test "binary argument b constant missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated a" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated b" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated c" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "ternary argument a truncated" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "ternary argument a constant missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated a" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated b" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated c" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_missing.sdf" "unexpected eof reading argument b"
}

@test "ternary argument b truncated" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_truncated.sdf" "unexpected eof reading argument b"
}

@test "ternary argument b constant missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated a" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated b" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated c" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_missing.sdf" "unexpected eof reading argument c"
}

@test "ternary argument c truncated" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_truncated.sdf" "unexpected eof reading argument c"
}

@test "ternary argument c constant missing" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated a" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated b" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated c" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_constant_truncated_c.sdf" "unexpected eof reading number constant"
}
