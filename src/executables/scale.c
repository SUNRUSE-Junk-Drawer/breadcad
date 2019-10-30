#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/malloc.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/cli.h"
#include "../framework/executable.h"
#include "../framework/write_sdf.h"

const char * sdf_executable_name = "scale";
const char * sdf_executable_description = "uniformly scales the geometry described by a sdf stream";
const char * sdf_executable_usage_prefix = "[sdf stream] | ";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_TRUE;
const sdf_boolean_t sdf_executable_reads_models_from_command_line_arguments = SDF_BOOLEAN_FALSE;

static sdf_f32_t sdf__factor;
static sdf_boolean_t sdf__parameters_generated[] = { SDF_BOOLEAN_FALSE, SDF_BOOLEAN_FALSE, SDF_BOOLEAN_FALSE };
static sdf_argument_t sdf__manipulated_parameters[3];

void sdf_executable_cli(void) {
  sdf_cli_float("f", "factor", "scaling factor (coefficient)", &sdf__factor, 1.0f);
}

static sdf_pointer_t * sdf__remapped_pointers = NULL;
static size_t sdf__read_instructions = 0;

void sdf_executable_before_first_file(void) {
}

static void sdf__record_remapped_pointer(
  sdf_argument_t argument
) {
  SDF_REALLOC(
    sdf_pointer_t,
    sdf__read_instructions + 1,
    "record remapped pointers",
    sdf__remapped_pointers
  );
  sdf__remapped_pointers[sdf__read_instructions] = argument.pointer;
  sdf__read_instructions++;
}

static sdf_argument_t sdf__remap_argument(
  sdf_argument_t argument
) {
  if (argument.pointer > SDF_POINTER_MAX) {
    return argument;
  }

  return sdf_argument_pointer(sdf__remapped_pointers[argument.pointer]);
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
  sdf_opcode_id_t parameter;
  sdf_argument_t original_parameter;
  sdf_argument_t result;
  if (opcode >= SDF_OPCODE_PARAMETER(0) && opcode <= SDF_OPCODE_PARAMETER(2)) {
    parameter = sdf_opcode_id(opcode);
    if (!sdf__parameters_generated[parameter]) {
      original_parameter = sdf_write_sdf_nullary(opcode);
      if (sdf__factor != 1.0f) {
        result = sdf_write_sdf_binary(
          SDF_OPCODE_MULTIPLY,
          original_parameter,
          sdf_argument_float_constant(1.0f / sdf__factor)
        );
      } else {
        result = original_parameter;
      }
      sdf__manipulated_parameters[parameter] = result;
      sdf__parameters_generated[parameter] = SDF_BOOLEAN_TRUE;
    } else {
      result = sdf__manipulated_parameters[parameter];
    }
  } else {
    result = sdf_write_sdf_nullary(opcode);
  }
  sdf__record_remapped_pointer(result);
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  sdf_argument_t remapped_argument_a = sdf__remap_argument(argument_a);
  sdf_argument_t result = sdf_write_sdf_unary(opcode, remapped_argument_a);
  sdf__record_remapped_pointer(result);
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  sdf_argument_t remapped_argument_a = sdf__remap_argument(argument_a);
  sdf_argument_t remapped_argument_b = sdf__remap_argument(argument_b);
  sdf_argument_t result = sdf_write_sdf_binary(
    opcode,
    remapped_argument_a,
    remapped_argument_b
  );
  sdf__record_remapped_pointer(result);
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  sdf_argument_t remapped_argument_a = sdf__remap_argument(argument_a);
  sdf_argument_t remapped_argument_b = sdf__remap_argument(argument_b);
  sdf_argument_t remapped_argument_c = sdf__remap_argument(argument_c);
  sdf_argument_t result = sdf_write_sdf_ternary(
    opcode,
    remapped_argument_a,
    remapped_argument_b,
    remapped_argument_c
  );
  sdf__record_remapped_pointer(result);
}

void sdf_executable_eof(void) {
}

void sdf_executable_after_last_file(void) {
  if (sdf__read_instructions) {
    sdf_write_sdf_binary(
      SDF_OPCODE_MULTIPLY,
      sdf_argument_pointer(sdf__remapped_pointers[sdf__read_instructions - 1]),
      sdf_argument_float_constant(sdf__factor)
    );
  }
}

sdf_f32_t sdf_executable_get_parameter(
  void * parameter_context,
  size_t iteration,
  sdf_opcode_id_t id
) {
  SDF_UNUSED(parameter_context);
  SDF_UNUSED(iteration);
  SDF_UNUSED(id);
  return 0.0f;
}
