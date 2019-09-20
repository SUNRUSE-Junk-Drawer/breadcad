#include <stdlib.h>
#include "platform.h"
#include "types.h"
#include "fail.h"

void * sdf_malloc(
  size_t size,
  const char * action
) {
  void * allocated = malloc(size);
  if (!allocated) {
    sdf_fail(
      "failed to allocate %u bytes to %s" SDF_PLATFORM_LINE_BREAK,
      (unsigned long) size,
      action
    );
  }
  return allocated;
}
