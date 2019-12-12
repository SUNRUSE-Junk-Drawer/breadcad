#ifndef BC_EXECUTABLE_H
#define BC_EXECUTABLE_H

#include "types.h"
#include "opcode.h"
#include "argument.h"

extern const char * bc_executable_name;
extern const char * bc_executable_description;
extern const char * bc_executable_usage_prefix;
extern const char * bc_executable_usage_suffix;
extern const bc_boolean_t bc_executable_reads_model_from_stdin;
extern const bc_boolean_t bc_executable_reads_models_from_command_line_arguments;

void bc_executable_cli(void);

void bc_executable_before_first_file(void);

void bc_executable_nullary(
  bc_opcode_t opcode
);

void bc_executable_unary(
  bc_opcode_t opcode,
  bc_argument_t argument_a
);

void bc_executable_binary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b
);

void bc_executable_ternary(
  bc_opcode_t opcode,
  bc_argument_t argument_a,
  bc_argument_t argument_b,
  bc_argument_t argument_c
);

void bc_executable_eof(void);

void bc_executable_after_last_file(void);

bc_number_t bc_executable_get_parameter(
  void * parameter_context,
  size_t iteration,
  bc_opcode_id_t id
);

#endif
