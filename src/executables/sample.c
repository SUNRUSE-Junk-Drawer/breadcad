#define __USE_MINGW_ANSI_STDIO 1
#include <stdio.h>
#include "../framework/unused.h"
#include "../framework/types.h"
#include "../framework/opcode.h"
#include "../framework/argument.h"
#include "../framework/cli.h"
#include "../framework/executable.h"
#include "../framework/store.h"
#include "../framework/plan.h"
#include "../framework/execute.h"

const char * bc_executable_name = "sample";
const char * bc_executable_description = "sample a bc stream at a single point in space";
const char * bc_executable_usage_prefix = "[bc stream] | ";
const char * bc_executable_usage_suffix = "";
const bc_boolean_t bc_executable_reads_model_from_stdin = BC_BOOLEAN_TRUE;
const bc_boolean_t bc_executable_reads_models_from_command_line_arguments = BC_BOOLEAN_FALSE;

static bc_number_t bc__x;
static bc_number_t bc__y;
static bc_number_t bc__z;

void bc_executable_cli(void) {
  bc_cli_number("x", "x", "location from which to sample on the x axis (millimeters)", &bc__x, 0.0f);
  bc_cli_number("y", "y", "location from which to sample on the y axis (millimeters)", &bc__y, 0.0f);
  bc_cli_number("z", "z", "location from which to sample on the z axis (millimeters)", &bc__z, 0.0f);
}

void bc_executable_before_first_file(void) {
}

void bc_executable_nullary(
  bc_opcode_t opcode
) {
  bc_store_nullary(opcode);
}

void bc_executable_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
) {
  bc_store_unary(opcode, argument_a);
}

void bc_executable_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
) {
  bc_store_binary(opcode, argument_a, argument_b);
}

void bc_executable_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
) {
  bc_store_ternary(opcode, argument_a, argument_b, argument_c);
}

void bc_executable_eof(void) {
  bc_plan();
  printf("%f\n", *bc_execute(NULL, 1));
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
  switch (id) {
    case 0:
      return bc__x;

    case 1:
      return bc__y;

    case 2:
      return bc__z;

    default:
      return 0.0f;
  }
}
