#include "argument.h"
#include "types.h"
#include "pointer.h"

bc_argument_t bc_argument_pointer(
  bc_pointer_t pointer
) {
  bc_argument_t argument;
  argument.pointer = pointer;
  argument.number_constant = bc_number_not_a_number;
  return argument;
}

bc_argument_t bc_argument_number_constant(
  bc_number_t number_constant
) {
  bc_argument_t argument;
  argument.pointer = BC_POINTER_NUMBER_CONSTANT;
  argument.number_constant = number_constant;
  return argument;
}
