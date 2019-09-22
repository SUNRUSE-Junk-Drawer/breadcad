#include <stdio.h>
#include "fail.h"
#include "types.h"
#include "executable.h"
#include "opcode.h"
#include "read_sdf.h"
#include "stdin.h"

void sdf_stdin(void) {
  if (!sdf_executable_reads_model_from_stdin) {
    if (getc(stdin) != EOF) {
      sdf_fail("unexpected stdin\n");
    }
    return;
  }

  sdf_read_sdf(stdin);
}
