#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/argument.h"
#include "../framework/cli.h"
#include "../framework/write_bc.h"
#include "../framework/executable.h"

const char * bc_executable_name = "cuboid";
const char * bc_executable_description = "generates a cuboid";
const char * bc_executable_usage_prefix = "";
const char * bc_executable_usage_suffix = " | [consumer of bc stream]";
const bc_boolean_t bc_executable_reads_model_from_stdin = BC_BOOLEAN_FALSE;
const bc_boolean_t bc_executable_reads_models_from_command_line_arguments = BC_BOOLEAN_FALSE;

static bc_number_t bc__size_x;
static bc_number_t bc__size_y;
static bc_number_t bc__size_z;

static bc_boolean_t bc__center_x;
static bc_boolean_t bc__center_y;
static bc_boolean_t bc__center_z;

static void bc__axis(
  char label,
  bc_number_t * size,
  bc_boolean_t * center
) {
  bc_boolean_t center_temp;

  char size_short_name[] = { 's', '\0', '\0' };
  char size_long_name[] = { 's', 'i', 'z', 'e', '-', '\0', '\0' };
  char size_description[] = { 's', 'i', 'z', 'e', ' ', 'o', 'n', ' ', '\0', ' ', 'a', 'x', 'i', 's', ' ', '(', 'm', 'i', 'l', 'l', 'i', 'm', 'e', 't', 'e', 'r', 's', ')', '\0' };
  char center_short_name[] = { 'c', '\0', '\0' };
  char center_long_name[] = { 'c', 'e', 'n', 't', 'e', 'r', '-', '\0', '\0' };
  char center_description[] = { 'c', 'e', 'n', 't', 'e', 'r', ' ', 'o', 'n', ' ', '\0', ' ', 'a', 'x', 'i', 's', ' ', '(', 'm', 'i', 'l', 'l', 'i', 'm', 'e', 't', 'e', 'r', 's', ')', '\0' };

  size_short_name[1] = label;
  size_long_name[5] = label;
  size_description[8] = label;
  center_short_name[1] = label;
  center_long_name[7] = label;
  center_description[10] = label;

  bc_cli_number(size_short_name, size_long_name, size_description, size, *size);

  bc_cli_flag(center_short_name, center_long_name, center_description, &center_temp);
  *center = center_temp || *center;
}

void bc_executable_cli(void) {
  bc_cli_number("s", "size", "size on all axes (millimeters)", &bc__size_z, 1.0f);

  bc__size_x = bc__size_y = bc__size_z;

  bc_cli_flag("c", "center", "center on all axes", &bc__center_z);
  bc__center_x = bc__center_y = bc__center_z;

  bc__axis('x', &bc__size_x, &bc__center_x);
  bc__axis('y', &bc__size_y, &bc__center_y);
  bc__axis('z', &bc__size_z, &bc__center_z);
}

static bc_argument_t bc__generate_axis(
  bc_opcode_id_t parameter,
  bc_number_t size,
  bc_boolean_t center
) {
  bc_argument_t position = bc_write_bc_nullary(BC_OPCODE_PARAMETER(parameter));
  bc_argument_t negative_distance, positive_distance;
  if (center) {
    negative_distance = bc_write_bc_binary(BC_OPCODE_SUBTRACT, bc_argument_number_constant(size / -2.0f), position);
    positive_distance = bc_write_bc_binary(BC_OPCODE_SUBTRACT, position, bc_argument_number_constant(size / 2.0f));
  } else {
    negative_distance = bc_write_bc_unary(BC_OPCODE_NEGATE, position);
    positive_distance = bc_write_bc_binary(BC_OPCODE_SUBTRACT, position, bc_argument_number_constant(size));
  }
  return bc_write_bc_binary(BC_OPCODE_MAXIMUM, negative_distance, positive_distance);
}

void bc_executable_before_first_file(void) {
  bc_argument_t x = bc__generate_axis(0, bc__size_x, bc__center_x);
  bc_argument_t y = bc__generate_axis(1, bc__size_y, bc__center_y);
  bc_argument_t z = bc__generate_axis(2, bc__size_z, bc__center_z);

  bc_argument_t x_positive = bc_write_bc_binary(BC_OPCODE_MAXIMUM, x, bc_argument_number_constant(0.0f));
  bc_argument_t x_positive_squared = bc_write_bc_binary(BC_OPCODE_MULTIPLY, x_positive, x_positive);
  bc_argument_t y_positive = bc_write_bc_binary(BC_OPCODE_MAXIMUM, y, bc_argument_number_constant(0.0f));
  bc_argument_t y_positive_squared = bc_write_bc_binary(BC_OPCODE_MULTIPLY, y_positive, y_positive);
  bc_argument_t z_positive = bc_write_bc_binary(BC_OPCODE_MAXIMUM, z, bc_argument_number_constant(0.0f));
  bc_argument_t z_positive_squared = bc_write_bc_binary(BC_OPCODE_MULTIPLY, z_positive, z_positive);
  bc_argument_t xy_positive_squared = bc_write_bc_binary(BC_OPCODE_ADD, x_positive_squared, y_positive_squared);
  bc_argument_t positive_squared = bc_write_bc_binary(BC_OPCODE_ADD, xy_positive_squared, z_positive_squared);
  bc_argument_t positive = bc_write_bc_unary(BC_OPCODE_SQUARE_ROOT, positive_squared);

  bc_argument_t xy_greatest = bc_write_bc_binary(BC_OPCODE_MAXIMUM, x, y);
  bc_argument_t greatest = bc_write_bc_binary(BC_OPCODE_MAXIMUM, xy_greatest, z);
  bc_argument_t negative = bc_write_bc_binary(BC_OPCODE_MINIMUM, greatest, bc_argument_number_constant(0.0f));

  bc_write_bc_binary(BC_OPCODE_ADD, positive, negative);
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
