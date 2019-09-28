#include <stdlib.h>
#include "fail.h"
#include "malloc.h"
#include "opcode.h"
#include "pointer.h"
#include "store.h"

size_t sdf_store_total_opcodes = 0;
sdf_opcode_t * sdf_store_opcodes = NULL;
size_t sdf_store_total_arguments = 0;
sdf_pointer_t * sdf_store_arguments = NULL;

void sdf_store_clear(void) {
  sdf_store_total_opcodes = 0;
  free(sdf_store_opcodes);
  sdf_store_opcodes = NULL;
  sdf_store_total_arguments = 0;
  free(sdf_store_arguments);
  sdf_store_arguments = NULL;
}

static void sdf__store_opcode(
  sdf_opcode_t opcode
) {
  if (sdf_store_total_opcodes == SDF_POINTER_RANGE) {
    sdf_fail("stack overflow");
  }

  SDF_REALLOC(sdf_opcode_t, sdf_store_total_opcodes + 1, "store opcodes", sdf_store_opcodes);
  sdf_store_opcodes[sdf_store_total_opcodes] = opcode;
  sdf_store_total_opcodes += 1;
}

static void sdf__store_argument(
  sdf_pointer_t argument
) {
  SDF_REALLOC(sdf_pointer_t, sdf_store_total_arguments + 1, "store arguments", sdf_store_arguments);
  sdf_store_arguments[sdf_store_total_arguments] = argument;
  sdf_store_total_arguments++;
}

void sdf_store_nullary(
  sdf_opcode_t opcode
) {
  sdf__store_opcode(opcode);
}

void sdf_store_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a
) {
  sdf__store_opcode(opcode);
  sdf__store_argument(argument_a);
}

void sdf_store_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b
) {
  sdf__store_opcode(opcode);
  sdf__store_argument(argument_a);
  sdf__store_argument(argument_b);
}

void sdf_store_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b,
  sdf_pointer_t argument_c
) {
  sdf__store_opcode(opcode);
  sdf__store_argument(argument_a);
  sdf__store_argument(argument_b);
  sdf__store_argument(argument_c);
}
