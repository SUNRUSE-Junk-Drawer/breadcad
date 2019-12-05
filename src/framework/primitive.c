#include <stdio.h>
#include "primitive.h"
#include "fail.h"

const char * sdf_primitive_name(
  sdf_primitive_t primitive
) {
  switch (primitive) {
    case SDF_PRIMITIVE_NONE:
      return "none";

    case SDF_PRIMITIVE_BOOLEAN:
      return "boolean";

    case SDF_PRIMITIVE_NUMBER:
      return "number";

    case SDF_PRIMITIVE_RESERVED:
      return "reserved";

    default:
      sdf_fail("unknown primitive %#04x", primitive);
      return NULL; /* Impossible, but required by compiler. */
  }
}

void sdf_primitive_print(
  FILE * file,
  sdf_primitive_t primitive
) {
  switch (primitive) {
    case SDF_PRIMITIVE_NONE:
      fprintf(file, "none          ");
      break;
    case SDF_PRIMITIVE_BOOLEAN:
      fprintf(file, "boolean       ");
      break;
    case SDF_PRIMITIVE_NUMBER:
      fprintf(file, "number        ");
      break;
    case SDF_PRIMITIVE_RESERVED:
      fprintf(file, "reserved      ");
      break;
    default:
      fprintf(file, "unknown (%#04x)", primitive);
      break;
  }
}
