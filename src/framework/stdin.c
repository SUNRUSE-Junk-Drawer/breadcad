#ifdef _WIN32
#include <windows.h>
#endif

#include <unistd.h>
#include <stdio.h>
#include "fail.h"
#include "types.h"
#include "executable.h"
#include "opcode.h"
#include "read_bc.h"
#include "stdin.h"

void bc_stdin_check(void) {
  if (!bc_executable_reads_model_from_stdin) {
    #ifdef _WIN32
      switch (GetFileType(GetStdHandle(STD_INPUT_HANDLE))) {
        case FILE_TYPE_DISK:
          if (getc(stdin) != EOF) {
            bc_fail("unexpected stdin\n");
          }
          break;
        case FILE_TYPE_PIPE:
          break;
        default:
          bc_fail("unable to determine whether stdin is empty\n");
          break;
      }
    #else
      if (!isatty(STDIN_FILENO) && getc(stdin) != EOF) {
        bc_fail("unexpected stdin\n");
      }
    #endif
  }
}

void bc_stdin_read(void) {
  if (bc_executable_reads_model_from_stdin) {
    bc_read_bc(stdin);
  }
}
