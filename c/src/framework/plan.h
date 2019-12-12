#ifndef BC_PLAN_H
#define BC_PLAN_H

#include <stdlib.h>
#include "primitive.h"
#include "store.h"

extern size_t bc_plan_buffers;
extern bc_primitive_t * bc_plan_buffer_primitives;
extern size_t * bc_plan_result_buffers;
extern size_t * bc_plan_argument_buffers;

void bc_plan(void);

#endif
