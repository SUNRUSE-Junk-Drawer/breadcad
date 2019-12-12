#ifndef BC_READ_H
#define BC_READ_H

#include <stdio.h>
#include "types.h"

void bc_read_set_stdin_binary(void);

#define BC_READ_TYPE(type)               \
  bc_boolean_t bc_read_##type##_or_eof( \
    FILE * file,                          \
    const char * what,                    \
    bc_##type##_t * value                \
  );                                      \
                                          \
  bc_##type##_t bc_read_##type(         \
    FILE * file,                          \
    const char * what                     \
  );

BC_READ_TYPE(u16)
BC_READ_TYPE(number)

#endif
