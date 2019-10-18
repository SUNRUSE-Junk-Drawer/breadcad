#include <stdio.h>
#include "primitive.h"

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
