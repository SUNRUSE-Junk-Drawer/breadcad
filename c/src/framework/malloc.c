#include <stdlib.h>
#include "types.h"
#include "fail.h"
#include "malloc.h"

void * bc_malloc(
  size_t size,
  const char * action
) {
  if (size) {
    void * allocated = malloc(size);
    if (!allocated) {
      bc_fail(
        "failed to allocate %u bytes to %s\n",
        (unsigned long) size,
        action
      );
    }
    return allocated;
  } else {
    return NULL;
  }
}

void bc_realloc(
  size_t size,
  const char * action,
  void ** pointer_to_pointer
) {
  void * resized;
  if (size) {
    if (*pointer_to_pointer) {
      resized = realloc(*pointer_to_pointer, size);
      if (!resized) {
        bc_fail(
          "failed to reallocate %u bytes to %s\n",
          (unsigned long) size,
          action
        );
      }
      *pointer_to_pointer = resized;
    } else {
      *pointer_to_pointer = bc_malloc(size, action);
    }
  } else {
    if (*pointer_to_pointer) {
      free(*pointer_to_pointer);
      *pointer_to_pointer = NULL;
    }
  }
}
