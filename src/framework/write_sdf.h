#ifndef BC_WRITE_BC_H
#define BC_WRITE_BC_H

#include <stdio.h>
#include "opcode.h"
#include "argument.h"

void bc_write_bc_reset(void);

bc_argument_t bc_write_bc_nullary(
  bc_opcode_t opcode
);

bc_argument_t bc_write_bc_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
);

bc_argument_t bc_write_bc_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
);

bc_argument_t bc_write_bc_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
);

#endif
