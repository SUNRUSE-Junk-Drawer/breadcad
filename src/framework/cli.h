#ifndef SDF_CLI_H
#define SDF_CLI_H

void sdf_cli_flag(
  const char * short_name,
  const char * long_name,
  const char * description,
  sdf_boolean_t * pointer_to_result
);

void sdf_cli_number(
  const char * short_name,
  const char * long_name,
  const char * description,
  sdf_number_t * pointer_to_result,
  sdf_number_t default_value
);

void sdf_cli(int argc, char * argv[]);

void sdf_cli_read(void);

#endif
