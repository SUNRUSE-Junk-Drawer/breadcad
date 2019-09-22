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

static void sdf__expand(
  sdf_opcode_t opcode,
  sdf_opcode_arity_t arity
) {
  if (sdf_store_total_opcodes == SDF_POINTER_RANGE) {
    sdf_fail("stack overflow");
  }

  SDF_REALLOC(sdf_opcode_t, sdf_store_total_opcodes + 1, "store opcodes", sdf_store_opcodes);
  sdf_store_opcodes[sdf_store_total_opcodes] = opcode;
  sdf_store_total_opcodes += 1;

  SDF_REALLOC(sdf_pointer_t, sdf_store_total_arguments + arity, "store arguments", sdf_store_arguments);
}

void sdf_store_nullary(
  sdf_opcode_t opcode
) {
  sdf__expand(opcode, 0);
}

void sdf_store_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a
) {
  sdf__expand(opcode, 1);
  sdf_store_arguments[sdf_store_total_arguments++] = argument_a;
}

void sdf_store_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b
) {
  sdf__expand(opcode, 2);
  sdf_store_arguments[sdf_store_total_arguments++] = argument_a;
  sdf_store_arguments[sdf_store_total_arguments++] = argument_b;
}

void sdf_store_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a,
  sdf_pointer_t argument_b,
  sdf_pointer_t argument_c
) {
  sdf__expand(opcode, 3);
  sdf_store_arguments[sdf_store_total_arguments++] = argument_a;
  sdf_store_arguments[sdf_store_total_arguments++] = argument_b;
  sdf_store_arguments[sdf_store_total_arguments++] = argument_c;
}
