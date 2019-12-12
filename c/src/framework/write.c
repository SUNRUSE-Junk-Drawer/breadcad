#include <stdio.h>
#include <fcntl.h>
#include "fail.h"
#include "types.h"
#include "write.h"

#ifdef _WIN32
  static bc_boolean_t bc__stdout_binary = BC_BOOLEAN_FALSE;
#endif

static void bc__set_stdout_binary(void) {
  #ifdef _WIN32
    if (bc__stdout_binary) {
      return;
    }

    if (_setmode(_fileno(stdout), _O_BINARY) == -1) {
      bc_fail("failed to set stdout to binary mode");
    }

    bc__stdout_binary = BC_BOOLEAN_TRUE;
  #endif
}

#define BC_WRITE(type)                                                    \
  void bc_write_##type(                                                   \
    bc_##type##_t value,                                                  \
    const char * what                                                      \
  ) {                                                                      \
    bc_##type##_t copy = value;                                           \
    bc_types_##type##_swap_endianness(&copy);                             \
    bc__set_stdout_binary();                                              \
    if (!fwrite(&copy, sizeof(bc_##type##_t), 1, stdout)) {               \
      bc_fail("failed to write %s (ferror: %d)\n", what, ferror(stdout)); \
    }                                                                      \
  }

BC_WRITE(u16)
BC_WRITE(number)
