#ifdef _WIN32
#include <windows.h>
#endif

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
    #ifdef _WIN32
      switch (GetFileType(GetStdHandle(STD_INPUT_HANDLE))) {
        case FILE_TYPE_PIPE:
        case FILE_TYPE_DISK:
          if (getc(stdin) != EOF) {
            sdf_fail("unexpected stdin\n");
          }
          break;

        case FILE_TYPE_CHAR:
          break;

        default:
          sdf_fail("unable to determine whether stdin is empty %d\n", GetFileType(GetStdHandle(STD_INPUT_HANDLE)));
          break;
      }
    #else
      if (!isatty(STDIN_FILENO) && getc(stdin) != EOF) {
        sdf_fail("unexpected stdin\n");
      }
    #endif
  }
}

void sdf_stdin_read(void) {
  if (sdf_executable_reads_model_from_stdin) {
    sdf_read_sdf(stdin);
  }
}
