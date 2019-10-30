#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/malloc.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/argument.h"
#include "../framework/executable.h"
#include "../framework/write_sdf.h"

const char * sdf_executable_name = "union";
const char * sdf_executable_description = "combines any number of sdf streams using a csg union";
const char * sdf_executable_usage_prefix = "";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_FALSE;
const sdf_boolean_t sdf_executable_reads_models_from_command_line_arguments = SDF_BOOLEAN_TRUE;

void sdf_executable_cli(void) {
}

void sdf_executable_before_first_file(void) {
}

static sdf_pointer_t sdf__pointer_offset = 0;
static sdf_boolean_t sdf__written_at_least_one_previous_file;
static sdf_argument_t sdf__last_written;
static sdf_argument_t sdf__accumulated_value;
static sdf_boolean_t sdf__empty_file = SDF_BOOLEAN_TRUE;

static sdf_argument_t sdf__write_argument(
  sdf_argument_t argument
) {
  if (argument.pointer > SDF_POINTER_MAX) {
    return argument;
  } else {
    argument.pointer += sdf__pointer_offset;
    return argument;
  }
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
  sdf__empty_file = SDF_BOOLEAN_FALSE;
  sdf__last_written = sdf_write_sdf_nullary(opcode);
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  sdf__empty_file = SDF_BOOLEAN_FALSE;
  sdf__last_written = sdf_write_sdf_unary(
    opcode,
    sdf__write_argument(argument_a)
  );
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  sdf__empty_file = SDF_BOOLEAN_FALSE;
  sdf__last_written = sdf_write_sdf_binary(
    opcode,
    sdf__write_argument(argument_a),
    sdf__write_argument(argument_b)
  );
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  sdf__empty_file = SDF_BOOLEAN_FALSE;
  sdf__last_written = sdf_write_sdf_ternary(
    opcode,
    sdf__write_argument(argument_a),
    sdf__write_argument(argument_b),
    sdf__write_argument(argument_c)
  );
}

void sdf_executable_eof(void) {
  if (sdf__empty_file) {
    return;
  }

  sdf__empty_file = SDF_BOOLEAN_TRUE;

  if (sdf__written_at_least_one_previous_file) {
    sdf__last_written = sdf_write_sdf_binary(
      SDF_OPCODE_MIN,
      sdf__accumulated_value,
      sdf__last_written
    );
  } else {
    sdf__written_at_least_one_previous_file = SDF_BOOLEAN_TRUE;
  }

  sdf__accumulated_value = sdf__last_written;
  sdf__pointer_offset = sdf__last_written.pointer + 1;
}

void sdf_executable_after_last_file(void) {
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
