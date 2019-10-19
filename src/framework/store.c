#include <stdlib.h>
#include "fail.h"
#include "malloc.h"
#include "opcode.h"
#include "pointer.h"
#include "argument.h"
#include "store.h"

size_t sdf_store_total_opcodes = 0;
sdf_opcode_t * sdf_store_opcodes = NULL;
size_t sdf_store_total_arguments = 0;
sdf_pointer_t * sdf_store_argument_pointers = NULL;
sdf_f32_t * sdf_store_argument_float_constants = NULL;

void sdf_store_clear(void) {
  sdf_store_total_opcodes = 0;
  free(sdf_store_opcodes);
  sdf_store_opcodes = NULL;
  sdf_store_total_arguments = 0;
  free(sdf_store_argument_pointers);
  free(sdf_store_argument_float_constants);
  sdf_store_argument_pointers = NULL;
  sdf_store_argument_float_constants = NULL;
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
  sdf_pointer_t argument_pointer,
  sdf_f32_t argument_float_constant
) {
  SDF_REALLOC(sdf_pointer_t, sdf_store_total_arguments + 1, "store argument pointers", sdf_store_argument_pointers);
  sdf_store_argument_pointers[sdf_store_total_arguments] = argument_pointer;
  SDF_REALLOC(sdf_f32_t, sdf_store_total_arguments + 1, "store argument float constants", sdf_store_argument_float_constants);
  sdf_store_argument_float_constants[sdf_store_total_arguments] = argument_float_constant;
  sdf_store_total_arguments++;
}

void sdf_store_nullary(
  sdf_opcode_t opcode
) {
  sdf__store_opcode(opcode);
}

void sdf_store_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  sdf__store_opcode(opcode);
  sdf__store_argument(argument_a.pointer, argument_a.float_constant);
}

void sdf_store_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  sdf__store_opcode(opcode);
  sdf__store_argument(argument_a.pointer, argument_a.float_constant);
  sdf__store_argument(argument_b.pointer, argument_b.float_constant);
}

void sdf_store_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  sdf__store_opcode(opcode);
  sdf__store_argument(argument_a.pointer, argument_a.float_constant);
  sdf__store_argument(argument_b.pointer, argument_b.float_constant);
  sdf__store_argument(argument_c.pointer, argument_c.float_constant);
}
