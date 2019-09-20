#include <stdlib.h>
#include <stdio.h>
#include "executable.h"

void sdf_cli(int argc, char * argv[]) {
  printf("%s - %s\n", sdf_executable_name, sdf_executable_description);
  printf(
    "  usage: %s%s [options]%s\n",
    sdf_executable_usage_prefix,
    sdf_executable_name,
    sdf_executable_usage_suffix
  );
  sdf_executable_cli();
  exit(0);
}
