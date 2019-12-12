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

const char * bc_executable_name = "rotate";
const char * bc_executable_description = "rotates the geometry described by a bc stream";
const char * bc_executable_usage_prefix = "[bc stream] | ";
const char * bc_executable_usage_suffix = " | [consumer of bc stream]";
const bc_boolean_t bc_executable_reads_model_from_stdin = BC_BOOLEAN_TRUE;
const bc_boolean_t bc_executable_reads_models_from_command_line_arguments = BC_BOOLEAN_FALSE;

static bc_number_t bc__rotation[3];
static bc_argument_t bc__modified_parameters[3];
static bc_boolean_t bc__performed_rotation = BC_BOOLEAN_FALSE;

void bc_executable_cli(void) {
  bc_cli_number("x", "x", "rotation around the x axis (degrees)", &bc__rotation[0], 0.0f);
  bc_cli_number("y", "y", "rotation around the y axis (degrees)", &bc__rotation[1], 0.0f);
  bc_cli_number("z", "z", "rotation around the z axis (degrees)", &bc__rotation[2], 0.0f);
}

static bc_pointer_t * bc__remapped_pointers = NULL;
static size_t bc__read_instructions = 0;

void bc_executable_before_first_file(void) {
}

static void bc__convert_degrees_to_radians(void) {
  bc_opcode_id_t axis = 0;
  while (axis < 3) {
    bc__rotation[axis] *= 3.14159265358979323846f / 180.0f;
    axis++;
  }
}

static void bc__query_parameters(void) {
  bc_opcode_id_t axis = 0;
  while (axis < 3) {
    bc__modified_parameters[axis] = bc_write_bc_nullary(BC_OPCODE_PARAMETER(axis));
    axis++;
  }
}

static bc_opcode_id_t bc__first_rotated_axis(
  bc_opcode_id_t axis
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

static bc_opcode_id_t bc__second_rotated_axis(
  bc_opcode_id_t axis
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

static void bc__apply_rotation(
  bc_opcode_id_t axis
) {
  bc_argument_t first_rotated_axis;
  bc_argument_t second_rotated_axis;
  bc_argument_t coefficient_a;
  bc_argument_t coefficient_a_negated;
  bc_argument_t coefficient_b;
  bc_argument_t first_axis;
  bc_argument_t second_axis;

  if (!bc__rotation[axis]) {
    return;
  }

  first_rotated_axis = bc__modified_parameters[bc__first_rotated_axis(axis)];
  second_rotated_axis = bc__modified_parameters[bc__second_rotated_axis(axis)];

  coefficient_a = bc_argument_number_constant(__builtin_sinf(bc__rotation[axis]));
  coefficient_a_negated = bc_argument_number_constant(-__builtin_sinf(bc__rotation[axis]));
  coefficient_b = bc_argument_number_constant(__builtin_cosf(bc__rotation[axis]));

  first_axis = bc_write_bc_binary(
    BC_OPCODE_MULTIPLY,
    first_rotated_axis,
    coefficient_b
  );

  second_axis = bc_write_bc_binary(
    BC_OPCODE_MULTIPLY,
    second_rotated_axis,
    coefficient_a
  );

  bc__modified_parameters[bc__first_rotated_axis(axis)] = bc_write_bc_binary(
    BC_OPCODE_ADD,
    first_axis,
    second_axis
  );

  first_axis = bc_write_bc_binary(
    BC_OPCODE_MULTIPLY,
    first_rotated_axis,
    coefficient_a_negated
  );

  second_axis = bc_write_bc_binary(
    BC_OPCODE_MULTIPLY,
    second_rotated_axis,
    coefficient_b
  );

  bc__modified_parameters[bc__second_rotated_axis(axis)] = bc_write_bc_binary(
    BC_OPCODE_ADD,
    first_axis,
    second_axis
  );
}

static void bc__apply_rotations(void) {
  bc_opcode_id_t axis = 3;
  while (axis) {
    axis--;
    bc__apply_rotation(axis);
  }
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
  bc_argument_t result;
  if (opcode >= BC_OPCODE_PARAMETER(0) && opcode <= BC_OPCODE_PARAMETER(2)) {
    if (!bc__performed_rotation) {
      bc__convert_degrees_to_radians();
      bc__query_parameters();
      bc__apply_rotations();

      bc__performed_rotation = BC_BOOLEAN_TRUE;
    }

    parameter = bc_opcode_id(opcode);
    result = bc__modified_parameters[parameter];
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
