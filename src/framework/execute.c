#include "unused.h"
#include "fail.h"
#include "types.h"
#include "malloc.h"
#include "opcode.h"
#include "executable.h"
#include "plan.h"
#include "execute.h"

#define SDF_EXECUTE_NULLARY(name, result_type, implementation)                   \
  case SDF_OPCODE_##name:                                                        \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]]; \
    while (iteration < iterations) {                                             \
      result_buffer_##result_type[iteration] = implementation;                   \
      iteration++;                                                               \
    }                                                                            \
    break;

#define SDF_EXECUTE_UNARY(name, argument_a_type, result_type, implementation)          \
  case SDF_OPCODE_##name:                                                              \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]];       \
    if (sdf_store_argument_pointers[*argument] == SDF_POINTER_FLOAT_CONSTANT) {        \
      argument_a_##argument_a_type = sdf_store_argument_float_constants[*argument];    \
      (*argument)++;                                                                   \
      argument_a_##argument_a_type = implementation;                                   \
      while (iteration < iterations) {                                                 \
        result_buffer_##result_type[iteration] = argument_a_##argument_a_type;         \
        iteration++;                                                                   \
      }                                                                                \
    } else {                                                                           \
      argument_a_buffer_##argument_a_type = buffers[*argument];                        \
      (*argument)++;                                                                   \
      while (iteration < iterations) {                                                 \
        argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration]; \
        result_buffer_##result_type[iteration] = implementation;                       \
        iteration++;                                                                   \
      }                                                                                \
    }                                                                                  \
    break;

#define SDF_EXECUTE_BINARY(name, argument_a_type, argument_b_type, result_type, implementation) \
  case SDF_OPCODE_##name:                                                                       \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]];                \
    argument_a_buffer_##argument_a_type = buffers[sdf_plan_argument_buffers[(*argument)++]];    \
    argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[(*argument)++]];    \
    while (iteration < iterations) {                                                            \
      argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];            \
      argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];            \
      result_buffer_##result_type[iteration] = implementation;                                  \
      iteration++;                                                                              \
    }                                                                                           \
    break;

#define SDF_EXECUTE_TERNARY(name, argument_a_type, argument_b_type, argument_c_type, result_type, implementation) \
  case SDF_OPCODE_##name:                                                                                         \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]];                                  \
    argument_a_buffer_##argument_a_type = buffers[sdf_plan_argument_buffers[(*argument)++]];                      \
    argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[(*argument)++]];                      \
    argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[(*argument)++]];                      \
    while (iteration < iterations) {                                                                              \
      argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                              \
      argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                              \
      argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                              \
      result_buffer_##result_type[iteration] = implementation;                                                    \
      iteration++;                                                                                                \
    }                                                                                                             \
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

static void sdf__execute_instruction(
  void * parameter_context,
  size_t iterations,
  void ** buffers,
  size_t instruction,
  size_t * argument
) {
  sdf_opcode_t opcode = sdf_store_opcodes[instruction];
  sdf_opcode_id_t id;
  size_t iteration = 0;
  sdf_boolean_t * result_buffer_boolean;
  sdf_f32_t * result_buffer_f32;
  sdf_boolean_t * argument_a_buffer_boolean;
  sdf_boolean_t argument_a_boolean;
  sdf_f32_t * argument_a_buffer_f32;
  sdf_f32_t argument_a_f32;
  sdf_boolean_t * argument_b_buffer_boolean;
  sdf_boolean_t argument_b_boolean;
  sdf_f32_t * argument_b_buffer_f32;
  sdf_f32_t argument_b_f32;
  sdf_boolean_t * argument_c_buffer_boolean;
  sdf_boolean_t argument_c_boolean;
  sdf_f32_t * argument_c_buffer_f32;
  sdf_f32_t argument_c_f32;

  switch (opcode) {
    SDF_EXECUTE_UNARY(NOT, boolean, boolean, !argument_a_boolean)
    SDF_EXECUTE_BINARY(AND, boolean, boolean, boolean, argument_a_boolean && argument_b_boolean)
    SDF_EXECUTE_BINARY(OR, boolean, boolean, boolean, argument_a_boolean || argument_b_boolean)
    SDF_EXECUTE_BINARY(EQUAL, boolean, boolean, boolean, argument_a_boolean == argument_b_boolean)
    SDF_EXECUTE_BINARY(NOT_EQUAL, boolean, boolean, boolean, argument_a_boolean != argument_b_boolean)
    SDF_EXECUTE_TERNARY(CONDITIONAL_BOOLEAN, boolean, boolean, boolean, boolean, argument_a_boolean ? argument_b_boolean : argument_c_boolean)
    SDF_EXECUTE_TERNARY(CONDITIONAL_NUMBER, boolean, f32, f32, f32, argument_a_boolean ? argument_b_f32 : argument_c_f32)
    SDF_EXECUTE_BINARY(GREATER_THAN, f32, f32, boolean, argument_a_f32 > argument_b_f32)
    SDF_EXECUTE_UNARY(NEGATE, f32, f32, -argument_a_f32)
    SDF_EXECUTE_UNARY(SINE, f32, f32, __builtin_sinf(argument_a_f32))
    SDF_EXECUTE_UNARY(COSINE, f32, f32, __builtin_cosf(argument_a_f32))
    SDF_EXECUTE_UNARY(TANGENT, f32, f32, __builtin_tanf(argument_a_f32))
    SDF_EXECUTE_UNARY(ARC_SINE, f32, f32, __builtin_asinf(argument_a_f32))
    SDF_EXECUTE_UNARY(ARC_COSINE, f32, f32, __builtin_acosf(argument_a_f32))
    SDF_EXECUTE_UNARY(ARC_TANGENT, f32, f32, __builtin_atanf(argument_a_f32))
    SDF_EXECUTE_UNARY(HYPERBOLIC_SINE, f32, f32, __builtin_sinhf(argument_a_f32))
    SDF_EXECUTE_UNARY(HYPERBOLIC_COSINE, f32, f32, __builtin_coshf(argument_a_f32))
    SDF_EXECUTE_UNARY(HYPERBOLIC_TANGENT, f32, f32, __builtin_tanhf(argument_a_f32))
    SDF_EXECUTE_UNARY(HYPERBOLIC_ARC_SINE, f32, f32, __builtin_asinhf(argument_a_f32))
    SDF_EXECUTE_UNARY(HYPERBOLIC_ARC_COSINE, f32, f32, __builtin_acoshf(argument_a_f32))
    SDF_EXECUTE_UNARY(HYPERBOLIC_ARC_TANGENT, f32, f32, __builtin_atanhf(argument_a_f32))
    SDF_EXECUTE_UNARY(ABSOLUTE, f32, f32, __builtin_fabs(argument_a_f32))
    SDF_EXECUTE_UNARY(SQUARE_ROOT, f32, f32, __builtin_sqrtf(argument_a_f32))
    SDF_EXECUTE_UNARY(FLOOR, f32, f32, __builtin_floorf(argument_a_f32))
    SDF_EXECUTE_UNARY(CEILING, f32, f32, __builtin_ceilf(argument_a_f32))
    SDF_EXECUTE_UNARY(NATURAL_LOGARITHM, f32, f32, __builtin_logf(argument_a_f32))
    SDF_EXECUTE_UNARY(LOGARITHM_10, f32, f32, __builtin_log10(argument_a_f32))
    SDF_EXECUTE_UNARY(NATURAL_POWER, f32, f32, __builtin_expf(argument_a_f32))
    SDF_EXECUTE_BINARY(ADD, f32, f32, f32, argument_a_f32 + argument_b_f32)
    SDF_EXECUTE_BINARY(SUBTRACT, f32, f32, f32, argument_a_f32 - argument_b_f32)
    SDF_EXECUTE_BINARY(MULTIPLY, f32, f32, f32, argument_a_f32 * argument_b_f32)
    SDF_EXECUTE_BINARY(DIVIDE, f32, f32, f32, argument_a_f32 / argument_b_f32)
    SDF_EXECUTE_BINARY(POW, f32, f32, f32, __builtin_powf(argument_a_f32, argument_b_f32))
    SDF_EXECUTE_BINARY(MODULO, f32, f32, f32, __builtin_fmodf(argument_a_f32, argument_b_f32))
    SDF_EXECUTE_BINARY(ARC_TANGENT_2, f32, f32, f32, __builtin_atan2f(argument_a_f32, argument_b_f32))
    default:
      if (opcode >= SDF_OPCODE_PARAMETER_MIN && opcode <= SDF_OPCODE_PARAMETER_MAX) {
        id = sdf_opcode_id(opcode);
        result_buffer_f32 = buffers[sdf_plan_result_buffers[instruction]];
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
