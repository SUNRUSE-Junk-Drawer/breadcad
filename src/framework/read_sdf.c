#include "types.h"
#include "read.h"
#include "primitive.h"
#include "opcode.h"
#include "pointer.h"
#include "executable.h"

void sdf_read_sdf(
  FILE * file
) {
  sdf_opcode_t opcode;
  sdf_opcode_arity_t arity;
  sdf_pointer_t argument_a;
  sdf_pointer_t argument_b;
  sdf_pointer_t argument_c;

  while (sdf_read_u16_or_eof(file, "opcode", &opcode)) {
    arity = sdf_opcode_arity(opcode);

    if (arity) {
      argument_a = sdf_read_u16(file, "argument a");
    }

    if (arity > 1) {
      argument_b = sdf_read_u16(file, "argument b");
    }

    if (arity > 2) {
      argument_c = sdf_read_u16(file, "argument c");
    }

    switch (arity) {
      case 0:
        sdf_executable_nullary(opcode);
        break;

      case 1:
        sdf_executable_unary(opcode, argument_a);
        break;

      case 2:
        sdf_executable_binary(opcode, argument_a, argument_b);
        break;

      case 3:
        sdf_executable_ternary(opcode, argument_a, argument_b, argument_c);
        break;
    }
  }

  sdf_executable_eof();
}
