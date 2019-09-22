#ifndef SDF_EXECUTABLE_H
#define SDF_EXECUTABLE_H

#include "types.h"
#include "opcode.h"
#include "pointer.h"

extern const char * sdf_executable_name;
extern const char * sdf_executable_description;
extern const char * sdf_executable_usage_prefix;
extern const char * sdf_executable_usage_suffix;
extern const sdf_boolean_t sdf_executable_reads_model_from_stdin;

void sdf_executable_cli(void);

void sdf_executable_before_first_file(void);

void sdf_executable_nullary(
  sdf_opcode_t opcode
);

void sdf_executable_unary(
  sdf_opcode_t opcode,
  sdf_pointer_t a
);

void sdf_executable_binary(
  sdf_opcode_t opcode,
  sdf_pointer_t a,
  sdf_pointer_t b
);

void sdf_executable_ternary(
  sdf_opcode_t opcode,
  sdf_pointer_t a,
  sdf_pointer_t b,
  sdf_pointer_t c
);

void sdf_executable_eof(void);

void sdf_executable_after_last_file(void);

sdf_f32_t sdf_executable_get_parameter(
  void * parameter_context,
  size_t iteration,
  sdf_opcode_id_t id
);

#endif
