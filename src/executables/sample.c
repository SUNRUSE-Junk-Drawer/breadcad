#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/pointer.h"
#include "../framework/cli.h"
#include "../framework/executable.h"
#include "../framework/store.h"
#include "../framework/plan.h"
#include "../framework/execute.h"

const char * sdf_executable_name = "sample";
const char * sdf_executable_description = "sample a sdf stream at a single point in space";
const char * sdf_executable_usage_prefix = "[sdf stream] | ";
const char * sdf_executable_usage_suffix = "";
const sdf_boolean_t sdf_executable_reads_model_from_stdin = SDF_BOOLEAN_TRUE;

static sdf_f32_t sdf__x;
static sdf_f32_t sdf__y;
static sdf_f32_t sdf__z;

void sdf_executable_cli(void) {
  sdf_cli_float("x", "x", "location from which to sample on the x axis (millimeters)", &sdf__x, 0.0f);
  sdf_cli_float("y", "y", "location from which to sample on the y axis (millimeters)", &sdf__y, 0.0f);
  sdf_cli_float("z", "z", "location from which to sample on the z axis (millimeters)", &sdf__z, 0.0f);
}

void sdf_executable_before_first_file(void) {
}

void sdf_executable_nullary(
  sdf_opcode_t opcode
) {
  sdf_store_nullary(opcode);
}

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant
) {
  sdf_store_unary(
    opcode,
    argument_a_pointer,
    argument_a_float_constant
  );
}

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant
) {
  sdf_store_binary(
    opcode,
    argument_a_pointer,
    argument_a_float_constant,
    argument_b_pointer,
    argument_b_float_constant
  );
}

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t argument_a_pointer,
  sdf_f32_t argument_a_float_constant,
  sdf_pointer_t argument_b_pointer,
  sdf_f32_t argument_b_float_constant,
  sdf_pointer_t argument_c_pointer,
  sdf_f32_t argument_c_float_constant
) {
  sdf_store_ternary(
    opcode,
    argument_a_pointer,
    argument_a_float_constant,
    argument_b_pointer,
    argument_b_float_constant,
    argument_c_pointer,
    argument_c_float_constant
  );
}

void sdf_executable_eof(void) {
  sdf_plan();
  printf("%f\n", *sdf_execute(NULL, 1));
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
  switch (id) {
    case 0:
      return sdf__x;

    case 1:
      return sdf__y;

    case 2:
      return sdf__z;

    default:
      return 0.0f;
  }
}
