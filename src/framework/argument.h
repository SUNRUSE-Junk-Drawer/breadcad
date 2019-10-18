#ifndef SDF_ARGUMENT_H
#define SDF_ARGUMENT_H

#include "types.h"
#include "pointer.h"

typedef struct sdf_argument_t {
  sdf_pointer_t pointer;
  sdf_f32_t float_constant;
} sdf_argument_t;

sdf_argument_t sdf_argument_pointer(
  sdf_pointer_t pointer
);

sdf_argument_t sdf_argument_float_constant(
  sdf_f32_t float_constant
);

#endif
