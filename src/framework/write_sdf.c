#include <stdio.h>
#include "opcode.h"
#include "pointer.h"
#include "argument.h"
#include "write.h"
#include "write_sdf.h"

static sdf_pointer_t sdf__written = 0;

static void sdf__write_argument(
  FILE * file,
  sdf_argument_t argument
) {
  sdf_write_u16(file, argument.pointer, "argument pointer");
  if (argument.pointer == SDF_POINTER_FLOAT_CONSTANT) {
    sdf_write_f32(file, argument.float_constant, "argument float constant");
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
  FILE * file,
  sdf_opcode_t opcode
) {
  sdf_write_u16(file, opcode, "opcode");
  return sdf__return_and_increment_written();
}

sdf_argument_t sdf_write_sdf_unary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf__write_argument(file, argument_a);
  return sdf__return_and_increment_written();
}

sdf_argument_t sdf_write_sdf_binary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf__write_argument(file, argument_a);
  sdf__write_argument(file, argument_b);
  return sdf__return_and_increment_written();
}

sdf_argument_t sdf_write_sdf_ternary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf__write_argument(file, argument_a);
  sdf__write_argument(file, argument_b);
  sdf__write_argument(file, argument_c);
  return sdf__return_and_increment_written();
}
