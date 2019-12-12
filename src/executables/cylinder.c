#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/argument.h"
#include "../framework/cli.h"
#include "../framework/write_bc.h"
#include "../framework/executable.h"

const char * bc_executable_name = "cylinder";
const char * bc_executable_description = "generates a cylinder along the z axis";
const char * bc_executable_usage_prefix = "";
const char * bc_executable_usage_suffix = " | [consumer of bc stream]";
const bc_boolean_t bc_executable_reads_model_from_stdin = BC_BOOLEAN_FALSE;
const bc_boolean_t bc_executable_reads_models_from_command_line_arguments = BC_BOOLEAN_FALSE;

static bc_number_t bc__size_xy;
static bc_number_t bc__size_z;

static bc_boolean_t bc__center_xy;
static bc_boolean_t bc__center_z;

void bc_executable_cli(void) {
  bc_cli_number("sxy", "size-xy", "size on x and y axes (diameter, millimeters)", &bc__size_xy, 1.0f);
  bc_cli_number("sz", "size-z", "size on z axis (length/height, millimeters)", &bc__size_z, 1.0f);
  bc_cli_flag("cxy", "center-xy", "center on x and y axes", &bc__center_xy);
  bc_cli_flag("cz", "center-z", "center on z axis", &bc__center_z);
}

static bc_argument_t bc__xy(
  bc_opcode_id_t axis
) {
  bc_argument_t position = bc_write_bc_nullary(BC_OPCODE_PARAMETER(axis));

  if (bc__center_xy) {
    return position;
  } else {
    return bc_write_bc_binary(BC_OPCODE_SUBTRACT, position, bc_argument_number_constant(bc__size_xy / 2.0f));
  }
}

static bc_argument_t bc__distance_xy(void) {
  bc_argument_t x = bc__xy(0);
  bc_argument_t xx = bc_write_bc_binary(BC_OPCODE_MULTIPLY, x, x);
  bc_argument_t y = bc__xy(1);
  bc_argument_t yy = bc_write_bc_binary(BC_OPCODE_MULTIPLY, y, y);
  bc_argument_t sum_xx_yy = bc_write_bc_binary(BC_OPCODE_ADD, xx, yy);
  bc_argument_t length = bc_write_bc_unary(BC_OPCODE_SQUARE_ROOT, sum_xx_yy);
  return bc_write_bc_binary(BC_OPCODE_SUBTRACT, length, bc_argument_number_constant(bc__size_xy / 2.0f));
}

static bc_argument_t bc__distance_z(void) {
  bc_argument_t position = bc_write_bc_nullary(BC_OPCODE_PARAMETER(2));
  bc_argument_t negative_distance, positive_distance;
  if (bc__center_z) {
    negative_distance = bc_write_bc_binary(BC_OPCODE_SUBTRACT, bc_argument_number_constant(bc__size_z / -2.0f), position);
    positive_distance = bc_write_bc_binary(BC_OPCODE_SUBTRACT, position, bc_argument_number_constant(bc__size_z / 2.0f));
  } else {
    negative_distance = bc_write_bc_unary(BC_OPCODE_NEGATE, position);
    positive_distance = bc_write_bc_binary(BC_OPCODE_SUBTRACT, position, bc_argument_number_constant(bc__size_z));
  }
  return bc_write_bc_binary(BC_OPCODE_MAXIMUM, negative_distance, positive_distance);
}

void bc_executable_before_first_file(void) {
  bc_argument_t distance_xy = bc__distance_xy();
  bc_argument_t distance_z = bc__distance_z();
  bc_argument_t distance_xy_positive = bc_write_bc_binary(BC_OPCODE_MAXIMUM, distance_xy, bc_argument_number_constant(0.0f));
  bc_argument_t distance_xy_positive_squared = bc_write_bc_binary(BC_OPCODE_MULTIPLY, distance_xy_positive, distance_xy_positive);
  bc_argument_t distance_z_positive = bc_write_bc_binary(BC_OPCODE_MAXIMUM, distance_z, bc_argument_number_constant(0.0f));
  bc_argument_t distance_z_positive_squared = bc_write_bc_binary(BC_OPCODE_MULTIPLY, distance_z_positive, distance_z_positive);
  bc_argument_t positive_distance_squared = bc_write_bc_binary(BC_OPCODE_ADD, distance_xy_positive_squared, distance_z_positive_squared);
  bc_argument_t positive_distance = bc_write_bc_unary(BC_OPCODE_SQUARE_ROOT, positive_distance_squared);
  bc_argument_t greatest_distance = bc_write_bc_binary(BC_OPCODE_MAXIMUM, distance_xy, distance_z);
  bc_argument_t negative_distance = bc_write_bc_binary(BC_OPCODE_MINIMUM, greatest_distance, bc_argument_number_constant(0.0f));

  bc_write_bc_binary(BC_OPCODE_ADD, positive_distance, negative_distance);
}

void bc_executable_nullary(
  bc_opcode_t opcode
) {
  BC_UNUSED(opcode);
}

void bc_executable_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
) {
  BC_UNUSED(opcode);
  BC_UNUSED(argument_a);
}

void bc_executable_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
) {
  BC_UNUSED(opcode);
  BC_UNUSED(argument_a);
  BC_UNUSED(argument_b);
}

void bc_executable_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
) {
  BC_UNUSED(opcode);
  BC_UNUSED(argument_a);
  BC_UNUSED(argument_b);
  BC_UNUSED(argument_c);
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
