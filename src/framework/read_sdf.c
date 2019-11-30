#include "fail.h"
#include "types.h"
#include "read.h"
#include "primitive.h"
#include "opcode.h"
#include "pointer.h"
#include "argument.h"
#include "executable.h"
#include "read_sdf.h"

static sdf_argument_t sdf__read_argument(
  FILE * file,
  const char * what
) {
  sdf_argument_t output;
  output.pointer = sdf_read_u16(file, what);
  if (output.pointer == SDF_POINTER_NUMBER_CONSTANT) {
    output.number_constant = sdf_read_number(file, "number constant");
  } else {
    output.number_constant = sdf_number_not_a_number;
  }
  return output;
}

void sdf_read_sdf(
  FILE * file
) {
  sdf_opcode_t opcode;
  sdf_opcode_arity_t arity;
  sdf_argument_t argument_a;
  sdf_argument_t argument_b;
  sdf_argument_t argument_c;

  while (sdf_read_u16_or_eof(file, "opcode", &opcode)) {
    arity = sdf_opcode_arity(opcode);
    switch (arity) {
      case 0:
        sdf_executable_nullary(opcode);
        break;

      case 1:
        argument_a = sdf__read_argument(file, "argument a");
        sdf_executable_unary(
          opcode,
          argument_a
        );
        break;

      case 2:
        argument_a = sdf__read_argument(file, "argument a");
        argument_b = sdf__read_argument(file, "argument b");
        sdf_executable_binary(
          opcode,
          argument_a,
          argument_b
        );
        break;

      case 3:
        argument_a = sdf__read_argument(file, "argument a");
        argument_b = sdf__read_argument(file, "argument b");
        argument_c = sdf__read_argument(file, "argument c");
        sdf_executable_ternary(
          opcode,
          argument_a,
          argument_b,
          argument_c
        );
        break;

      default:
        sdf_fail("unexpected opcode arity %#02x\n", (unsigned int)arity);
        break;
    }
  }

  sdf_executable_eof();
}
