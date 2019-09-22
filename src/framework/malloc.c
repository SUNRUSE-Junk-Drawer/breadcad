#include <stdlib.h>
#include "types.h"
#include "fail.h"

void * sdf_malloc(
  size_t size,
  const char * action
) {
  if (size) {
  void * allocated = malloc(size);
  if (!allocated) {
    sdf_fail(
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
