#include <stdio.h>
#include "opcode.h"
#include "pointer.h"
#include "argument.h"
#include "write.h"
#include "write_sdf.h"

static sdf_pointer_t sdf__written = 0;

static void sdf__write_argument(
  sdf_argument_t argument
) {
  sdf_write_u16(argument.pointer, "argument pointer");
  if (argument.pointer == SDF_POINTER_NUMBER_CONSTANT) {
    sdf_write_number(argument.number_constant, "argument number constant");
  }
}

static sdf_argument_t sdf__return_and_increment_written(void) {
  sdf_argument_t output = sdf_argument_pointer(sdf__written);
  sdf__written++;
  return output;
}

void sdf_write_sdf_reset(void) {
  sdf__written = 0;
}

sdf_argument_t sdf_write_sdf_nullary(
  sdf_opcode_t opcode
) {
  sdf_write_u16(opcode, "opcode");
  return sdf__return_and_increment_written();
}

sdf_argument_t sdf_write_sdf_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  sdf_write_u16(opcode, "opcode");
  sdf__write_argument(argument_a);
  return sdf__return_and_increment_written();
}

sdf_argument_t sdf_write_sdf_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  sdf_write_u16(opcode, "opcode");
  sdf__write_argument(argument_a);
  sdf__write_argument(argument_b);
  return sdf__return_and_increment_written();
}

sdf_argument_t sdf_write_sdf_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  sdf_write_u16(opcode, "opcode");
  sdf__write_argument(argument_a);
  sdf__write_argument(argument_b);
  sdf__write_argument(argument_c);
  return sdf__return_and_increment_written();
}
