#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/argument.h"
#include "../framework/cli.h"
#include "../framework/write_sdf.h"
#include "../framework/executable.h"

const char * sdf_executable_name = "cuboid";
const char * sdf_executable_description = "generates a cuboid";
const char * sdf_executable_usage_prefix = "";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_FALSE;
const sdf_boolean_t sdf_executable_reads_models_from_command_line_arguments = SDF_BOOLEAN_FALSE;

static sdf_f32_t sdf__size_x;
static sdf_f32_t sdf__size_y;
static sdf_f32_t sdf__size_z;

static sdf_boolean_t sdf__center_x;
static sdf_boolean_t sdf__center_y;
static sdf_boolean_t sdf__center_z;

static void sdf__axis(
  char label,
  sdf_f32_t * size,
  sdf_boolean_t * center
) {
  sdf_boolean_t center_temp;

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

  sdf_cli_float(size_short_name, size_long_name, size_description, size, *size);

  sdf_cli_flag(center_short_name, center_long_name, center_description, &center_temp);
  *center = center_temp || *center;
}

void sdf_executable_cli(void) {
  sdf_cli_float("s", "size", "size on all axes (millimeters)", &sdf__size_z, 1.0f);

  sdf__size_x = sdf__size_y = sdf__size_z;

  sdf_cli_flag("c", "center", "center on all axes", &sdf__center_z);
  sdf__center_x = sdf__center_y = sdf__center_z;

  sdf__axis('x', &sdf__size_x, &sdf__center_x);
  sdf__axis('y', &sdf__size_y, &sdf__center_y);
  sdf__axis('z', &sdf__size_z, &sdf__center_z);
}

static sdf_argument_t sdf__generate_axis(
  sdf_opcode_id_t parameter,
  sdf_f32_t size,
  sdf_boolean_t center
) {
  sdf_argument_t position = sdf_write_sdf_nullary(SDF_OPCODE_PARAMETER(parameter));
  sdf_argument_t negative_distance, positive_distance;
  if (center) {
    negative_distance = sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, sdf_argument_float_constant(size / -2.0f), position);
    positive_distance = sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, position, sdf_argument_float_constant(size / 2.0f));
  } else {
    negative_distance = sdf_write_sdf_unary(SDF_OPCODE_NEGATE, position);
    positive_distance = sdf_write_sdf_binary(SDF_OPCODE_SUBTRACT, position, sdf_argument_float_constant(size));
  }
  return sdf_write_sdf_binary(SDF_OPCODE_MAX, negative_distance, positive_distance);
}

void sdf_executable_before_first_file(void) {
  sdf_argument_t x = sdf__generate_axis(0, sdf__size_x, sdf__center_x);
  sdf_argument_t y = sdf__generate_axis(1, sdf__size_y, sdf__center_y);
  sdf_argument_t max_x_y = sdf_write_sdf_binary(SDF_OPCODE_MAX, x, y);
  sdf_argument_t z = sdf__generate_axis(2, sdf__size_z, sdf__center_z);
  sdf_write_sdf_binary(SDF_OPCODE_MAX, max_x_y, z);
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
