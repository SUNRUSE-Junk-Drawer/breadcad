#include <stdio.h>
#include "opcode.h"
#include "pointer.h"
#include "write.h"
#include "write_sdf.h"

static sdf_pointer_t sdf__written = 0;

static void sdf__write_argument(
  FILE * file,
  sdf_pointer_t pointer,
  sdf_f32_t float_constant
) {
  sdf_write_u16(file, pointer, "argument pointer");
  if (pointer == SDF_POINTER_FLOAT_CONSTANT) {
    sdf_write_f32(file, float_constant, "argument float constant");
  }
}

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
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf__write_argument(file, argument_a_pointer, argument_a_float_constant);
  return sdf__written++;
}

sdf_pointer_t sdf_write_sdf_binary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf__write_argument(file, argument_a_pointer, argument_a_float_constant);
  sdf__write_argument(file, argument_b_pointer, argument_b_float_constant);
  return sdf__written++;
}

sdf_pointer_t sdf_write_sdf_ternary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant,
  sdf_pointer_t argument_c_pointer,
  sdf_f32_t argument_c_float_constant
) {
  sdf_write_u16(file, opcode, "opcode");
  sdf__write_argument(file, argument_a_pointer, argument_a_float_constant);
  sdf__write_argument(file, argument_b_pointer, argument_b_float_constant);
  sdf__write_argument(file, argument_c_pointer, argument_c_float_constant);
  return sdf__written++;
}
