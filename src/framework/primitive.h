#ifndef SDF_PRIMITIVE_H
#define SDF_PRIMITIVE_H

#include <stdio.h>
#include "types.h"

typedef sdf_u8_t sdf_primitive_t;

#define SDF_PRIMITIVE_NONE 0
#define SDF_PRIMITIVE_BOOLEAN 1
#define SDF_PRIMITIVE_NUMBER 2
#define SDF_PRIMITIVE_RESERVED 3
#define SDF_PRIMITIVE_MAX 3
#define SDF_PRIMITIVE_RANGE (SDF_PRIMITIVE_MAX + 1)

const char * sdf_primitive_name(
  sdf_primitive_t primitive
);

void sdf_primitive_print(
  FILE * file,
  sdf_primitive_t primitive
);

#endif
