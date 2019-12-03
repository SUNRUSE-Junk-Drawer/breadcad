#ifndef SDF_READ_H
#define SDF_READ_H

#include <stdio.h>
#include "types.h"

void sdf_read_set_stdin_binary(void);

#define SDF_READ_TYPE(type)               \
  sdf_boolean_t sdf_read_##type##_or_eof( \
    FILE * file,                          \
    const char * what,                    \
    sdf_##type##_t * value                \
  );                                      \
                                          \
  sdf_##type##_t sdf_read_##type(         \
    FILE * file,                          \
    const char * what                     \
  );

SDF_READ_TYPE(u16)
SDF_READ_TYPE(number)

#endif
