#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/fail.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/argument.h"
#include "../framework/executable.h"
#include "../framework/store.h"
#include "../framework/write_sdf.h"

const char * sdf_executable_name = "validate";
const char * sdf_executable_description = "ensures that a sdf stream is valid before passing it on";
const char * sdf_executable_usage_prefix = "[sdf stream] | ";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_TRUE;
const sdf_boolean_t sdf_executable_reads_models_from_command_line_arguments = SDF_BOOLEAN_FALSE;

static void sdf__validate_argument(
  sdf_argument_t argument,
  char identifier
) {
  if (argument.pointer <= SDF_POINTER_MAX ) {
    if (argument.pointer >= sdf_store_total_opcodes) {
      sdf_fail("argument %c references the result of a future instruction", identifier);
    }
  }
}

void sdf_executable_cli(void) {
}

void sdf_executable_before_first_file(void) {
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
  sdf_store_nullary(opcode);
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  sdf__validate_argument(argument_a, 'a');
  sdf_store_unary(opcode, argument_a);
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  sdf__validate_argument(argument_a, 'a');
  sdf__validate_argument(argument_b, 'b');
  sdf_store_binary(opcode, argument_a, argument_b);
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  sdf__validate_argument(argument_a, 'a');
  sdf__validate_argument(argument_b, 'b');
  sdf__validate_argument(argument_c, 'c');
  sdf_store_ternary(opcode, argument_a, argument_b, argument_c);
}

void sdf_executable_eof(void) {
}

void sdf_executable_after_last_file(void) {
  size_t instruction = 0;
  size_t argument = 0;
  sdf_opcode_t opcode;
  sdf_opcode_arity_t arity;
  sdf_argument_t argument_a;
  sdf_argument_t argument_b;
  sdf_argument_t argument_c;

  while (instruction < sdf_store_total_opcodes) {
    opcode = sdf_store_opcodes[instruction];
    arity = sdf_opcode_arity(opcode);
    switch (arity) {
      case 0:
        sdf_write_sdf_nullary(opcode);
        break;

      case 1:
        argument_a = sdf_store_arguments[argument++];
        sdf_write_sdf_unary(opcode, argument_a);
        break;

      case 2:
        argument_a = sdf_store_arguments[argument++];
        argument_b = sdf_store_arguments[argument++];
        sdf_write_sdf_binary(opcode, argument_a, argument_b);
        break;

      case 3:
        argument_a = sdf_store_arguments[argument++];
        argument_b = sdf_store_arguments[argument++];
        argument_c = sdf_store_arguments[argument++];
        sdf_write_sdf_ternary(opcode, argument_a, argument_b, argument_c);
        break;

      default:
        sdf_fail("unexpected opcode arity %#02x\n", (unsigned int)arity);
        break;
    }
    instruction++;
  }
}

sdf_number_t sdf_executable_get_parameter(
  void * parameter_context,
  size_t iteration,
  sdf_opcode_id_t id
) {
  SDF_UNUSED(parameter_context);
  SDF_UNUSED(iteration);
  SDF_UNUSED(id);
  return 0.0f;
}
