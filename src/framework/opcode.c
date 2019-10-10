#include <stdio.h>
#include "primitive.h"
#include "opcode.h"

sdf_primitive_t sdf_opcode_result(
  sdf_opcode_t opcode
) {
  return opcode
    / SDF_PRIMITIVE_RANGE
    / SDF_PRIMITIVE_RANGE
    / SDF_PRIMITIVE_RANGE
    / SDF_OPCODE_ID_RANGE;
}

sdf_primitive_t sdf_opcode_parameter_a(
  sdf_opcode_t opcode
) {
  return (
      opcode
      - (
        sdf_opcode_result(opcode)
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_OPCODE_ID_RANGE
      )
    )
    / SDF_PRIMITIVE_RANGE
    / SDF_PRIMITIVE_RANGE
    / SDF_OPCODE_ID_RANGE;
}

sdf_primitive_t sdf_opcode_parameter_b(
  sdf_opcode_t opcode
) {
  return (
      opcode
      - (
        sdf_opcode_result(opcode)
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_OPCODE_ID_RANGE
      )
      - (
        sdf_opcode_parameter_a(opcode)
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_OPCODE_ID_RANGE
      )
    )
    / SDF_PRIMITIVE_RANGE
    / SDF_OPCODE_ID_RANGE;
}

sdf_primitive_t sdf_opcode_parameter_c(
  sdf_opcode_t opcode
) {
  return (
      opcode
      - (
        sdf_opcode_result(opcode)
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_OPCODE_ID_RANGE
      )
      - (
        sdf_opcode_parameter_a(opcode)
        * SDF_PRIMITIVE_RANGE
        * SDF_PRIMITIVE_RANGE
        * SDF_OPCODE_ID_RANGE
      )
      - (
        sdf_opcode_parameter_b(opcode)
        * SDF_PRIMITIVE_RANGE
        * SDF_OPCODE_ID_RANGE
      )
    )
    / SDF_OPCODE_ID_RANGE;
}

sdf_opcode_arity_t sdf_opcode_arity(
  sdf_opcode_t opcode
) {
  if (sdf_opcode_parameter_c(opcode)) {
    return 3;
  }

  if (sdf_opcode_parameter_b(opcode)) {
    return 2;
  }

  if (sdf_opcode_parameter_a(opcode)) {
    return 1;
  }

  return 0;
}

sdf_opcode_id_t sdf_opcode_id(
  sdf_opcode_t opcode
) {
  return opcode
    - (
      sdf_opcode_result(opcode)
      * SDF_PRIMITIVE_RANGE
      * SDF_PRIMITIVE_RANGE
      * SDF_PRIMITIVE_RANGE
      * SDF_OPCODE_ID_RANGE
    )
    - (
      sdf_opcode_parameter_a(opcode)
      * SDF_PRIMITIVE_RANGE
      * SDF_PRIMITIVE_RANGE
      * SDF_OPCODE_ID_RANGE
    )
    - (
      sdf_opcode_parameter_b(opcode)
      * SDF_PRIMITIVE_RANGE
      * SDF_OPCODE_ID_RANGE
    )
    - (
      sdf_opcode_parameter_c(opcode)
      * SDF_OPCODE_ID_RANGE
    );
}

void sdf_opcode_print(
  FILE * file,
  sdf_opcode_t opcode
) {
  if (opcode >= SDF_OPCODE_PARAMETER_MIN && opcode <= SDF_OPCODE_PARAMETER_MAX) {
    fprintf(file, "parameter %#04x", opcode - SDF_OPCODE_PARAMETER_MIN);
  } else {
    switch(opcode) {
      case SDF_OPCODE_NOT:
        fprintf(file, "not                   ");
        break;

      case SDF_OPCODE_AND:
        fprintf(file, "and                   ");
        break;

      case SDF_OPCODE_OR:
        fprintf(file, "or                    ");
        break;

      case SDF_OPCODE_EQUAL:
        fprintf(file, "equal                 ");
        break;

      case SDF_OPCODE_NOT_EQUAL:
        fprintf(file, "not equal             ");
        break;

      case SDF_OPCODE_CONDITIONAL_BOOLEAN:
        fprintf(file, "conditional boolean   ");
        break;

      case SDF_OPCODE_CONDITIONAL_NUMBER:
        fprintf(file, "conditional number    ");
        break;

      case SDF_OPCODE_GREATER_THAN:
        fprintf(file, "greater than          ");
        break;

      case SDF_OPCODE_NEGATE:
        fprintf(file, "negate                ");
        break;

      case SDF_OPCODE_SINE:
        fprintf(file, "sine                  ");
        break;

      case SDF_OPCODE_COSINE:
        fprintf(file, "cosine                ");
        break;

      case SDF_OPCODE_TANGENT:
        fprintf(file, "tangent               ");
        break;

      case SDF_OPCODE_ARC_SINE:
        fprintf(file, "arc sine              ");
        break;

      case SDF_OPCODE_ARC_COSINE:
        fprintf(file, "arc cosine            ");
        break;

      case SDF_OPCODE_ARC_TANGENT:
        fprintf(file, "arc tangent           ");
        break;

      case SDF_OPCODE_HYPERBOLIC_SINE:
        fprintf(file, "hyperbolic sine       ");
        break;

      case SDF_OPCODE_HYPERBOLIC_COSINE:
        fprintf(file, "hyperbolic cosine     ");
        break;

      case SDF_OPCODE_HYPERBOLIC_TANGENT:
        fprintf(file, "hyperbolic tangent    ");
        break;

      case SDF_OPCODE_HYPERBOLIC_ARC_SINE:
        fprintf(file, "hyperbolic arc sine   ");
        break;

      case SDF_OPCODE_HYPERBOLIC_ARC_COSINE:
        fprintf(file, "hyperbolic arc cosine ");
        break;

      case SDF_OPCODE_HYPERBOLIC_ARC_TANGENT:
        fprintf(file, "hyperbolic arc tangent");
        break;

      case SDF_OPCODE_ABSOLUTE:
        fprintf(file, "absolute              ");
        break;

      case SDF_OPCODE_SQUARE_ROOT:
        fprintf(file, "square root           ");
        break;

      case SDF_OPCODE_FLOOR:
        fprintf(file, "floor                 ");
        break;

      case SDF_OPCODE_CEILING:
        fprintf(file, "ceiling               ");
        break;

      case SDF_OPCODE_NATURAL_LOGARITHM:
        fprintf(file, "natural logarithm     ");
        break;

      case SDF_OPCODE_LOGARITHM_10:
        fprintf(file, "logarithm 10          ");
        break;

      case SDF_OPCODE_NATURAL_POWER:
        fprintf(file, "natural power         ");
        break;

      case SDF_OPCODE_ADD:
        fprintf(file, "add                   ");
        break;

      case SDF_OPCODE_SUBTRACT:
        fprintf(file, "subtract              ");
        break;

      case SDF_OPCODE_MULTIPLY:
        fprintf(file, "multiply              ");
        break;

      case SDF_OPCODE_DIVIDE:
        fprintf(file, "divide                ");
        break;

      case SDF_OPCODE_POW:
        fprintf(file, "pow                   ");
        break;

      case SDF_OPCODE_MODULO:
        fprintf(file, "modulo                ");
        break;

      case SDF_OPCODE_ARC_TANGENT_2:
        fprintf(file, "arc tangent 2         ");
        break;

      default:
        fprintf(file, "unknown (%#06x)      ", opcode);
        break;
    }
  }
}
