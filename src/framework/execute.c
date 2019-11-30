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

#define SDF_EXECUTE_UNARY(name, argument_a_type, result_type, implementation)                \
  case SDF_OPCODE_##name:                                                                    \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]];             \
    switch (sdf_store_arguments[*argument].pointer) {                                        \
      case SDF_POINTER_NUMBER_CONSTANT:                                                      \
        argument_a_##argument_a_type = sdf_store_arguments[*argument].number_constant;       \
        (*argument)++;                                                                       \
        result_##result_type = implementation;                                               \
        while (iteration < iterations) {                                                     \
          result_buffer_##result_type[iteration] = result_##result_type;                     \
          iteration++;                                                                       \
        }                                                                                    \
        break;                                                                               \
      case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                               \
        argument_a_##argument_a_type = SDF_BOOLEAN_FALSE;                                    \
        (*argument)++;                                                                       \
        result_##result_type = implementation;                                               \
        while (iteration < iterations) {                                                     \
          result_buffer_##result_type[iteration] = result_##result_type;                     \
          iteration++;                                                                       \
        }                                                                                    \
        break;                                                                               \
      case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                \
        argument_a_##argument_a_type = SDF_BOOLEAN_TRUE;                                     \
        (*argument)++;                                                                       \
        result_##result_type = implementation;                                               \
        while (iteration < iterations) {                                                     \
          result_buffer_##result_type[iteration] = result_##result_type;                     \
          iteration++;                                                                       \
        }                                                                                    \
        break;                                                                               \
      default:                                                                               \
        argument_a_buffer_##argument_a_type = buffers[sdf_plan_argument_buffers[*argument]]; \
        (*argument)++;                                                                       \
        while (iteration < iterations) {                                                     \
          argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];     \
          result_buffer_##result_type[iteration] = implementation;                           \
          iteration++;                                                                       \
        }                                                                                    \
        break;                                                                               \
    }                                                                                        \
    break;

#define SDF_EXECUTE_BINARY(name, argument_a_type, argument_b_type, result_type, implementation)  \
  case SDF_OPCODE_##name:                                                                        \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]];                 \
    switch (sdf_store_arguments[*argument].pointer) {                                            \
      case SDF_POINTER_NUMBER_CONSTANT:                                                          \
        argument_a_##argument_a_type = sdf_store_arguments[*argument].number_constant;           \
        (*argument)++;                                                                           \
        switch (sdf_store_arguments[*argument].pointer) {                                        \
          case SDF_POINTER_NUMBER_CONSTANT:                                                      \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;       \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                               \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                    \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                     \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          default:                                                                               \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]]; \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
        }                                                                                        \
        break;                                                                                   \
      case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                   \
        argument_a_##argument_a_type = SDF_BOOLEAN_FALSE;                                        \
        (*argument)++;                                                                           \
        switch (sdf_store_arguments[*argument].pointer) {                                        \
          case SDF_POINTER_NUMBER_CONSTANT:                                                      \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;       \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                               \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                    \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                     \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          default:                                                                               \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]]; \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
        }                                                                                        \
        break;                                                                                   \
      case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                    \
        argument_a_##argument_a_type = SDF_BOOLEAN_TRUE;                                         \
        (*argument)++;                                                                           \
        switch (sdf_store_arguments[*argument].pointer) {                                        \
          case SDF_POINTER_NUMBER_CONSTANT:                                                      \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;       \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                               \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                    \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                     \
            (*argument)++;                                                                       \
            result_##result_type = implementation;                                               \
            while (iteration < iterations) {                                                     \
              result_buffer_##result_type[iteration] = result_##result_type;                     \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          default:                                                                               \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]]; \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
        }                                                                                        \
        break;                                                                                   \
      default:                                                                                   \
        argument_a_buffer_##argument_a_type = buffers[sdf_plan_argument_buffers[*argument]];     \
        (*argument)++;                                                                           \
        switch (sdf_store_arguments[*argument].pointer) {                                        \
          case SDF_POINTER_NUMBER_CONSTANT:                                                      \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;       \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                               \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                    \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                     \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
          default:                                                                               \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]]; \
            (*argument)++;                                                                       \
            while (iteration < iterations) {                                                     \
              argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];     \
              argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];     \
              result_buffer_##result_type[iteration] = implementation;                           \
              iteration++;                                                                       \
            }                                                                                    \
            break;                                                                               \
        }                                                                                        \
        break;                                                                                   \
    }                                                                                            \
    break;                                                                                                                                                                                                            \

#define SDF_EXECUTE_TERNARY(name, argument_a_type, argument_b_type, argument_c_type, result_type, implementation) \
  case SDF_OPCODE_##name:                                                                                         \
    result_buffer_##result_type = buffers[sdf_plan_result_buffers[instruction]];                                  \
    switch (sdf_store_arguments[*argument].pointer) {                                                             \
      case SDF_POINTER_NUMBER_CONSTANT:                                                                           \
        argument_a_##argument_a_type = sdf_store_arguments[*argument].number_constant;                            \
        (*argument)++;                                                                                            \
        switch (sdf_store_arguments[*argument].pointer) {                                                         \
          case SDF_POINTER_NUMBER_CONSTANT:                                                                       \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;                        \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                                     \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                                 \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                                      \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          default:                                                                                                \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]];                  \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
        }                                                                                                         \
        break;                                                                                                    \
      case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                                    \
        argument_a_##argument_a_type = SDF_BOOLEAN_FALSE;                                                         \
        (*argument)++;                                                                                            \
        switch (sdf_store_arguments[*argument].pointer) {                                                         \
          case SDF_POINTER_NUMBER_CONSTANT:                                                                       \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;                        \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                                     \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                                 \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                                      \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          default:                                                                                                \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]];                  \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
        }                                                                                                         \
        break;                                                                                                    \
      case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                                     \
        argument_a_##argument_a_type = SDF_BOOLEAN_TRUE;                                                          \
        (*argument)++;                                                                                            \
        switch (sdf_store_arguments[*argument].pointer) {                                                         \
          case SDF_POINTER_NUMBER_CONSTANT:                                                                       \
            argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;                        \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                                \
            argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                                     \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                                 \
            argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                                      \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                result_##result_type = implementation;                                                            \
                while (iteration < iterations) {                                                                  \
                  result_buffer_##result_type[iteration] = result_##result_type;                                  \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
          default:                                                                                                \
            argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]];                  \
            (*argument)++;                                                                                        \
            switch (sdf_store_arguments[*argument].pointer) {                                                     \
              case SDF_POINTER_NUMBER_CONSTANT:                                                                   \
                argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                    \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                            \
                argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                 \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                             \
                argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                  \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
              default:                                                                                            \
                argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];              \
                (*argument)++;                                                                                    \
                while (iteration < iterations) {                                                                  \
                  argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                  \
                  argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                  \
                  result_buffer_##result_type[iteration] = implementation;                                        \
                  iteration++;                                                                                    \
                }                                                                                                 \
                break;                                                                                            \
            }                                                                                                     \
            break;                                                                                                \
        }                                                                                                         \
        break;                                                                                                    \
    default:                                                                                                      \
      argument_a_buffer_##argument_a_type = buffers[sdf_plan_argument_buffers[*argument]];                        \
      (*argument)++;                                                                                              \
      switch (sdf_store_arguments[*argument].pointer) {                                                           \
        case SDF_POINTER_NUMBER_CONSTANT:                                                                         \
          argument_b_##argument_b_type = sdf_store_arguments[*argument].number_constant;                          \
          (*argument)++;                                                                                          \
          switch (sdf_store_arguments[*argument].pointer) {                                                       \
            case SDF_POINTER_NUMBER_CONSTANT:                                                                     \
              argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                      \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                              \
              argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                   \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                               \
              argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                    \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            default:                                                                                              \
              argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];                \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
          }                                                                                                       \
          break;                                                                                                  \
        case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                                  \
          argument_b_##argument_b_type = SDF_BOOLEAN_FALSE;                                                       \
          (*argument)++;                                                                                          \
          switch (sdf_store_arguments[*argument].pointer) {                                                       \
            case SDF_POINTER_NUMBER_CONSTANT:                                                                     \
              argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                      \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                              \
              argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                   \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                               \
              argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                    \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            default:                                                                                              \
              argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];                \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
          }                                                                                                       \
          break;                                                                                                  \
        case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                                   \
          argument_b_##argument_b_type = SDF_BOOLEAN_TRUE;                                                        \
          (*argument)++;                                                                                          \
          switch (sdf_store_arguments[*argument].pointer) {                                                       \
            case SDF_POINTER_NUMBER_CONSTANT:                                                                     \
              argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                      \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                              \
              argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                   \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                               \
              argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                    \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            default:                                                                                              \
              argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];                \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
          }                                                                                                       \
          break;                                                                                                  \
        default:                                                                                                  \
          argument_b_buffer_##argument_b_type = buffers[sdf_plan_argument_buffers[*argument]];                    \
          (*argument)++;                                                                                          \
          switch (sdf_store_arguments[*argument].pointer) {                                                       \
            case SDF_POINTER_NUMBER_CONSTANT:                                                                     \
              argument_c_##argument_c_type = sdf_store_arguments[*argument].number_constant;                      \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_FALSE:                                                              \
              argument_c_##argument_c_type = SDF_BOOLEAN_FALSE;                                                   \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            case SDF_POINTER_BOOLEAN_CONSTANT_TRUE:                                                               \
              argument_c_##argument_c_type = SDF_BOOLEAN_TRUE;                                                    \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
            default:                                                                                              \
              argument_c_buffer_##argument_c_type = buffers[sdf_plan_argument_buffers[*argument]];                \
              (*argument)++;                                                                                      \
              while (iteration < iterations) {                                                                    \
                argument_a_##argument_a_type = argument_a_buffer_##argument_a_type[iteration];                    \
                argument_b_##argument_b_type = argument_b_buffer_##argument_b_type[iteration];                    \
                argument_c_##argument_c_type = argument_c_buffer_##argument_c_type[iteration];                    \
                result_buffer_##result_type[iteration] = implementation;                                          \
                iteration++;                                                                                      \
              }                                                                                                   \
              break;                                                                                              \
          }                                                                                                       \
          break;                                                                                                  \
      }                                                                                                           \
      break;                                                                                                      \
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
        output[buffer] = SDF_MALLOC(sdf_number_t, iterations, "a number buffer to use during execution");
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
  sdf_boolean_t result_boolean;
  sdf_number_t * result_buffer_number;
  sdf_number_t result_number;
  sdf_boolean_t * argument_a_buffer_boolean;
  sdf_boolean_t argument_a_boolean;
  sdf_number_t * argument_a_buffer_number;
  sdf_number_t argument_a_number;
  sdf_boolean_t * argument_b_buffer_boolean;
  sdf_boolean_t argument_b_boolean;
  sdf_number_t * argument_b_buffer_number;
  sdf_number_t argument_b_number;
  sdf_boolean_t * argument_c_buffer_boolean;
  sdf_boolean_t argument_c_boolean;
  sdf_number_t * argument_c_buffer_number;
  sdf_number_t argument_c_number;

  switch (opcode) {
    SDF_EXECUTE_UNARY(NOT, boolean, boolean, !argument_a_boolean)
    SDF_EXECUTE_BINARY(AND, boolean, boolean, boolean, argument_a_boolean && argument_b_boolean)
    SDF_EXECUTE_BINARY(OR, boolean, boolean, boolean, argument_a_boolean || argument_b_boolean)
    SDF_EXECUTE_BINARY(EQUAL, boolean, boolean, boolean, argument_a_boolean == argument_b_boolean)
    SDF_EXECUTE_BINARY(NOT_EQUAL, boolean, boolean, boolean, argument_a_boolean != argument_b_boolean)
    SDF_EXECUTE_TERNARY(CONDITIONAL_BOOLEAN, boolean, boolean, boolean, boolean, argument_a_boolean ? argument_b_boolean : argument_c_boolean)
    SDF_EXECUTE_TERNARY(CONDITIONAL_NUMBER, boolean, number, number, number, argument_a_boolean ? argument_b_number : argument_c_number)
    SDF_EXECUTE_BINARY(GREATER_THAN, number, number, boolean, argument_a_number > argument_b_number)
    SDF_EXECUTE_UNARY(NEGATE, number, number, -argument_a_number)
    SDF_EXECUTE_UNARY(SINE, number, number, __builtin_sinf(argument_a_number))
    SDF_EXECUTE_UNARY(COSINE, number, number, __builtin_cosf(argument_a_number))
    SDF_EXECUTE_UNARY(TANGENT, number, number, __builtin_tanf(argument_a_number))
    SDF_EXECUTE_UNARY(ARC_SINE, number, number, __builtin_asinf(argument_a_number))
    SDF_EXECUTE_UNARY(ARC_COSINE, number, number, __builtin_acosf(argument_a_number))
    SDF_EXECUTE_UNARY(ARC_TANGENT, number, number, __builtin_atanf(argument_a_number))
    SDF_EXECUTE_UNARY(HYPERBOLIC_SINE, number, number, __builtin_sinhf(argument_a_number))
    SDF_EXECUTE_UNARY(HYPERBOLIC_COSINE, number, number, __builtin_coshf(argument_a_number))
    SDF_EXECUTE_UNARY(HYPERBOLIC_TANGENT, number, number, __builtin_tanhf(argument_a_number))
    SDF_EXECUTE_UNARY(HYPERBOLIC_ARC_SINE, number, number, __builtin_asinhf(argument_a_number))
    SDF_EXECUTE_UNARY(HYPERBOLIC_ARC_COSINE, number, number, __builtin_acoshf(argument_a_number))
    SDF_EXECUTE_UNARY(HYPERBOLIC_ARC_TANGENT, number, number, __builtin_atanhf(argument_a_number))
    SDF_EXECUTE_UNARY(ABSOLUTE, number, number, __builtin_fabs(argument_a_number))
    SDF_EXECUTE_UNARY(SQUARE_ROOT, number, number, __builtin_sqrtf(argument_a_number))
    SDF_EXECUTE_UNARY(FLOOR, number, number, __builtin_floorf(argument_a_number))
    SDF_EXECUTE_UNARY(CEILING, number, number, __builtin_ceilf(argument_a_number))
    SDF_EXECUTE_UNARY(NATURAL_LOGARITHM, number, number, __builtin_logf(argument_a_number))
    SDF_EXECUTE_UNARY(LOGARITHM_10, number, number, __builtin_log10(argument_a_number))
    SDF_EXECUTE_UNARY(NATURAL_POWER, number, number, __builtin_expf(argument_a_number))
    SDF_EXECUTE_BINARY(ADD, number, number, number, argument_a_number + argument_b_number)
    SDF_EXECUTE_BINARY(SUBTRACT, number, number, number, argument_a_number - argument_b_number)
    SDF_EXECUTE_BINARY(MULTIPLY, number, number, number, argument_a_number * argument_b_number)
    SDF_EXECUTE_BINARY(DIVIDE, number, number, number, argument_a_number / argument_b_number)
    SDF_EXECUTE_BINARY(POW, number, number, number, __builtin_powf(argument_a_number, argument_b_number))
    SDF_EXECUTE_BINARY(MODULO, number, number, number, __builtin_fmodf(argument_a_number, argument_b_number))
    SDF_EXECUTE_BINARY(ARC_TANGENT_2, number, number, number, __builtin_atan2f(argument_a_number, argument_b_number))
    SDF_EXECUTE_BINARY(MIN, number, number, number, __builtin_fminf(argument_a_number, argument_b_number))
    SDF_EXECUTE_BINARY(MAXIMUM, number, number, number, __builtin_fmaxf(argument_a_number, argument_b_number))
    default:
      if (opcode >= SDF_OPCODE_PARAMETER_MIN && opcode <= SDF_OPCODE_PARAMETER_MAX) {
        id = sdf_opcode_id(opcode);
        result_buffer_number = buffers[sdf_plan_result_buffers[instruction]];
        while (iteration < iterations) {
          result_buffer_number[iteration] = sdf_executable_get_parameter(
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

static sdf_number_t * sdf__generate_infinity_buffer(
  size_t iterations
) {
  size_t iteration = 0;
  sdf_number_t * output = SDF_MALLOC(sdf_number_t, iterations, "a number buffer for dummy output");
  while (iteration < iterations) {
    output[iteration] = sdf_number_infinity;
    iteration++;
  }
  return output;
}

static sdf_number_t * sdf__get_final_buffer(
  size_t iterations,
  void ** buffers
) {
  if (sdf_store_total_opcodes) {
    return buffers[sdf_plan_result_buffers[sdf_store_total_opcodes - 1]];
  } else {
    return sdf__generate_infinity_buffer(iterations);
  }
}

sdf_number_t * sdf_execute(
  void * parameter_context,
  size_t iterations
) {
  size_t instruction = 0;
  size_t argument = 0;
  void ** buffers;
  sdf_number_t * output;

  buffers = sdf__allocate_buffers(iterations);

  while (instruction < sdf_store_total_opcodes) {
    sdf__execute_instruction(parameter_context, iterations, buffers, instruction, &argument);
    instruction++;
  }

  output = sdf__get_final_buffer(iterations, buffers);
  sdf__free_all_non_final_buffers(buffers);
  return output;
}
