#ifndef SDF_MALLOC_H
#define SDF_MALLOC_H

void * sdf_malloc(
  size_t size,
  const char * action
);

#define SDF_MALLOC(type, quantity, action) \
  ((type * ) sdf_malloc(quantity * sizeof(type), action))

#endif
