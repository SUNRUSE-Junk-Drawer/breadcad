#ifndef SDF_WRITE_SDF_H
#define SDF_WRITE_SDF_H

#include <stdio.h>
#include "opcode.h"
#include "pointer.h"

void sdf_write_sdf_reset(void);

sdf_pointer_t sdf_write_sdf_nullary(
  FILE * file,
  sdf_opcode_t opcode
);

sdf_pointer_t sdf_write_sdf_unary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant
);

sdf_pointer_t sdf_write_sdf_binary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant
);

sdf_pointer_t sdf_write_sdf_ternary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant,
  sdf_pointer_t argument_c_pointer,
  sdf_f32_t argument_c_float_constant
);

#endif
