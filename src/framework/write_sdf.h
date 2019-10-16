#ifndef SDF_WRITE_SDF_H
#define SDF_WRITE_SDF_H

#include <stdio.h>
#include "opcode.h"
#include "argument.h"

void sdf_write_sdf_reset(void);

sdf_argument_t sdf_write_sdf_nullary(
  sdf_opcode_t opcode
);

sdf_argument_t sdf_write_sdf_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
);

sdf_argument_t sdf_write_sdf_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
);

sdf_argument_t sdf_write_sdf_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
);

#endif
