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

@test "unary argument a boolean result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_boolean_result_of_instruction_being_defined.sdf" "argument a references the result of a future instruction"
}

@test "unary argument a boolean result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_boolean_result_of_future_instruction.sdf" "argument a references the result of a future instruction"
}

@test "unary argument a number result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_number_result_of_instruction_being_defined.sdf" "argument a references the result of a future instruction"
}

@test "unary argument a number result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_number_result_of_future_instruction.sdf" "argument a references the result of a future instruction"
}

@test "binary argument a boolean result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_boolean_result_of_instruction_being_defined.sdf" "argument a references the result of a future instruction"
}

@test "binary argument a boolean result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_boolean_result_of_future_instruction.sdf" "argument a references the result of a future instruction"
}

@test "binary argument a number result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_number_result_of_instruction_being_defined.sdf" "argument a references the result of a future instruction"
}

@test "binary argument a number result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_number_result_of_future_instruction.sdf" "argument a references the result of a future instruction"
}

@test "binary argument b boolean result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_boolean_result_of_instruction_being_defined.sdf" "argument b references the result of a future instruction"
}

@test "binary argument b boolean result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_boolean_result_of_future_instruction.sdf" "argument b references the result of a future instruction"
}

@test "binary argument b number result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_number_result_of_instruction_being_defined.sdf" "argument b references the result of a future instruction"
}

@test "binary argument b number result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_number_result_of_future_instruction.sdf" "argument b references the result of a future instruction"
}

@test "ternary argument a boolean result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_boolean_result_of_instruction_being_defined.sdf" "argument a references the result of a future instruction"
}

@test "ternary argument a boolean result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_boolean_result_of_future_instruction.sdf" "argument a references the result of a future instruction"
}

@test "ternary argument a number result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_number_result_of_instruction_being_defined.sdf" "argument a references the result of a future instruction"
}

@test "ternary argument a number result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_number_result_of_future_instruction.sdf" "argument a references the result of a future instruction"
}

@test "ternary argument b boolean result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_boolean_result_of_instruction_being_defined.sdf" "argument b references the result of a future instruction"
}

@test "ternary argument b boolean result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_boolean_result_of_future_instruction.sdf" "argument b references the result of a future instruction"
}

@test "ternary argument b number result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_number_result_of_instruction_being_defined.sdf" "argument b references the result of a future instruction"
}

@test "ternary argument b number result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_number_result_of_future_instruction.sdf" "argument b references the result of a future instruction"
}

@test "ternary argument c boolean result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_boolean_result_of_instruction_being_defined.sdf" "argument c references the result of a future instruction"
}

@test "ternary argument c boolean result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_boolean_result_of_future_instruction.sdf" "argument c references the result of a future instruction"
}

@test "ternary argument c number result of instruction being defined" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_number_result_of_instruction_being_defined.sdf" "argument c references the result of a future instruction"
}

@test "ternary argument c number result of future instruction" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_number_result_of_future_instruction.sdf" "argument c references the result of a future instruction"
}

@test "unary argument a boolean number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_boolean_number.sdf" "argument a expects boolean, given number"
}

@test "unary argument a boolean referenced number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_boolean_referenced_number.sdf" "argument a expects boolean, given number"
}

@test "unary argument a number false" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_number_false.sdf" "argument a expects number, given boolean"
}

@test "unary argument a number true" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_number_true.sdf" "argument a expects number, given boolean"
}

@test "unary argument a number referenced boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_number_referenced_boolean.sdf" "argument a expects number, given boolean"
}

@test "binary argument a boolean number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_boolean_number.sdf" "argument a expects boolean, given number"
}

@test "binary argument a boolean referenced number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_boolean_referenced_number.sdf" "argument a expects boolean, given number"
}

@test "binary argument a number false" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_number_false.sdf" "argument a expects number, given boolean"
}

@test "binary argument a number true" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_number_true.sdf" "argument a expects number, given boolean"
}

@test "binary argument a number referenced boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_number_referenced_boolean.sdf" "argument a expects number, given boolean"
}

@test "binary argument b boolean number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_boolean_number.sdf" "argument b expects boolean, given number"
}

@test "binary argument b boolean referenced number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_boolean_referenced_number.sdf" "argument b expects boolean, given number"
}

@test "binary argument b number false" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_number_false.sdf" "argument b expects number, given boolean"
}

@test "binary argument b number true" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_number_true.sdf" "argument b expects number, given boolean"
}

@test "binary argument b number referenced boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_number_referenced_boolean.sdf" "argument b expects number, given boolean"
}

@test "ternary argument a boolean number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_boolean_number.sdf" "argument a expects boolean, given number"
}

@test "ternary argument a boolean referenced number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_boolean_referenced_number.sdf" "argument a expects boolean, given number"
}

@test "ternary argument a number false" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_number_false.sdf" "argument a expects number, given boolean"
}

@test "ternary argument a number true" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_number_true.sdf" "argument a expects number, given boolean"
}

@test "ternary argument a number referenced boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_number_referenced_boolean.sdf" "argument a expects number, given boolean"
}

@test "ternary argument b boolean number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_boolean_number.sdf" "argument b expects boolean, given number"
}

@test "ternary argument b boolean referenced number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_boolean_referenced_number.sdf" "argument b expects boolean, given number"
}

@test "ternary argument b number false" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_number_false.sdf" "argument b expects number, given boolean"
}

@test "ternary argument b number true" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_number_true.sdf" "argument b expects number, given boolean"
}

@test "ternary argument b number referenced boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_number_referenced_boolean.sdf" "argument b expects number, given boolean"
}

@test "ternary argument c boolean number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_boolean_number.sdf" "argument c expects boolean, given number"
}

@test "ternary argument c boolean referenced number" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_boolean_referenced_number.sdf" "argument c expects boolean, given number"
}

@test "ternary argument c number false" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_number_false.sdf" "argument c expects number, given boolean"
}

@test "ternary argument c number true" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_number_true.sdf" "argument c expects number, given boolean"
}

@test "ternary argument c number referenced boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_number_referenced_boolean.sdf" "argument c expects number, given boolean"
}

@test "unary argument a reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/unary_argument_a_reserved.sdf" "argument a expects reserved, which is not implemented"
}

@test "binary argument a reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_reserved.sdf" "argument a expects reserved, which is not implemented"
}

@test "binary argument b reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_b_reserved.sdf" "argument b expects reserved, which is not implemented"
}

@test "ternary argument a reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_reserved.sdf" "argument a expects reserved, which is not implemented"
}

@test "ternary argument b reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_reserved.sdf" "argument b expects reserved, which is not implemented"
}

@test "ternary argument c reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_c_reserved.sdf" "argument c expects reserved, which is not implemented"
}

@test "binary argument a none" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/binary_argument_a_none.sdf" "argument a expects none, which is not implemented"
}

@test "ternary argument a none" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_a_none.sdf" "argument a expects none, which is not implemented"
}

@test "ternary argument b none" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/ternary_argument_b_none.sdf" "argument b expects none, which is not implemented"
}

@test "result none" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/result_none.sdf" "result of program should be number, but is none"
}

@test "result boolean" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/result_boolean.sdf" "result of program should be number, but is boolean"
}

@test "result reserved" {
  check_failure "${SDF_EXECUTABLE_PREFIX}validate${SDF_EXECUTABLE_SUFFIX} < test/sdf/result_reserved.sdf" "result of program should be number, but is reserved"
}
