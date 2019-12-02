#include "types.h"
#include "executable.h"
#include "read.h"
#include "write.h"
#include "cli.h"
#include "stdin.h"

int main(int argc, char * argv[]) {
  sdf_types();
  sdf_read_set_stdin_binary();
  sdf_write_set_stdout_binary();
  sdf_cli(argc, argv);
  sdf_stdin_check();
  sdf_executable_before_first_file();
  sdf_stdin_read();
  sdf_cli_read();
  sdf_executable_after_last_file();
  return 0;
}
