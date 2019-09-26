#ifndef SDF_PLAN_H
#define SDF_PLAN_H

#include <stdlib.h>
#include "primitive.h"
#include "store.h"

extern size_t sdf_plan_buffers;
extern sdf_primitive_t * sdf_plan_buffer_primitives;
extern size_t * sdf_plan_result_buffers;
extern size_t * sdf_plan_argument_buffers;

void sdf_plan(void);

#endif
