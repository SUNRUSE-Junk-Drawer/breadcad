#ifndef BC_STORE_H
#define BC_STORE_H

#include <stdlib.h>
#include "opcode.h"
#include "argument.h"

extern size_t bc_store_total_opcodes;
extern bc_opcode_t * bc_store_opcodes;
extern size_t bc_store_total_arguments;
extern bc_argument_t * bc_store_arguments;

void bc_store_clear(void);

void bc_store_nullary(
  bc_opcode_t opcode
);

void bc_store_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
);

void bc_store_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
);

void bc_store_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
);

#endif
