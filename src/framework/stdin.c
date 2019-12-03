#include <unistd.h>
#include <stdio.h>
#include "fail.h"
#include "types.h"
#include "executable.h"
#include "opcode.h"
#include "read_sdf.h"
#include "stdin.h"

void sdf_stdin_check(void) {
  if (!sdf_executable_reads_model_from_stdin) {
    /*if (!isatty(STDIN_FILENO) && getc(stdin) != EOF) {
      sdf_fail("unexpected stdin\n");
    }*/
  }
}

void sdf_stdin_read(void) {
  if (sdf_executable_reads_model_from_stdin) {
    sdf_read_sdf(stdin);
  }
}
