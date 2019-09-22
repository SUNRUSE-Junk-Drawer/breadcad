#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/cli.h"
#include "../framework/executable.h"

const char * sdf_executable_name = "ellipsoid";
const char * sdf_executable_description = "generates an ellipsoid";
const char * sdf_executable_usage_prefix = "";
const char * sdf_executable_usage_suffix = " | [consumer of sdf stream]";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_FALSE;

static sdf_f32_t sdf__radius_x;
static sdf_f32_t sdf__radius_y;
static sdf_f32_t sdf__radius_z;

static sdf_boolean_t sdf__center_x;
static sdf_boolean_t sdf__center_y;
static sdf_boolean_t sdf__center_z;

static void sdf__axis(
  char label,
  sdf_f32_t * radius,
  sdf_boolean_t * center
) {
  sdf_f32_t diameter;
  sdf_boolean_t center_temp;

  char radius_short_name[] = { 'r', '\0', '\0' };
  char radius_long_name[] = { 'r', 'a', 'd', 'i', 'u', 's', '-', '\0', '\0' };
  char radius_description[] = { 'r', 'a', 'd', 'i', 'u', 's', ' ', 'o', 'n', ' ', '\0', ' ', 'a', 'x', 'i', 's', ' ', '(', 'm', 'i', 'l', 'l', 'i', 'm', 'e', 't', 'e', 'r', 's', ')', '\0' };
  char diameter_short_name[] = { 'd', '\0', '\0' };
  char diameter_long_name[] = { 'd', 'i', 'a', 'm', 'e', 't', 'e', 'r', '-', '\0', '\0' };
  char diameter_description[] = { 'd', 'i', 'a', 'm', 'e', 't', 'e', 'r', ' ', 'o', 'n', ' ', '\0', ' ', 'a', 'x', 'i', 's', ' ', '(', 'm', 'i', 'l', 'l', 'i', 'm', 'e', 't', 'e', 'r', 's', ')', '\0' };
  char center_short_name[] = { 'c', '\0', '\0' };
  char center_long_name[] = { 'c', 'e', 'n', 't', 'e', 'r', '-', '\0', '\0' };
  char center_description[] = { 'c', 'e', 'n', 't', 'e', 'r', ' ', 'o', 'n', ' ', '\0', ' ', 'a', 'x', 'i', 's', ' ', '(', 'm', 'i', 'l', 'l', 'i', 'm', 'e', 't', 'e', 'r', 's', ')', '\0' };

  radius_short_name[1] = label;
  radius_long_name[7] = label;
  radius_description[10] = label;
  diameter_short_name[1] = label;
  diameter_long_name[9] = label;
  diameter_description[12] = label;
  center_short_name[1] = label;
  center_long_name[7] = label;
  center_description[10] = label;

  sdf_cli_float(radius_short_name, radius_long_name, radius_description, radius, *radius);

  sdf_cli_float(diameter_short_name, diameter_long_name, diameter_description, &diameter, 0.0f);
  if (diameter) {
    *radius = diameter / 2;
  }

  sdf_cli_flag(center_short_name, center_long_name, center_description, &center_temp);
  *center = center_temp || *center;
}

void sdf_executable_cli(void) {
  sdf_f32_t diameter;

  sdf_cli_float("r", "radius", "radius on all axes (millimeters)", &sdf__radius_z, 1.0f);

  sdf_cli_float("d", "diameter", "radius on all axes (millimeters)", &diameter, 0.0f);
  if (diameter) {
    sdf__radius_z = diameter / 2;
  }

  sdf__radius_x = sdf__radius_y = sdf__radius_z;

  sdf_cli_flag("c", "center", "center on all axes", &sdf__center_z);
  sdf__center_x = sdf__center_y = sdf__center_z;

  sdf__axis('x', &sdf__radius_x, &sdf__center_x);
  sdf__axis('y', &sdf__radius_y, &sdf__center_y);
  sdf__axis('z', &sdf__radius_z, &sdf__center_z);
}

void sdf_executable_before_first_file(void) {
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
  SDF_UNUSED(opcode);
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t a
) {
  SDF_UNUSED(opcode);
  SDF_UNUSED(a);
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t a,
  sdf_pointer_t b
) {
  SDF_UNUSED(opcode);
  SDF_UNUSED(a);
  SDF_UNUSED(b);
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t a,
  sdf_pointer_t b,
  sdf_pointer_t c
) {
  SDF_UNUSED(opcode);
  SDF_UNUSED(a);
  SDF_UNUSED(b);
  SDF_UNUSED(c);
}

void sdf_executable_eof(void) {
}

void sdf_executable_after_last_file(void) {
}
