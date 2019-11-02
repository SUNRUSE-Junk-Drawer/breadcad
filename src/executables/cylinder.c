#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/argument.h"
#include "../framework/cli.h"
#include "../framework/write_sdf.h"
#include "../framework/executable.h"

const char * sdf_executable_name = "cylinder";
const char * sdf_executable_description = "generates a cylinder along the z axis";
const char * sdf_executable_usage_prefix = "";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_FALSE;
const sdf_boolean_t sdf_executable_reads_models_from_command_line_arguments = SDF_BOOLEAN_FALSE;

static sdf_number_t sdf__size_xy;
static sdf_number_t sdf__size_z;

static sdf_boolean_t sdf__center_xy;
static sdf_boolean_t sdf__center_z;

void sdf_executable_cli(void) {
  sdf_cli_number("sxy", "size-xy", "size on x and y axes (diameter, millimeters)", &sdf__size_xy, 1.0f);
  sdf_cli_number("sz", "size-z", "size on z axis (length/height, millimeters)", &sdf__size_z, 1.0f);
  sdf_cli_flag("cxy", "center-xy", "center on x and y axes", &sdf__center_xy);
  sdf_cli_flag("cz", "center-z", "center on z axis", &sdf__center_z);
}

static sdf_argument_t sdf__xy(
  sdf_opcode_id_t axis
) {
  sdf_argument_t position = sdf_write_sdf_nullary(SDF_OPCODE_PARAMETER(axis));

  if (sdf__center_xy) {
    return position;
  } else {
    return sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, position, sdf_argument_number_constant(sdf__size_xy / 2.0f));
  }
}

static sdf_argument_t sdf__distance_xy(void) {
  sdf_argument_t x = sdf__xy(0);
  sdf_argument_t xx = sdf_write_sdf_binary(SDF_OPCODE_MULTIPLY, x, x);
  sdf_argument_t y = sdf__xy(1);
  sdf_argument_t yy = sdf_write_sdf_binary(SDF_OPCODE_MULTIPLY, y, y);
  sdf_argument_t sum_xx_yy = sdf_write_sdf_binary(SDF_OPCODE_ADD, xx, yy);
  sdf_argument_t length = sdf_write_sdf_unary(SDF_OPCODE_SQUARE_ROOT, sum_xx_yy);
  return sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, length, sdf_argument_number_constant(sdf__size_xy / 2.0f));
}

static sdf_argument_t sdf__distance_z(void) {
  sdf_argument_t position = sdf_write_sdf_nullary(SDF_OPCODE_PARAMETER(2));
  sdf_argument_t negative_distance, positive_distance;
  if (sdf__center_z) {
    negative_distance = sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, sdf_argument_number_constant(sdf__size_z / -2.0f), position);
    positive_distance = sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, position, sdf_argument_number_constant(sdf__size_z / 2.0f));
  } else {
    negative_distance = sdf_write_sdf_unary(SDF_OPCODE_NEGATE, position);
    positive_distance = sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, position, sdf_argument_number_constant(sdf__size_z));
  }
  return sdf_write_sdf_binary(SDF_OPCODE_MAXIMUM, negative_distance, positive_distance);
}

void sdf_executable_before_first_file(void) {
  sdf_argument_t distance_xy = sdf__distance_xy();
  sdf_argument_t distance_z = sdf__distance_z();
  sdf_argument_t distance_xy_positive = sdf_write_sdf_binary(SDF_OPCODE_MAXIMUM, distance_xy, sdf_argument_number_constant(0.0f));
  sdf_argument_t distance_xy_positive_squared = sdf_write_sdf_binary(SDF_OPCODE_MULTIPLY, distance_xy_positive, distance_xy_positive);
  sdf_argument_t distance_z_positive = sdf_write_sdf_binary(SDF_OPCODE_MAXIMUM, distance_z, sdf_argument_number_constant(0.0f));
  sdf_argument_t distance_z_positive_squared = sdf_write_sdf_binary(SDF_OPCODE_MULTIPLY, distance_z_positive, distance_z_positive);
  sdf_argument_t positive_distance_squared = sdf_write_sdf_binary(SDF_OPCODE_ADD, distance_xy_positive_squared, distance_z_positive_squared);
  sdf_argument_t positive_distance = sdf_write_sdf_unary(SDF_OPCODE_SQUARE_ROOT, positive_distance_squared);
  sdf_argument_t greatest_distance = sdf_write_sdf_binary(SDF_OPCODE_MAXIMUM, distance_xy, distance_z);
  sdf_argument_t negative_distance = sdf_write_sdf_binary(SDF_OPCODE_MIN, greatest_distance, sdf_argument_number_constant(0.0f));

  sdf_write_sdf_binary(SDF_OPCODE_ADD, positive_distance, negative_distance);
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
  SDF_UNUSED(opcode);
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a
) {
  SDF_UNUSED(opcode);
  SDF_UNUSED(argument_a);
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b
) {
  SDF_UNUSED(opcode);
  SDF_UNUSED(argument_a);
  SDF_UNUSED(argument_b);
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_argument_t argument_a,
  sdf_argument_t argument_b,
  sdf_argument_t argument_c
) {
  SDF_UNUSED(opcode);
  SDF_UNUSED(argument_a);
  SDF_UNUSED(argument_b);
  SDF_UNUSED(argument_c);
}

void sdf_executable_eof(void) {
}

void sdf_executable_after_last_file(void) {
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
