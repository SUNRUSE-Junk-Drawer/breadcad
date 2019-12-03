#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/select.h>
#include "fail.h"
#include "types.h"
#include "executable.h"
#include "opcode.h"
#include "read_sdf.h"
#include "stdin.h"

static void sdf__stdin_check(void) {
  fd_set readfds;
  struct timeval timeout;

  FD_ZERO(&readfds);
  FD_SET(STDIN_FILENO, &readfds);

  timeout.tv_sec = 0;
  timeout.tv_usec = 0;

  switch (select(1, &readfds, NULL, NULL, &timeout)) {
    case 0:
      return;

    case -1:
      sdf_fail("failed to determine whether stdin is empty\n");
      return;

    default:
      if (getc(stdin) != EOF) {
        sdf_fail("unexpected stdin\n");
      }
      return;
  }
}

void sdf_stdin_check(void) {
  if (!sdf_executable_reads_model_from_stdin) {
    sdf__stdin_check();
  }
}

void sdf_stdin_read(void) {
  if (sdf_executable_reads_model_from_stdin) {
    sdf_read_sdf(stdin);
  }
}
