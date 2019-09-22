#ifndef SDF_MALLOC_H
#define SDF_MALLOC_H

void * sdf_malloc(
  size_t size,
  const char * action
);

#define SDF_MALLOC(type, quantity, action) \
  ((type * ) sdf_malloc((quantity) * sizeof(type), action))

void sdf_realloc(
  size_t size,
  const char * action,
  void ** pointer_to_pointer
);

#define SDF_REALLOC(type, quantity, action, pointer_to_pointer) \
  sdf_realloc((quantity) * sizeof(type), action, (void**) &(pointer_to_pointer))

#endif
