#include <stdio.h>
#include <fcntl.h>
#include "fail.h"
#include "types.h"
#include "read.h"

void bc_read_set_stdin_binary(void) {
  #ifdef _WIN32
    if (_setmode(_fileno(stdin), _O_BINARY) == -1) {
      bc_fail("failed to set stdin to binary mode");
    }
  #endif
}

#define BC_READ(type)                                              \
  bc_boolean_t bc_read_##type##_or_eof(                           \
    FILE * file,                                                    \
    const char * what,                                              \
    bc_##type##_t * value                                          \
  ) {                                                               \
    size_t bytes = fread(value, 1, sizeof(bc_##type##_t), file);   \
    if (bytes < sizeof(bc_##type##_t)) {                           \
      if (!feof(file)) {                                            \
        bc_fail(                                                   \
          "error reading %s (ferror: %d)\n",                        \
          what,                                                     \
          ferror(file)                                              \
        );                                                          \
        /* Required to satisfy compiler; will always exit above. */ \
        return BC_BOOLEAN_FALSE;                                   \
      } else if (bytes) {                                           \
        bc_fail("unexpected eof reading %s\n", what);              \
        /* Required to satisfy compiler; will always exit above. */ \
        return BC_BOOLEAN_FALSE;                                   \
      } else {                                                      \
        return BC_BOOLEAN_FALSE;                                   \
      }                                                             \
    } else if (bytes > sizeof(bc_##type##_t)) {                    \
      /* I don't think this can happen. */                          \
      bc_fail(                                                     \
        "error reading %s (ferror: %d, feof: %d)\n",                \
        what,                                                       \
        ferror(file) ,                                              \
        feof(file)                                                  \
      );                                                            \
      /* Required to satisfy compiler; will always exit above. */   \
      return BC_BOOLEAN_FALSE;                                     \
    } else {                                                        \
      bc_types_##type##_swap_endianness(value);                    \
      return BC_BOOLEAN_TRUE;                                      \
    }                                                               \
  }                                                                 \
                                                                    \
  bc_##type##_t bc_read_##type(                                   \
    FILE * file,                                                    \
    const char * what                                               \
  ) {                                                               \
    bc_##type##_t output;                                          \
    if (!bc_read_##type##_or_eof(file, what, &output)) {           \
      bc_fail("unexpected eof reading %s\n", what);                \
    }                                                               \
    return output;                                                  \
  }

BC_READ(u16)
BC_READ(number)
