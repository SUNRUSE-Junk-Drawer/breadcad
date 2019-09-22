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
