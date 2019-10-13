#include "argument.h"
#include "types.h"
#include "pointer.h"

sdf_argument_t sdf_argument_pointer(
  sdf_pointer_t pointer
) {
  sdf_argument_t argument;
  argument.pointer = pointer;
  argument.float_constant = sdf_f32_not_a_number;
  return argument;
}

sdf_argument_t sdf_argument_float_constant(
  sdf_f32_t float_constant
) {
  sdf_argument_t argument;
  argument.pointer = SDF_POINTER_FLOAT_CONSTANT;
  argument.float_constant = float_constant;
  return argument;
}
