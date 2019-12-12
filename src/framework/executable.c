#include "types.h"
#include "executable.h"
#include "read.h"
#include "write.h"
#include "cli.h"
#include "stdin.h"

int main(int argc, char * argv[]) {
  bc_types();
  bc_read_set_stdin_binary();
  bc_cli(argc, argv);
  bc_stdin_check();
  bc_executable_before_first_file();
  bc_stdin_read();
  bc_cli_read();
  bc_executable_after_last_file();
  return 0;
}
