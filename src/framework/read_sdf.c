#include "fail.h"
#include "types.h"
#include "read.h"
#include "primitive.h"
#include "opcode.h"
#include "pointer.h"
#include "executable.h"
#include "read_sdf.h"

static void sdf__read_argument(
  FILE * file,
  sdf_pointer_t * pointer_to_pointer,
  sdf_f32_t * pointer_to_float_constant,
  const char * what
) {
  *pointer_to_pointer = sdf_read_u16(file, what);
  if (*pointer_to_pointer == SDF_POINTER_FLOAT_CONSTANT) {
    *pointer_to_float_constant = sdf_read_f32(file, "float constant");
  } else {
    *pointer_to_float_constant = sdf_f32_not_a_number;
  }
}

void sdf_read_sdf(
  FILE * file
) {
  sdf_opcode_t opcode;
  sdf_opcode_arity_t arity;
  sdf_pointer_t argument_a_pointer;
  sdf_f32_t argument_a_float_constant;
  sdf_pointer_t argument_b_pointer;
  sdf_f32_t argument_b_float_constant;
  sdf_pointer_t argument_c_pointer;
  sdf_f32_t argument_c_float_constant;

  while (sdf_read_u16_or_eof(file, "opcode", &opcode)) {
    arity = sdf_opcode_arity(opcode);
    switch (arity) {
      case 0:
        sdf_executable_nullary(opcode);
        break;

      case 1:
        sdf__read_argument(
          file,
          &argument_a_pointer,
          &argument_a_float_constant,
          "argument a"
        );
        sdf_executable_unary(
          opcode,
          argument_a_pointer,
          argument_a_float_constant
        );
        break;

      case 2:
        sdf__read_argument(
          file,
          &argument_a_pointer,
          &argument_a_float_constant,
          "argument a"
        );
        sdf__read_argument(
          file,
          &argument_b_pointer,
          &argument_b_float_constant,
          "argument b"
        );
        sdf_executable_binary(
          opcode,
          argument_a_pointer,
          argument_a_float_constant,
          argument_b_pointer,
          argument_b_float_constant
        );
        break;

      case 3:
        sdf__read_argument(
          file,
          &argument_a_pointer,
          &argument_a_float_constant,
          "argument a"
        );
        sdf__read_argument(
          file,
          &argument_b_pointer,
          &argument_b_float_constant,
          "argument b"
        );
        sdf__read_argument(
          file,
          &argument_c_pointer,
          &argument_c_float_constant,
          "argument c"
        );
        sdf_executable_ternary(
          opcode,
          argument_a_pointer,
          argument_a_float_constant,
          argument_b_pointer,
          argument_b_float_constant,
          argument_c_pointer,
          argument_c_float_constant
        );
        break;

      default:
        sdf_fail("unexpected opcode arity %#02x\n", (unsigned int)arity);
        break;
    }
  }

  sdf_executable_eof();
}
