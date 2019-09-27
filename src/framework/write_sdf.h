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
  sdf_pointer_t argument_a
);

sdf_pointer_t sdf_write_sdf_binary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b
);

sdf_pointer_t sdf_write_sdf_ternary(
  FILE * file,
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b,
  sdf_pointer_t argument_c
);

#endif
