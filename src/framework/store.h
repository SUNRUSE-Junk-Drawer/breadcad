#ifndef SDF_STORE_H
#define SDF_STORE_H

#include <stdlib.h>
#include "opcode.h"
#include "argument.h"

extern size_t sdf_store_total_opcodes;
extern sdf_opcode_t * sdf_store_opcodes;
extern size_t sdf_store_total_arguments;
extern sdf_argument_t * sdf_store_arguments;

void sdf_store_clear(void);

void sdf_store_nullary(
  sdf_opcode_t opcode
);

void sdf_store_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
);

void sdf_store_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
);

void sdf_store_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
);

#endif
