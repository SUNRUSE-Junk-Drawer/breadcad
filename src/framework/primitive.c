#include <stdio.h>
#include "primitive.h"
#include "fail.h"

const char * bc_primitive_name(
  bc_primitive_t primitive
) {
  switch (primitive) {
    case BC_PRIMITIVE_NONE:
      return "none";

    case BC_PRIMITIVE_BOOLEAN:
      return "boolean";

    case BC_PRIMITIVE_NUMBER:
      return "number";

    case BC_PRIMITIVE_RESERVED:
      return "reserved";

    default:
      bc_fail("unknown primitive %#04x", primitive);
      return NULL; /* Impossible, but required by compiler. */
  }
}

void bc_primitive_print(
  FILE * file,
  bc_primitive_t primitive
) {
  switch (primitive) {
    case BC_PRIMITIVE_NONE:
      fprintf(file, "none          ");
      break;
    case BC_PRIMITIVE_BOOLEAN:
      fprintf(file, "boolean       ");
      break;
    case BC_PRIMITIVE_NUMBER:
      fprintf(file, "number        ");
      break;
    case BC_PRIMITIVE_RESERVED:
      fprintf(file, "reserved      ");
      break;
    default:
      fprintf(file, "unknown (%#04x)", primitive);
      break;
  }
}
