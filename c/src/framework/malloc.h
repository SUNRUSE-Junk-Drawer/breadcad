#ifndef BC_MALLOC_H
#define BC_MALLOC_H

void * bc_malloc(
  size_t size,
  const char * action
);

#define BC_MALLOC(type, quantity, action) \
  ((type * ) bc_malloc((quantity) * sizeof(type), action))

void bc_realloc(
  size_t size,
  const char * action,
  void ** pointer_to_pointer
);

#define BC_REALLOC(type, quantity, action, pointer_to_pointer) \
  bc_realloc((quantity) * sizeof(type), action, (void**) &(pointer_to_pointer))

#endif
