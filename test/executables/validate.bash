load "../framework/main"

executable_name=validate
executable_help="validate - ensures that a bc stream is valid before passing it on
  usage: [bc stream] | validate [options] | [consumer of bc stream]
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
  check_successful "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc" ""
}

@test "valid" {
  check_successful "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/valid.bc" `cat test/bc/valid.bc`
}

@test "truncated opcode" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/truncated_opcode.bc" "unexpected eof reading opcode"
}

@test "unary argument a missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_missing.bc" "unexpected eof reading argument a"
}

@test "unary argument a truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_truncated.bc" "unexpected eof reading argument a"
}

@test "unary argument a constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_missing.bc" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "binary argument a missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_missing.bc" "unexpected eof reading argument a"
}

@test "binary argument a truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_truncated.bc" "unexpected eof reading argument a"
}

@test "binary argument a constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_missing.bc" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "binary argument b missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_missing.bc" "unexpected eof reading argument b"
}

@test "binary argument b truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_truncated.bc" "unexpected eof reading argument b"
}

@test "binary argument b constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_missing.bc" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "ternary argument a missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_missing.bc" "unexpected eof reading argument a"
}

@test "ternary argument a truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_truncated.bc" "unexpected eof reading argument a"
}

@test "ternary argument a constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_missing.bc" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "ternary argument b missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_missing.bc" "unexpected eof reading argument b"
}

@test "ternary argument b truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_truncated.bc" "unexpected eof reading argument b"
}

@test "ternary argument b constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_missing.bc" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "ternary argument c missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_missing.bc" "unexpected eof reading argument c"
}

@test "ternary argument c truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_truncated.bc" "unexpected eof reading argument c"
}

@test "ternary argument c constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_missing.bc" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "unary argument a boolean result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_boolean_result_of_instruction_being_defined.bc" "argument a references the result of a future instruction"
}

@test "unary argument a boolean result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_boolean_result_of_future_instruction.bc" "argument a references the result of a future instruction"
}

@test "unary argument a number result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_number_result_of_instruction_being_defined.bc" "argument a references the result of a future instruction"
}

@test "unary argument a number result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_number_result_of_future_instruction.bc" "argument a references the result of a future instruction"
}

@test "binary argument a boolean result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_boolean_result_of_instruction_being_defined.bc" "argument a references the result of a future instruction"
}

@test "binary argument a boolean result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_boolean_result_of_future_instruction.bc" "argument a references the result of a future instruction"
}

@test "binary argument a number result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_number_result_of_instruction_being_defined.bc" "argument a references the result of a future instruction"
}

@test "binary argument a number result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_number_result_of_future_instruction.bc" "argument a references the result of a future instruction"
}

@test "binary argument b boolean result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_boolean_result_of_instruction_being_defined.bc" "argument b references the result of a future instruction"
}

@test "binary argument b boolean result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_boolean_result_of_future_instruction.bc" "argument b references the result of a future instruction"
}

@test "binary argument b number result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_number_result_of_instruction_being_defined.bc" "argument b references the result of a future instruction"
}

@test "binary argument b number result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_number_result_of_future_instruction.bc" "argument b references the result of a future instruction"
}

@test "ternary argument a boolean result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_boolean_result_of_instruction_being_defined.bc" "argument a references the result of a future instruction"
}

@test "ternary argument a boolean result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_boolean_result_of_future_instruction.bc" "argument a references the result of a future instruction"
}

@test "ternary argument a number result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_number_result_of_instruction_being_defined.bc" "argument a references the result of a future instruction"
}

@test "ternary argument a number result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_number_result_of_future_instruction.bc" "argument a references the result of a future instruction"
}

@test "ternary argument b boolean result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_boolean_result_of_instruction_being_defined.bc" "argument b references the result of a future instruction"
}

@test "ternary argument b boolean result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_boolean_result_of_future_instruction.bc" "argument b references the result of a future instruction"
}

@test "ternary argument b number result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_number_result_of_instruction_being_defined.bc" "argument b references the result of a future instruction"
}

@test "ternary argument b number result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_number_result_of_future_instruction.bc" "argument b references the result of a future instruction"
}

@test "ternary argument c boolean result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_boolean_result_of_instruction_being_defined.bc" "argument c references the result of a future instruction"
}

@test "ternary argument c boolean result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_boolean_result_of_future_instruction.bc" "argument c references the result of a future instruction"
}

@test "ternary argument c number result of instruction being defined" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_number_result_of_instruction_being_defined.bc" "argument c references the result of a future instruction"
}

@test "ternary argument c number result of future instruction" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_number_result_of_future_instruction.bc" "argument c references the result of a future instruction"
}

@test "unary argument a boolean number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_boolean_number.bc" "argument a expects boolean, given number"
}

@test "unary argument a boolean referenced number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_boolean_referenced_number.bc" "argument a expects boolean, given number"
}

@test "unary argument a number false" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_number_false.bc" "argument a expects number, given boolean"
}

@test "unary argument a number true" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_number_true.bc" "argument a expects number, given boolean"
}

@test "unary argument a number referenced boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_number_referenced_boolean.bc" "argument a expects number, given boolean"
}

@test "binary argument a boolean number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_boolean_number.bc" "argument a expects boolean, given number"
}

@test "binary argument a boolean referenced number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_boolean_referenced_number.bc" "argument a expects boolean, given number"
}

@test "binary argument a number false" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_number_false.bc" "argument a expects number, given boolean"
}

@test "binary argument a number true" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_number_true.bc" "argument a expects number, given boolean"
}

@test "binary argument a number referenced boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_number_referenced_boolean.bc" "argument a expects number, given boolean"
}

@test "binary argument b boolean number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_boolean_number.bc" "argument b expects boolean, given number"
}

@test "binary argument b boolean referenced number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_boolean_referenced_number.bc" "argument b expects boolean, given number"
}

@test "binary argument b number false" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_number_false.bc" "argument b expects number, given boolean"
}

@test "binary argument b number true" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_number_true.bc" "argument b expects number, given boolean"
}

@test "binary argument b number referenced boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_number_referenced_boolean.bc" "argument b expects number, given boolean"
}

@test "ternary argument a boolean number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_boolean_number.bc" "argument a expects boolean, given number"
}

@test "ternary argument a boolean referenced number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_boolean_referenced_number.bc" "argument a expects boolean, given number"
}

@test "ternary argument a number false" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_number_false.bc" "argument a expects number, given boolean"
}

@test "ternary argument a number true" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_number_true.bc" "argument a expects number, given boolean"
}

@test "ternary argument a number referenced boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_number_referenced_boolean.bc" "argument a expects number, given boolean"
}

@test "ternary argument b boolean number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_boolean_number.bc" "argument b expects boolean, given number"
}

@test "ternary argument b boolean referenced number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_boolean_referenced_number.bc" "argument b expects boolean, given number"
}

@test "ternary argument b number false" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_number_false.bc" "argument b expects number, given boolean"
}

@test "ternary argument b number true" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_number_true.bc" "argument b expects number, given boolean"
}

@test "ternary argument b number referenced boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_number_referenced_boolean.bc" "argument b expects number, given boolean"
}

@test "ternary argument c boolean number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_boolean_number.bc" "argument c expects boolean, given number"
}

@test "ternary argument c boolean referenced number" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_boolean_referenced_number.bc" "argument c expects boolean, given number"
}

@test "ternary argument c number false" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_number_false.bc" "argument c expects number, given boolean"
}

@test "ternary argument c number true" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_number_true.bc" "argument c expects number, given boolean"
}

@test "ternary argument c number referenced boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_number_referenced_boolean.bc" "argument c expects number, given boolean"
}

@test "unary argument a reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_reserved.bc" "argument a expects reserved, which is not implemented"
}

@test "binary argument a reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_reserved.bc" "argument a expects reserved, which is not implemented"
}

@test "binary argument b reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_reserved.bc" "argument b expects reserved, which is not implemented"
}

@test "ternary argument a reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_reserved.bc" "argument a expects reserved, which is not implemented"
}

@test "ternary argument b reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_reserved.bc" "argument b expects reserved, which is not implemented"
}

@test "ternary argument c reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_reserved.bc" "argument c expects reserved, which is not implemented"
}

@test "binary argument a none" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_none.bc" "argument a expects none, which is not implemented"
}

@test "ternary argument a none" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_none.bc" "argument a expects none, which is not implemented"
}

@test "ternary argument b none" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_none.bc" "argument b expects none, which is not implemented"
}

@test "result none" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/result_none.bc" "result of program should be number, but is none"
}

@test "result boolean" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/result_boolean.bc" "result of program should be number, but is boolean"
}

@test "result reserved" {
  check_failure "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < test/bc/result_reserved.bc" "result of program should be number, but is reserved"
}

@test "stack at limit" {
  head -c 131064 /dev/zero > c/temp/long.bc
  cat test/bc/negate_constant_positive.bc >> c/temp/long.bc
  check_successful "${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX} < c/temp/long.bc" `cat c/temp/long.bc`
}

@test "stack overflow" {
  check_failure "head -c 131068 /dev/zero | ${BC_EXECUTABLE_PREFIX}validate${BC_EXECUTABLE_SUFFIX}" "stack overflow"
}
