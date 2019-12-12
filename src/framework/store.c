#include <stdlib.h>
#include "fail.h"
#include "malloc.h"
#include "opcode.h"
#include "argument.h"
#include "store.h"

size_t bc_store_total_opcodes = 0;
bc_opcode_t * bc_store_opcodes = NULL;
size_t bc_store_total_arguments = 0;
bc_argument_t * bc_store_arguments = NULL;

void bc_store_clear(void) {
  bc_store_total_opcodes = 0;
  free(bc_store_opcodes);
  bc_store_opcodes = NULL;
  bc_store_total_arguments = 0;
  free(bc_store_arguments);
  bc_store_arguments = NULL;
}

static void bc__store_opcode(
  bc_opcode_t opcode
) {
  if (bc_store_total_opcodes == BC_POINTER_RANGE) {
    bc_fail("stack overflow");
  }

  BC_REALLOC(bc_opcode_t, bc_store_total_opcodes + 1, "store opcodes", bc_store_opcodes);
  bc_store_opcodes[bc_store_total_opcodes] = opcode;
  bc_store_total_opcodes += 1;
}

static void bc__store_argument(
  bc_argument_t argument
) {
  BC_REALLOC(bc_argument_t, bc_store_total_arguments + 1, "store arguments", bc_store_arguments);
  bc_store_arguments[bc_store_total_arguments] = argument;
  bc_store_total_arguments++;
}

void bc_store_nullary(
  bc_opcode_t opcode
) {
  bc__store_opcode(opcode);
}

void bc_store_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
) {
  bc__store_opcode(opcode);
  bc__store_argument(argument_a);
}

void bc_store_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
) {
  bc__store_opcode(opcode);
  bc__store_argument(argument_a);
  bc__store_argument(argument_b);
}

void bc_store_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
) {
  bc__store_opcode(opcode);
  bc__store_argument(argument_a);
  bc__store_argument(argument_b);
  bc__store_argument(argument_c);
}
