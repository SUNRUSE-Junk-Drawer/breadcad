#ifndef BC_PRIMITIVE_H
#define BC_PRIMITIVE_H

#include <stdio.h>
#include "types.h"

typedef bc_u8_t bc_primitive_t;

#define BC_PRIMITIVE_NONE 0
#define BC_PRIMITIVE_BOOLEAN 1
#define BC_PRIMITIVE_NUMBER 2
#define BC_PRIMITIVE_RESERVED 3
#define BC_PRIMITIVE_MAX 3
#define BC_PRIMITIVE_RANGE (BC_PRIMITIVE_MAX + 1)

const char * bc_primitive_name(
  bc_primitive_t primitive
);

void bc_primitive_print(
  FILE * file,
  bc_primitive_t primitive
);

#endif
