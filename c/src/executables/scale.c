#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/malloc.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/cli.h"
#include "../framework/executable.h"
#include "../framework/write_bc.h"

const char * bc_executable_name = "scale";
const char * bc_executable_description = "uniformly scales the geometry described by a bc stream";
const char * bc_executable_usage_prefix = "[bc stream] | ";
const char * bc_executable_usage_suffix = " | [consumer of bc stream]";
const bc_boolean_t bc_executable_reads_model_from_stdin = BC_BOOLEAN_TRUE;
const bc_boolean_t bc_executable_reads_models_from_command_line_arguments = BC_BOOLEAN_FALSE;

static bc_number_t bc__factor;
static bc_boolean_t bc__parameters_generated[] = { BC_BOOLEAN_FALSE, BC_BOOLEAN_FALSE, BC_BOOLEAN_FALSE };
static bc_argument_t bc__manipulated_parameters[3];

void bc_executable_cli(void) {
  bc_cli_number("f", "factor", "scaling factor (coefficient)", &bc__factor, 1.0f);
}

static bc_pointer_t * bc__remapped_pointers = NULL;
static size_t bc__read_instructions = 0;

void bc_executable_before_first_file(void) {
}

static void bc__record_remapped_pointer(
  bc_argument_t argument
) {
  BC_REALLOC(
    bc_pointer_t,
    bc__read_instructions + 1,
    "record remapped pointers",
    bc__remapped_pointers
  );
  bc__remapped_pointers[bc__read_instructions] = argument.pointer;
  bc__read_instructions++;
}

static bc_argument_t bc__remap_argument(
  bc_argument_t argument
) {
  if (argument.pointer > BC_POINTER_MAX) {
    return argument;
  }

  return bc_argument_pointer(bc__remapped_pointers[argument.pointer]);
}

void bc_executable_nullary(
  bc_opcode_t opcode
) {
  bc_opcode_id_t parameter;
  bc_argument_t original_parameter;
  bc_argument_t result;
  if (opcode >= BC_OPCODE_PARAMETER(0) && opcode <= BC_OPCODE_PARAMETER(2)) {
    parameter = bc_opcode_id(opcode);
    if (!bc__parameters_generated[parameter]) {
      original_parameter = bc_write_bc_nullary(opcode);
      if (bc__factor != 1.0f) {
        result = bc_write_bc_binary(
          BC_OPCODE_MULTIPLY,
          original_parameter,
          bc_argument_number_constant(1.0f / bc__factor)
        );
      } else {
        result = original_parameter;
      }
      bc__manipulated_parameters[parameter] = result;
      bc__parameters_generated[parameter] = BC_BOOLEAN_TRUE;
    } else {
      result = bc__manipulated_parameters[parameter];
    }
  } else {
    result = bc_write_bc_nullary(opcode);
  }
  bc__record_remapped_pointer(result);
}

void bc_executable_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
) {
  bc_argument_t remapped_argument_a = bc__remap_argument(argument_a);
  bc_argument_t result = bc_write_bc_unary(opcode, remapped_argument_a);
  bc__record_remapped_pointer(result);
}

void bc_executable_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
) {
  bc_argument_t remapped_argument_a = bc__remap_argument(argument_a);
  bc_argument_t remapped_argument_b = bc__remap_argument(argument_b);
  bc_argument_t result = bc_write_bc_binary(
    opcode,
    remapped_argument_a,
    remapped_argument_b
  );
  bc__record_remapped_pointer(result);
}

void bc_executable_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
) {
  bc_argument_t remapped_argument_a = bc__remap_argument(argument_a);
  bc_argument_t remapped_argument_b = bc__remap_argument(argument_b);
  bc_argument_t remapped_argument_c = bc__remap_argument(argument_c);
  bc_argument_t result = bc_write_bc_ternary(
    opcode,
    remapped_argument_a,
    remapped_argument_b,
    remapped_argument_c
  );
  bc__record_remapped_pointer(result);
}

void bc_executable_eof(void) {
}

void bc_executable_after_last_file(void) {
  if (bc__read_instructions) {
    bc_write_bc_binary(
      BC_OPCODE_MULTIPLY,
      bc_argument_pointer(bc__remapped_pointers[bc__read_instructions - 1]),
      bc_argument_number_constant(bc__factor)
    );
  }
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
