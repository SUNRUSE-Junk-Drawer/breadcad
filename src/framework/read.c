#include <stdio.h>
#include "fail.h"
#include "types.h"
#include "read.h"

#define SDF_READ(type)                                       \
  sdf_boolean_t sdf_read_##type##_or_eof(                    \
    FILE * file,                                             \
    const char * what,                                       \
    sdf_##type##_t * value                                   \
  ) {                                                        \
    switch (fread(value, sizeof(sdf_##type##_t), 1, file)) { \
      case 0:                                                \
        if (!feof(stdin)) {                                  \
          sdf_fail(                                          \
            "error reading %s (ferror: %d)\n",               \
            what,                                            \
            ferror(stdin)                                    \
          );                                                 \
        }                                                    \
        return SDF_BOOLEAN_FALSE;                            \
                                                             \
      case 1:                                                \
        sdf_types_##type##_swap_endianness(value);           \
        return SDF_BOOLEAN_TRUE;                             \
                                                             \
      /* I don't think this can happen. */                   \
      default:                                               \
        sdf_fail(                                            \
          "error reading %s (ferror: %d, feof: %d)\n",       \
          what,                                              \
          ferror(stdin),                                     \
          feof(stdin)                                        \
        );                                                   \
                                                             \
        /* Needed to satisfy compiler;             */        \
        /* exit(...) is always called before this. */        \
        return SDF_BOOLEAN_FALSE;                            \
    }                                                        \
  }                                                          \
                                                             \
  sdf_##type##_t sdf_read_##type(                            \
    FILE * file,                                             \
    const char * what                                        \
  ) {                                                        \
    sdf_##type##_t output;                                   \
    if (!sdf_read_##type##_or_eof(file, what, &output)) {    \
      sdf_fail("unexpected eof reading %s\n", what);         \
    }                                                        \
    return output;                                           \
  }

SDF_READ(u16)
SDF_READ(f32)
