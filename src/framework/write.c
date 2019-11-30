#include <stdio.h>
#include "fail.h"
#include "types.h"
#include "write.h"

#define SDF_WRITE(type)                                                    \
  void sdf_write_##type(                                                   \
    FILE * file,                                                           \
    sdf_##type##_t value,                                                  \
    const char * what                                                      \
  ) {                                                                      \
    sdf_##type##_t copy = value;                                           \
    sdf_types_##type##_swap_endianness(&copy);                             \
    if (!fwrite(&copy, sizeof(sdf_##type##_t), 1, file)) {                 \
      sdf_fail("failed to write %s (ferror: %d)\n", what, ferror(file));   \
    }                                                                      \
  }

SDF_WRITE(u16)
SDF_WRITE(number)
