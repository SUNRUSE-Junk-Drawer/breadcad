#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/fail.h"
#include "../framework/types.h"
#include "../framework/primitive.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/argument.h"
#include "../framework/executable.h"
#include "../framework/store.h"
#include "../framework/write_bc.h"

const char * bc_executable_name = "validate";
const char * bc_executable_description = "ensures that a bc stream is valid before passing it on";
const char * bc_executable_usage_prefix = "[bc stream] | ";
const char * bc_executable_usage_suffix = " | [consumer of bc stream]";
const bc_boolean_t bc_executable_reads_model_from_stdin = BC_BOOLEAN_TRUE;
const bc_boolean_t bc_executable_reads_models_from_command_line_arguments = BC_BOOLEAN_FALSE;

static bc_primitive_t bc__get_primitive_type(
  bc_argument_t argument,
  char identifier
) {
  switch (argument.pointer) {
    case BC_POINTER_BOOLEAN_CONSTANT_FALSE:
    case BC_POINTER_BOOLEAN_CONSTANT_TRUE:
      return BC_PRIMITIVE_BOOLEAN;

    case BC_POINTER_NUMBER_CONSTANT:
      return BC_PRIMITIVE_NUMBER;

    default:
      if (argument.pointer >= bc_store_total_opcodes) {
        bc_fail("argument %c references the result of a future instruction", identifier);
      }

      return bc_opcode_result(bc_store_opcodes[argument.pointer]);
  }
}

static void bc__validate_argument__value(
  bc_primitive_t expected,
  bc_argument_t argument,
  char identifier
) {
  bc_primitive_t actual = bc__get_primitive_type(argument, identifier);

  if (actual != expected) {
    bc_fail(
      "argument %c expects %s, given %s",
      identifier,
      bc_primitive_name(expected),
      bc_primitive_name(actual)
    );
  }
}

static void bc__validate_argument(
  bc_primitive_t expected,
  bc_argument_t argument,
  char identifier
) {
  switch (expected) {
    case BC_PRIMITIVE_BOOLEAN:
    case BC_PRIMITIVE_NUMBER:
      bc__validate_argument__value(
        expected,
        argument,
        identifier
      );
      break;

    default:
      bc_fail(
        "argument %c expects %s, which is not implemented",
        identifier,
        bc_primitive_name(expected)
      );
      break;
  }
}

void bc_executable_cli(void) {
}

void bc_executable_before_first_file(void) {
}

void bc_executable_nullary(
  bc_opcode_t opcode
) {
  bc_store_nullary(opcode);
}

void bc_executable_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
) {
  bc__validate_argument(bc_opcode_parameter_a(opcode), argument_a, 'a');
  bc_store_unary(opcode, argument_a);
}

void bc_executable_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
) {
  bc__validate_argument(bc_opcode_parameter_a(opcode), argument_a, 'a');
  bc__validate_argument(bc_opcode_parameter_b(opcode), argument_b, 'b');
  bc_store_binary(opcode, argument_a, argument_b);
}

void bc_executable_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
) {
  bc__validate_argument(bc_opcode_parameter_a(opcode), argument_a, 'a');
  bc__validate_argument(bc_opcode_parameter_b(opcode), argument_b, 'b');
  bc__validate_argument(bc_opcode_parameter_c(opcode), argument_c, 'c');
  bc_store_ternary(opcode, argument_a, argument_b, argument_c);
}

void bc_executable_eof(void) {
}

static void bc__check_return_type(void) {
  bc_primitive_t type = bc_opcode_result(bc_store_opcodes[bc_store_total_opcodes - 1]);

  if (type == BC_PRIMITIVE_NUMBER) {
    return;
  }

  bc_fail("result of program should be number, but is %s", bc_primitive_name(type));
}

static void bc__emit_stored(void) {
  size_t instruction = 0;
  size_t argument = 0;
  bc_opcode_t opcode;
  bc_opcode_arity_t arity;
  bc_argument_t argument_a;
  bc_argument_t argument_b;
  bc_argument_t argument_c;

  while (instruction < bc_store_total_opcodes) {
    opcode = bc_store_opcodes[instruction];
    arity = bc_opcode_arity(opcode);
    switch (arity) {
      case 0:
        bc_write_bc_nullary(opcode);
        break;

      case 1:
        argument_a = bc_store_arguments[argument++];
        bc_write_bc_unary(opcode, argument_a);
        break;

      case 2:
        argument_a = bc_store_arguments[argument++];
        argument_b = bc_store_arguments[argument++];
        bc_write_bc_binary(opcode, argument_a, argument_b);
        break;

      case 3:
        argument_a = bc_store_arguments[argument++];
        argument_b = bc_store_arguments[argument++];
        argument_c = bc_store_arguments[argument++];
        bc_write_bc_ternary(opcode, argument_a, argument_b, argument_c);
        break;

      default:
        bc_fail("unexpected opcode arity %#02x\n", (unsigned int)arity);
        break;
    }
    instruction++;
  }
}

void bc_executable_after_last_file(void) {
  if (bc_store_total_opcodes) {
    bc__check_return_type();
  }
  bc__emit_stored();
}

bc_number_t bc_executable_get_parameter(
  void * parameter_context,
  size_t iteration,
  bc_opcode_id_t id
) {
  BC_UNUSED(parameter_context);
  BC_UNUSED(iteration);
  BC_UNUSED(id);
  return 0.0f;
}
