#ifndef BC_POINTER_H
#define BC_POINTER_H

#include "types.h"

typedef bc_u16_t bc_pointer_t;
#define BC_POINTER_MAX (BC_U16_MAX - 3)
#define BC_POINTER_RANGE (BC_U16_RANGE - 3)
#define BC_POINTER_BOOLEAN_CONSTANT_FALSE (BC_U16_MAX - 2)
#define BC_POINTER_BOOLEAN_CONSTANT_TRUE (BC_U16_MAX - 1)
#define BC_POINTER_NUMBER_CONSTANT BC_U16_MAX

#endif
