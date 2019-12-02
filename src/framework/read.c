#include <stdio.h>
#include <fcntl.h>
#include "fail.h"
#include "types.h"
#include "read.h"

void sdf_read_set_stdin_binary(void) {
  #ifdef _WIN32
    if (_setmode(_fileno(stdin), _O_BINARY) == -1) {
      sdf_fail("failed to set stdin to binary mode");
    }
  #endif
}

#define SDF_READ(type)                                              \
  sdf_boolean_t sdf_read_##type##_or_eof(                           \
    FILE * file,                                                    \
    const char * what,                                              \
    sdf_##type##_t * value                                          \
  ) {                                                               \
    size_t bytes = fread(value, 1, sizeof(sdf_##type##_t), file);   \
    if (bytes < sizeof(sdf_##type##_t)) {                           \
      if (!feof(file)) {                                            \
        sdf_fail(                                                   \
          "error reading %s (ferror: %d)\n",                        \
          what,                                                     \
          ferror(file)                                              \
        );                                                          \
        /* Required to satisfy compiler; will always exit above. */ \
        return SDF_BOOLEAN_FALSE;                                   \
      } else if (bytes) {                                           \
        sdf_fail("unexpected eof reading %s\n", what);              \
        /* Required to satisfy compiler; will always exit above. */ \
        return SDF_BOOLEAN_FALSE;                                   \
      } else {                                                      \
        return SDF_BOOLEAN_FALSE;                                   \
      }                                                             \
    } else if (bytes > sizeof(sdf_##type##_t)) {                    \
      /* I don't think this can happen. */                          \
      sdf_fail(                                                     \
        "error reading %s (ferror: %d, feof: %d)\n",                \
        what,                                                       \
        ferror(file) ,                                              \
        feof(file)                                                  \
      );                                                            \
      /* Required to satisfy compiler; will always exit above. */   \
      return SDF_BOOLEAN_FALSE;                                     \
    } else {                                                        \
      sdf_types_##type##_swap_endianness(value);                    \
      return SDF_BOOLEAN_TRUE;                                      \
    }                                                               \
  }                                                                 \
                                                                    \
  sdf_##type##_t sdf_read_##type(                                   \
    FILE * file,                                                    \
    const char * what                                               \
  ) {                                                               \
    sdf_##type##_t output;                                          \
    if (!sdf_read_##type##_or_eof(file, what, &output)) {           \
      sdf_fail("unexpected eof reading %s\n", what);                \
    }                                                               \
    return output;                                                  \
  }

SDF_READ(u16)
SDF_READ(number)
