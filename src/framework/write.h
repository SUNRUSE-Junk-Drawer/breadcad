#ifndef SDF_WRITE_H
#define SDF_WRITE_H

#include <stdio.h>
#include "types.h"

void sdf_write_set_stdout_binary(void);

#define SDF_WRITE_TYPE(type) \
  void sdf_write_##type(     \
    sdf_##type##_t type,     \
    const char * what        \
  );

SDF_WRITE_TYPE(u16)
SDF_WRITE_TYPE(number)

#endif
