#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/cli.h"

const char * sdf_executable_name = "sample";
const char * sdf_executable_description = "sample a sdf stream at a single point in space";
const char * sdf_executable_usage_prefix = "[sdf stream] | ";
const char * sdf_executable_usage_suffix = "";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_TRUE;

static sdf_f32_t sdf__x;
static sdf_f32_t sdf__y;
static sdf_f32_t sdf__z;

void sdf_executable_cli(void) {
  sdf_cli_float("x", "x", "location from which to sample (millimeters)", &sdf__x, 0.0f);
  sdf_cli_float("y", "y", "location from which to sample (millimeters)", &sdf__y, 0.0f);
  sdf_cli_float("z", "z", "location from which to sample (millimeters)", &sdf__z, 0.0f);
}

void sdf_executable_before_first_file(void) {
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t a
) {
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t a,
  sdf_pointer_t b
) {
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t a,
  sdf_pointer_t b,
  sdf_pointer_t c
) {
}

void sdf_executable_eof(
  sdf_opcode_t opcode
) {
}

void sdf_executable_after_last_file(void) {
}
