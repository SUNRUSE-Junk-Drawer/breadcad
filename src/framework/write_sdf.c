#include <stdio.h>
#include "opcode.h"
#include "pointer.h"
#include "write.h"
#include "write_sdf.h"

static sdf_pointer_t sdf__written = 0;

void sdf_write_sdf_reset(void) {
  sdf__written = 0;
}

sdf_pointer_t sdf_write_sdf_nullary(
  FILE * file,
  sdf_opcode_t opcode
) {
  sdf_write_u16(file, opcode, "opcode");
  return sdf__written++;
}

sdf_pointer_t sdf_write_sdf_unary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf_write_u16(file, argument_a, "argument a");
  return sdf__written++;
}

sdf_pointer_t sdf_write_sdf_binary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf_write_u16(file, argument_a, "argument a");
  sdf_write_u16(file, argument_b, "argument b");
  return sdf__written++;
}

sdf_pointer_t sdf_write_sdf_ternary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b,
  sdf_pointer_t argument_c
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf_write_u16(file, argument_a, "argument a");
  sdf_write_u16(file, argument_b, "argument b");
  sdf_write_u16(file, argument_c, "argument c");
  return sdf__written++;
}
