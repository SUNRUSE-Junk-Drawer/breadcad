#include "types.h"
#include "fail.h"

#define BC_CHECK_SIZEOF(type, expectedSizeOf)           \
  if (sizeof(bc_##type##_t) != expectedSizeOf) {        \
    bc_fail(                                            \
      "unexpected size; sizeof(bc_" #type "_t) = %u\n", \
      sizeof(bc_##type##_t)                             \
    );                                                   \
  }

static void bc__check_sizeof(void) {
  BC_CHECK_SIZEOF(u8, 1)
  BC_CHECK_SIZEOF(u16, 2)
  BC_CHECK_SIZEOF(number, 4)
}

#define BC_CHECK_MAX(type, expectedMax)              \
  if (((bc_##type##_t)~0) != expectedMax) {          \
    bc_fail(                                         \
      "unexpected max; ~((bc_" #type "_t)0) = %u\n", \
      ~((bc_##type##_t)0)                            \
    );                                                \
  }

static void bc__check_max(void) {
  BC_CHECK_MAX(u8, BC_U8_MAX)
  BC_CHECK_MAX(u16, BC_U16_MAX)
}

static bc_boolean_t bc__u16_endianness_swap;
static bc_boolean_t bc__number_endianness_swap;

static void bc__check_byte_order(void) {
  union {
    bc_u8_t u8[4];
    bc_u16_t u16;
    bc_number_t number;
  } check;

  check.u8[0] = 74;
  check.u8[1] = 149;
  check.u8[2] = 87;
  check.u8[3] = 201;

  switch (check.u16) {
    case 19093:
      bc__u16_endianness_swap = BC_BOOLEAN_FALSE;
      break;
    case 38218:
      bc__u16_endianness_swap = BC_BOOLEAN_TRUE;
      break;
    default:
      bc_fail("unexpected endianness; u16[74, 149] = %u\n", (unsigned int)check.u16);
  }

  if (check.number == 4893668.500000f) {
    bc__number_endianness_swap = BC_BOOLEAN_FALSE;
  } else if (check.number == -883028.62500f) {
    bc__number_endianness_swap = BC_BOOLEAN_TRUE;
  } else {
    bc_fail("unexpected endianness; number[74, 149, 87, 201] = %f\n", check.number);
  }
}

bc_number_t bc_number_infinity;

static void bc__generate_number_infinity(void) {
  union {
    bc_u8_t u8[4];
    bc_number_t number;
  } generate;
  if (bc__number_endianness_swap) {
    generate.u8[0] = 0x00;
    generate.u8[1] = 0x00;
    generate.u8[2] = 0x80;
    generate.u8[3] = 0x7F;
  } else {
    generate.u8[0] = 0x7F;
    generate.u8[1] = 0x80;
    generate.u8[2] = 0x00;
    generate.u8[3] = 0x00;
  }
  bc_number_infinity = generate.number;
}

bc_number_t bc_number_not_a_number;

static void bc__generate_number_not_a_number(void) {
  union {
    bc_u8_t u8[4];
    bc_number_t number;
  } generate;
  if (bc__number_endianness_swap) {
    generate.u8[0] = 0x00;
    generate.u8[1] = 0x00;
    generate.u8[2] = 0xF8;
    generate.u8[3] = 0x7F;
  } else {
    generate.u8[0] = 0x7F;
    generate.u8[1] = 0xF8;
    generate.u8[2] = 0x00;
    generate.u8[3] = 0x00;
  }
  bc_number_not_a_number = generate.number;
}


void bc_types(void) {
  bc__check_sizeof();
  bc__check_max();
  bc__check_byte_order();
  bc__generate_number_infinity();
  bc__generate_number_not_a_number();
}

#define BC_SWAP_ENDIANNESS(type)                                        \
  void bc_types_##type##_swap_endianness(                               \
    bc_##type##_t * value                                               \
  ) {                                                                    \
    size_t byte = 0;                                                     \
    bc_##type##_t copy = *value;                                        \
    bc_u8_t * valueBytes = (bc_u8_t*) value;                           \
    bc_u8_t * copyBytes = (bc_u8_t*) &copy;                            \
    if (bc__##type##_endianness_swap) {                                 \
      while (byte < sizeof(bc_##type##_t)) {                            \
        valueBytes[byte] = copyBytes[sizeof(bc_##type##_t) - byte - 1]; \
        byte++;                                                          \
      }                                                                  \
    }                                                                    \
  }

BC_SWAP_ENDIANNESS(u16)
BC_SWAP_ENDIANNESS(number)
