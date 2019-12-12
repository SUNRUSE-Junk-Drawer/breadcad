#ifndef BC_WRITE_H
#define BC_WRITE_H

#include <stdio.h>
#include "types.h"

#define BC_WRITE_TYPE(type) \
  void bc_write_##type(     \
    bc_##type##_t type,     \
    const char * what        \
  );

BC_WRITE_TYPE(u16)
BC_WRITE_TYPE(number)

#endif
