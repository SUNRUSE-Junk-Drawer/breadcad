#ifndef SDF_STORE_H
#define SDF_STORE_H

#include <stdlib.h>
#include "opcode.h"
#include "pointer.h"

extern size_t sdf_store_total_opcodes;
extern sdf_opcode_t * sdf_store_opcodes;
extern size_t sdf_store_total_arguments;
extern sdf_pointer_t * sdf_store_argument_pointers;
extern sdf_f32_t * sdf_store_argument_float_constants;

void sdf_store_clear(void);

void sdf_store_nullary(
  sdf_opcode_t opcode
);

void sdf_store_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant
);

void sdf_store_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant
);

void sdf_store_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant,
  sdf_pointer_t argument_c_pointer,
  sdf_f32_t argument_c_float_constant
);

#endif
