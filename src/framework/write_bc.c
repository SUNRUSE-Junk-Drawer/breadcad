#include <stdio.h>
#include "opcode.h"
#include "pointer.h"
#include "argument.h"
#include "write.h"
#include "write_bc.h"

static bc_pointer_t bc__written = 0;

static void bc__write_argument(
  bc_argument_t argument
) {
  bc_write_u16(argument.pointer, "argument pointer");
  if (argument.pointer == BC_POINTER_NUMBER_CONSTANT) {
    bc_write_number(argument.number_constant, "argument number constant");
  }
}

static bc_argument_t bc__return_and_increment_written(void) {
  bc_argument_t output = bc_argument_pointer(bc__written);
  bc__written++;
  return output;
}

void bc_write_bc_reset(void) {
  bc__written = 0;
}

bc_argument_t bc_write_bc_nullary(
  bc_opcode_t opcode
) {
  bc_write_u16(opcode, "opcode");
  return bc__return_and_increment_written();
}

bc_argument_t bc_write_bc_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
) {
  bc_write_u16(opcode, "opcode");
  bc__write_argument(argument_a);
  return bc__return_and_increment_written();
}

bc_argument_t bc_write_bc_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
) {
  bc_write_u16(opcode, "opcode");
  bc__write_argument(argument_a);
  bc__write_argument(argument_b);
  return bc__return_and_increment_written();
}

bc_argument_t bc_write_bc_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
) {
  bc_write_u16(opcode, "opcode");
  bc__write_argument(argument_a);
  bc__write_argument(argument_b);
  bc__write_argument(argument_c);
  return bc__return_and_increment_written();
}
