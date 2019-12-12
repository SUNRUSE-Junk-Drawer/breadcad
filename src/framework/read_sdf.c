#include "fail.h"
#include "types.h"
#include "read.h"
#include "primitive.h"
#include "opcode.h"
#include "pointer.h"
#include "argument.h"
#include "executable.h"
#include "read_bc.h"

static bc_argument_t bc__read_argument(
  FILE * file,
  const char * what
) {
  bc_argument_t output;
  output.pointer = bc_read_u16(file, what);
  if (output.pointer == BC_POINTER_NUMBER_CONSTANT) {
    output.number_constant = bc_read_number(file, "number constant");
  } else {
    output.number_constant = bc_number_not_a_number;
  }
  return output;
}

void bc_read_bc(
  FILE * file
) {
  bc_opcode_t opcode;
  bc_opcode_arity_t arity;
  bc_argument_t argument_a;
  bc_argument_t argument_b;
  bc_argument_t argument_c;

  while (bc_read_u16_or_eof(file, "opcode", &opcode)) {
    arity = bc_opcode_arity(opcode);
    switch (arity) {
      case 0:
        bc_executable_nullary(opcode);
        break;

      case 1:
        argument_a = bc__read_argument(file, "argument a");
        bc_executable_unary(
          opcode,
          argument_a
        );
        break;

      case 2:
        argument_a = bc__read_argument(file, "argument a");
        argument_b = bc__read_argument(file, "argument b");
        bc_executable_binary(
          opcode,
          argument_a,
          argument_b
        );
        break;

      case 3:
        argument_a = bc__read_argument(file, "argument a");
        argument_b = bc__read_argument(file, "argument b");
        argument_c = bc__read_argument(file, "argument c");
        bc_executable_ternary(
          opcode,
          argument_a,
          argument_b,
          argument_c
        );
        break;

      default:
        bc_fail("unexpected opcode arity %#02x\n", (unsigned int)arity);
        break;
    }
  }

  bc_executable_eof();
}
