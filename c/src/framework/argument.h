#ifndef BC_ARGUMENT_H
#define BC_ARGUMENT_H

#include "types.h"
#include "pointer.h"

typedef struct bc_argument_t {
  bc_pointer_t pointer;
  bc_number_t number_constant;
} bc_argument_t;

bc_argument_t bc_argument_pointer(
  bc_pointer_t pointer
);

bc_argument_t bc_argument_number_constant(
  bc_number_t number_constant
);

#endif
