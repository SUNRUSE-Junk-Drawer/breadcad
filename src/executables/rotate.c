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

const char * sdf_executable_name = "rotate";
const char * sdf_executable_description = "rotates the geometry described by a sdf stream";
const char * sdf_executable_usage_prefix = "[sdf stream] | ";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_TRUE;
const sdf_boolean_t sdf_executable_reads_models_from_command_line_arguments = SDF_BOOLEAN_FALSE;

static sdf_f32_t sdf__rotation[3];
static sdf_argument_t sdf__modified_parameters[3];
static sdf_boolean_t sdf__performed_rotation = SDF_BOOLEAN_FALSE;

void sdf_executable_cli(void) {
  sdf_cli_float("x", "x", "rotation around the x axis (degrees)", &sdf__rotation[0], 0.0f);
  sdf_cli_float("y", "y", "rotation around the y axis (degrees)", &sdf__rotation[1], 0.0f);
  sdf_cli_float("z", "z", "rotation around the z axis (degrees)", &sdf__rotation[2], 0.0f);
}

static sdf_pointer_t * sdf__remapped_pointers = NULL;
static size_t sdf__read_instructions = 0;

void sdf_executable_before_first_file(void) {
}

static void sdf__convert_degrees_to_radians(void) {
  sdf_opcode_id_t axis = 0;
  while (axis < 3) {
    sdf__rotation[axis] *= 3.14159265358979323846f / 180.0f;
    axis++;
  }
}

static void sdf__query_parameters(void) {
  sdf_opcode_id_t axis = 0;
  while (axis < 3) {
    sdf__modified_parameters[axis] = sdf_write_sdf_nullary(SDF_OPCODE_PARAMETER(axis));
    axis++;
  }
}

static sdf_opcode_id_t sdf__first_rotated_axis(
  sdf_opcode_id_t axis
) {
  switch (axis) {
    case 0:
      return 1;
    case 1:
      return 2;
    default:
      return 0;
  }
}

static sdf_opcode_id_t sdf__second_rotated_axis(
  sdf_opcode_id_t axis
) {
  switch (axis) {
    case 0:
      return 2;
    case 1:
      return 0;
    default:
      return 1;
  }
}

static void sdf__apply_rotation(
  sdf_opcode_id_t axis
) {
  sdf_argument_t first_rotated_axis;
  sdf_argument_t second_rotated_axis;
  sdf_argument_t coefficient_a;
  sdf_argument_t coefficient_a_negated;
  sdf_argument_t coefficient_b;
  sdf_argument_t first_axis;
  sdf_argument_t second_axis;

  if (!sdf__rotation[axis]) {
    return;
  }

  first_rotated_axis = sdf__modified_parameters[sdf__first_rotated_axis(axis)];
  second_rotated_axis = sdf__modified_parameters[sdf__second_rotated_axis(axis)];

  coefficient_a = sdf_argument_float_constant(__builtin_sinf(sdf__rotation[axis]));
  coefficient_a_negated = sdf_argument_float_constant(-__builtin_sinf(sdf__rotation[axis]));
  coefficient_b = sdf_argument_float_constant(__builtin_cosf(sdf__rotation[axis]));

  first_axis = sdf_write_sdf_binary(
    SDF_OPCODE_MULTIPLY,
    first_rotated_axis,
    coefficient_b
  );

  second_axis = sdf_write_sdf_binary(
    SDF_OPCODE_MULTIPLY,
    second_rotated_axis,
    coefficient_a
  );

  sdf__modified_parameters[sdf__first_rotated_axis(axis)] = sdf_write_sdf_binary(
    SDF_OPCODE_ADD,
    first_axis,
    second_axis
  );

  first_axis = sdf_write_sdf_binary(
    SDF_OPCODE_MULTIPLY,
    first_rotated_axis,
    coefficient_a_negated
  );

  second_axis = sdf_write_sdf_binary(
    SDF_OPCODE_MULTIPLY,
    second_rotated_axis,
    coefficient_b
  );

  sdf__modified_parameters[sdf__second_rotated_axis(axis)] = sdf_write_sdf_binary(
    SDF_OPCODE_ADD,
    first_axis,
    second_axis
  );
}

static void sdf__apply_rotations(void) {
  sdf_opcode_id_t axis = 3;
  while (axis) {
    axis--;
    sdf__apply_rotation(axis);
  }
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
  sdf_argument_t result;
  if (opcode >= SDF_OPCODE_PARAMETER(0) && opcode <= SDF_OPCODE_PARAMETER(2)) {
    if (!sdf__performed_rotation) {
      sdf__convert_degrees_to_radians();
      sdf__query_parameters();
      sdf__apply_rotations();

      sdf__performed_rotation = SDF_BOOLEAN_TRUE;
    }

    parameter = sdf_opcode_id(opcode);
    result = sdf__modified_parameters[parameter];
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
