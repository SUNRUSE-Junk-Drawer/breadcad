#include <stdio.h>
#include "primitive.h"
#include "opcode.h"

bc_primitive_t bc_opcode_result(
  bc_opcode_t opcode
) {
  return opcode
    / BC_PRIMITIVE_RANGE
    / BC_PRIMITIVE_RANGE
    / BC_PRIMITIVE_RANGE
    / BC_OPCODE_ID_RANGE;
}

bc_primitive_t bc_opcode_parameter_a(
  bc_opcode_t opcode
) {
  return (
      opcode
      - (
        bc_opcode_result(opcode)
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_OPCODE_ID_RANGE
      )
    )
    / BC_PRIMITIVE_RANGE
    / BC_PRIMITIVE_RANGE
    / BC_OPCODE_ID_RANGE;
}

bc_primitive_t bc_opcode_parameter_b(
  bc_opcode_t opcode
) {
  return (
      opcode
      - (
        bc_opcode_result(opcode)
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_OPCODE_ID_RANGE
      )
      - (
        bc_opcode_parameter_a(opcode)
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_OPCODE_ID_RANGE
      )
    )
    / BC_PRIMITIVE_RANGE
    / BC_OPCODE_ID_RANGE;
}

bc_primitive_t bc_opcode_parameter_c(
  bc_opcode_t opcode
) {
  return (
      opcode
      - (
        bc_opcode_result(opcode)
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_OPCODE_ID_RANGE
      )
      - (
        bc_opcode_parameter_a(opcode)
        * BC_PRIMITIVE_RANGE
        * BC_PRIMITIVE_RANGE
        * BC_OPCODE_ID_RANGE
      )
      - (
        bc_opcode_parameter_b(opcode)
        * BC_PRIMITIVE_RANGE
        * BC_OPCODE_ID_RANGE
      )
    )
    / BC_OPCODE_ID_RANGE;
}

bc_opcode_arity_t bc_opcode_arity(
  bc_opcode_t opcode
) {
  if (bc_opcode_parameter_c(opcode)) {
    return 3;
  }

  if (bc_opcode_parameter_b(opcode)) {
    return 2;
  }

  if (bc_opcode_parameter_a(opcode)) {
    return 1;
  }

  return 0;
}

bc_opcode_id_t bc_opcode_id(
  bc_opcode_t opcode
) {
  return opcode
    - (
      bc_opcode_result(opcode)
      * BC_PRIMITIVE_RANGE
      * BC_PRIMITIVE_RANGE
      * BC_PRIMITIVE_RANGE
      * BC_OPCODE_ID_RANGE
    )
    - (
      bc_opcode_parameter_a(opcode)
      * BC_PRIMITIVE_RANGE
      * BC_PRIMITIVE_RANGE
      * BC_OPCODE_ID_RANGE
    )
    - (
      bc_opcode_parameter_b(opcode)
      * BC_PRIMITIVE_RANGE
      * BC_OPCODE_ID_RANGE
    )
    - (
      bc_opcode_parameter_c(opcode)
      * BC_OPCODE_ID_RANGE
    );
}

void bc_opcode_print(
  FILE * file,
  bc_opcode_t opcode
) {
  if (opcode >= BC_OPCODE_PARAMETER_MIN && opcode <= BC_OPCODE_PARAMETER_MAX) {
    fprintf(file, "parameter %#04x", opcode - BC_OPCODE_PARAMETER_MIN);
  } else {
    switch(opcode) {
      case BC_OPCODE_NOT:
        fprintf(file, "not                   ");
        break;

      case BC_OPCODE_AND:
        fprintf(file, "and                   ");
        break;

      case BC_OPCODE_OR:
        fprintf(file, "or                    ");
        break;

      case BC_OPCODE_EQUAL:
        fprintf(file, "equal                 ");
        break;

      case BC_OPCODE_NOT_EQUAL:
        fprintf(file, "not equal             ");
        break;

      case BC_OPCODE_CONDITIONAL_BOOLEAN:
        fprintf(file, "conditional boolean   ");
        break;

      case BC_OPCODE_CONDITIONAL_NUMBER:
        fprintf(file, "conditional number    ");
        break;

      case BC_OPCODE_GREATER_THAN:
        fprintf(file, "greater than          ");
        break;

      case BC_OPCODE_NEGATE:
        fprintf(file, "negate                ");
        break;

      case BC_OPCODE_SINE:
        fprintf(file, "sine                  ");
        break;

      case BC_OPCODE_COSINE:
        fprintf(file, "cosine                ");
        break;

      case BC_OPCODE_TANGENT:
        fprintf(file, "tangent               ");
        break;

      case BC_OPCODE_ARC_SINE:
        fprintf(file, "arc sine              ");
        break;

      case BC_OPCODE_ARC_COSINE:
        fprintf(file, "arc cosine            ");
        break;

      case BC_OPCODE_ARC_TANGENT:
        fprintf(file, "arc tangent           ");
        break;

      case BC_OPCODE_HYPERBOLIC_SINE:
        fprintf(file, "hyperbolic sine       ");
        break;

      case BC_OPCODE_HYPERBOLIC_COSINE:
        fprintf(file, "hyperbolic cosine     ");
        break;

      case BC_OPCODE_HYPERBOLIC_TANGENT:
        fprintf(file, "hyperbolic tangent    ");
        break;

      case BC_OPCODE_HYPERBOLIC_ARC_SINE:
        fprintf(file, "hyperbolic arc sine   ");
        break;

      case BC_OPCODE_HYPERBOLIC_ARC_COSINE:
        fprintf(file, "hyperbolic arc cosine ");
        break;

      case BC_OPCODE_HYPERBOLIC_ARC_TANGENT:
        fprintf(file, "hyperbolic arc tangent");
        break;

      case BC_OPCODE_ABSOLUTE:
        fprintf(file, "absolute              ");
        break;

      case BC_OPCODE_SQUARE_ROOT:
        fprintf(file, "square root           ");
        break;

      case BC_OPCODE_FLOOR:
        fprintf(file, "floor                 ");
        break;

      case BC_OPCODE_CEILING:
        fprintf(file, "ceiling               ");
        break;

      case BC_OPCODE_NATURAL_LOGARITHM:
        fprintf(file, "natural logarithm     ");
        break;

      case BC_OPCODE_LOGARITHM_10:
        fprintf(file, "logarithm 10          ");
        break;

      case BC_OPCODE_NATURAL_POWER:
        fprintf(file, "natural power         ");
        break;

      case BC_OPCODE_ADD:
        fprintf(file, "add                   ");
        break;

      case BC_OPCODE_SUBTRACT:
        fprintf(file, "subtract              ");
        break;

      case BC_OPCODE_MULTIPLY:
        fprintf(file, "multiply              ");
        break;

      case BC_OPCODE_DIVIDE:
        fprintf(file, "divide                ");
        break;

      case BC_OPCODE_POWER:
        fprintf(file, "power                 ");
        break;

      case BC_OPCODE_MODULO:
        fprintf(file, "modulo                ");
        break;

      case BC_OPCODE_ARC_TANGENT_2:
        fprintf(file, "arc tangent 2         ");
        break;

      case BC_OPCODE_MINIMUM:
        fprintf(file, "minimum               ");
        break;

      case BC_OPCODE_MAXIMUM:
        fprintf(file, "maximum               ");
        break;

      default:
        fprintf(file, "unknown (%#06x)      ", opcode);
        break;
    }
  }
}
