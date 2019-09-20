#include "types.h"
#include "executable.h"
#include "cli.h"
#include "stdin.h"

int main(int argc, char * argv[]) {
  sdf_types();
  sdf_cli(argc, argv);
  sdf_executable_before_first_file();
  sdf_stdin();
  sdf_executable_after_last_file();
  return 0;
}
