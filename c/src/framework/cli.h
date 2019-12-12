#ifndef BC_CLI_H
#define BC_CLI_H

void bc_cli_flag(
  const char * short_name,
  const char * long_name,
  const char * description,
  bc_boolean_t * pointer_to_result
);

void bc_cli_number(
  const char * short_name,
  const char * long_name,
  const char * description,
  bc_number_t * pointer_to_result,
  bc_number_t default_value
);

void bc_cli(int argc, char * argv[]);

void bc_cli_read(void);

#endif
