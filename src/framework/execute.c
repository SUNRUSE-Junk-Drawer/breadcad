#include "unused.h"
#include "fail.h"
#include "types.h"
#include "malloc.h"
#include "opcode.h"
#include "executable.h"
#include "plan.h"
#include "execute.h"

#define SDF_EXECUTE_OPCODE(name, result_type, implementation)  \
  case SDF_OPCODE_##name:                                      \
    while (iteration < iterations) {                           \
      result_buffer_##result_type[iteration] = implementation; \
      iteration++;                                             \
    }                                                          \
    break;

static void ** sdf__allocate_buffers(
  size_t iterations
) {
  size_t buffer = 0;
  sdf_primitive_t primitive;
  void ** output = SDF_MALLOC(void *, sdf_plan_buffers, "a list of buffers to use during execution");
  while (buffer < sdf_plan_buffers) {
    primitive = sdf_plan_buffer_primitives[buffer];

    switch (primitive) {
      case SDF_PRIMITIVE_BOOLEAN:
        output[buffer] = SDF_MALLOC(sdf_boolean_t, iterations, "a boolean buffer to use during execution");
        break;

      case SDF_PRIMITIVE_NUMBER:
        output[buffer] = SDF_MALLOC(sdf_f32_t, iterations, "a number buffer to use during execution");
        break;

      default:
        sdf_fail("unexpected buffer primitive %#02x\n", (unsigned int)primitive);
        break;
    }
    buffer++;
  }
  return output;
}

static void sdf__get_buffer(
  void ** buffers,
  size_t buffer,
  sdf_boolean_t ** pointer_to_boolean,
  sdf_f32_t ** pointer_to_f32
) {
  *pointer_to_boolean = NULL;
  *pointer_to_f32 = NULL;
  switch (sdf_plan_buffer_primitives[buffer]) {
    case SDF_PRIMITIVE_NONE:
      break;
    case SDF_PRIMITIVE_BOOLEAN:
      *pointer_to_boolean = buffers[buffer];
      break;
    case SDF_PRIMITIVE_NUMBER:
      *pointer_to_f32 = buffers[buffer];
      break;
    default:
      sdf_fail("unexpected buffer primitive %#02x\n", (unsigned int)sdf_plan_buffer_primitives[buffer]);
      break;
  }
}

static void sdf__execute_instruction(
  void * parameter_context,
  size_t iterations,
  void ** buffers,
  size_t instruction,
  size_t * argument
) {
  sdf_opcode_t opcode = sdf_store_opcodes[instruction];
  sdf_opcode_arity_t arity = sdf_opcode_arity(opcode);
  sdf_opcode_id_t id;
  size_t iteration = 0;
  sdf_boolean_t * result_buffer_boolean = NULL;
  sdf_f32_t * result_buffer_f32 = NULL;
  sdf_boolean_t * argument_a_buffer_boolean = NULL;
  sdf_f32_t * argument_a_buffer_f32 = NULL;
  sdf_boolean_t * argument_b_buffer_boolean = NULL;
  sdf_f32_t * argument_b_buffer_f32 = NULL;
  sdf_boolean_t * argument_c_buffer_boolean = NULL;
  sdf_f32_t * argument_c_buffer_f32 = NULL;

  sdf__get_buffer(buffers, sdf_plan_result_buffers[instruction], &result_buffer_boolean, &result_buffer_f32);

  if (arity >= 1) {
    sdf__get_buffer(buffers, sdf_plan_argument_buffers[(*argument)++], &argument_a_buffer_boolean, &argument_a_buffer_f32);
  }

  if (arity >= 2) {
    sdf__get_buffer(buffers, sdf_plan_argument_buffers[(*argument)++], &argument_b_buffer_boolean, &argument_b_buffer_f32);
  }

  if (arity >= 3) {
    sdf__get_buffer(buffers, sdf_plan_argument_buffers[(*argument)++], &argument_c_buffer_boolean, &argument_c_buffer_f32);
  }

  switch (opcode) {
    SDF_EXECUTE_OPCODE(NOT, boolean, !argument_a_buffer_boolean[iteration])
    SDF_EXECUTE_OPCODE(AND, boolean, argument_a_buffer_boolean[iteration] && argument_b_buffer_boolean[iteration])
    SDF_EXECUTE_OPCODE(OR, boolean, argument_a_buffer_boolean[iteration] || argument_b_buffer_boolean[iteration])
    SDF_EXECUTE_OPCODE(EQUAL, boolean, argument_a_buffer_boolean[iteration] == argument_b_buffer_boolean[iteration])
    SDF_EXECUTE_OPCODE(NOT_EQUAL, boolean, argument_a_buffer_boolean[iteration] != argument_b_buffer_boolean[iteration])
    SDF_EXECUTE_OPCODE(CONDITIONAL_BOOLEAN, boolean, argument_a_buffer_boolean[iteration] ? argument_b_buffer_boolean[iteration] : argument_c_buffer_boolean[iteration])
    SDF_EXECUTE_OPCODE(CONDITIONAL_NUMBER, f32, argument_a_buffer_boolean[iteration] ? argument_b_buffer_f32[iteration] : argument_c_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(GREATER_THAN, boolean, argument_a_buffer_f32[iteration] > argument_b_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(NEGATE, f32, -argument_a_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(SINE, f32, __builtin_sinf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(COSINE, f32, __builtin_cosf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(TANGENT, f32, __builtin_tanf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(ARC_SINE, f32, __builtin_asinf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(ARC_COSINE, f32, __builtin_acosf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(ARC_TANGENT, f32, __builtin_atanf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(HYPERBOLIC_SINE, f32, __builtin_sinhf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(HYPERBOLIC_COSINE, f32, __builtin_coshf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(HYPERBOLIC_TANGENT, f32, __builtin_tanhf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(HYPERBOLIC_ARC_SINE, f32, __builtin_asinhf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(HYPERBOLIC_ARC_COSINE, f32, __builtin_acoshf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(HYPERBOLIC_ARC_TANGENT, f32, __builtin_atanhf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(ABSOLUTE, f32, __builtin_fabs(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(SQUARE_ROOT, f32, __builtin_sqrtf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(FLOOR, f32, __builtin_floorf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(CEILING, f32, __builtin_ceilf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(NATURAL_LOGARITHM, f32, __builtin_logf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(LOGARITHM_10, f32, __builtin_log10(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(NATURAL_POWER, f32, __builtin_expf(argument_a_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(ADD, f32, argument_a_buffer_f32[iteration] + argument_b_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(SUBTRACT, f32, argument_a_buffer_f32[iteration] - argument_b_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(MULTIPLY, f32, argument_a_buffer_f32[iteration] * argument_b_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(DIVIDE, f32, argument_a_buffer_f32[iteration] / argument_b_buffer_f32[iteration])
    SDF_EXECUTE_OPCODE(POW, f32, __builtin_powf(argument_a_buffer_f32[iteration], argument_b_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(MODULO, f32, __builtin_fmodf(argument_a_buffer_f32[iteration], argument_b_buffer_f32[iteration]))
    SDF_EXECUTE_OPCODE(ARC_TANGENT_2, f32, __builtin_atan2f(argument_a_buffer_f32[iteration], argument_b_buffer_f32[iteration]))
    default:
      if (opcode >= SDF_OPCODE_PARAMETER_MIN && opcode <= SDF_OPCODE_PARAMETER_MAX) {
        id = sdf_opcode_id(opcode);
        while (iteration < iterations) {
          result_buffer_f32[iteration] = sdf_executable_get_parameter(
            parameter_context,
            iteration,
            id
          );
          iteration++;
        }
      } else {
        sdf_fail("unsupported opcode %#04x\n", (unsigned int)opcode);
      }
  }
}

static void sdf__free_all_non_final_buffers(
  void ** buffers
) {
  size_t buffer = 0;
  while (buffer < sdf_plan_buffers) {
    if (buffer != sdf_plan_result_buffers[sdf_store_total_opcodes - 1]) {
      free(buffers[buffer]);
    }
    buffer++;
  }
  free(buffers);
}

static sdf_f32_t * sdf__generate_infinity_buffer(
  size_t iterations
) {
  size_t iteration = 0;
  sdf_f32_t * output = SDF_MALLOC(sdf_f32_t, iterations, "a number buffer for dummy output");
  while (iteration < iterations) {
    output[iteration] = sdf_f32_infinity;
    iteration++;
  }
  return output;
}

static sdf_f32_t * sdf__get_final_buffer(
  size_t iterations,
  void ** buffers
) {
  if (sdf_store_total_opcodes) {
    return buffers[sdf_plan_result_buffers[sdf_store_total_opcodes - 1]];
  } else {
    return sdf__generate_infinity_buffer(iterations);
  }
}

sdf_f32_t * sdf_execute(
  void * parameter_context,
  size_t iterations
) {
  size_t instruction = 0;
  size_t argument = 0;
  void ** buffers;
  sdf_f32_t * output;

  buffers = sdf__allocate_buffers(iterations);

  while (instruction < sdf_store_total_opcodes) {
    sdf__execute_instruction(parameter_context, iterations, buffers, instruction, &argument);
    instruction++;
  }

  output = sdf__get_final_buffer(iterations, buffers);
  sdf__free_all_non_final_buffers(buffers);
  return output;
}
