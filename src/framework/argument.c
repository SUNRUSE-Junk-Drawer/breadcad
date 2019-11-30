#include "argument.h"
#include "types.h"
#include "pointer.h"

sdf_argument_t sdf_argument_pointer(
  sdf_pointer_t pointer
) {
  sdf_argument_t argument;
  argument.pointer = pointer;
  argument.number_constant = sdf_number_not_a_number;
  return argument;
}

sdf_argument_t sdf_argument_number_constant(
  sdf_number_t number_constant
) {
  sdf_argument_t argument;
  argument.pointer = SDF_POINTER_NUMBER_CONSTANT;
  argument.number_constant = number_constant;
  return argument;
}
