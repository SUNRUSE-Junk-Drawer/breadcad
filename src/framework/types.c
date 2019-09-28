#include "types.h"
#include "fail.h"

#define SDF_CHECK_SIZEOF(type, expectedSizeOf)           \
  if (sizeof(sdf_##type##_t) != expectedSizeOf) {        \
    sdf_fail(                                            \
      "unexpected size; sizeof(sdf_" #type "_t) = %u\n", \
      sizeof(sdf_##type##_t)                             \
    );                                                   \
  }

static void sdf__check_sizeof(void) {
  SDF_CHECK_SIZEOF(u8, 1)
  SDF_CHECK_SIZEOF(u16, 2)
  SDF_CHECK_SIZEOF(f32, 4)
}

#define SDF_CHECK_MAX(type, expectedMax)              \
  if (((sdf_##type##_t)~0) != expectedMax) {          \
    sdf_fail(                                         \
      "unexpected max; ~((sdf_" #type "_t)0) = %u\n", \
      ~((sdf_##type##_t)0)                            \
    );                                                \
  }

static void sdf__check_max(void) {
  SDF_CHECK_MAX(u8, SDF_U8_MAX)
  SDF_CHECK_MAX(u16, SDF_U16_MAX)
}

static sdf_boolean_t sdf__u16_endianness_swap;
static sdf_boolean_t sdf__f32_endianness_swap;

static void sdf__check_byte_order(void) {
  union {
    sdf_u8_t u8[4];
    sdf_u16_t u16;
    sdf_f32_t f32;
  } check;

  check.u8[0] = 74;
  check.u8[1] = 149;
  check.u8[2] = 87;
  check.u8[3] = 201;

  switch (check.u16) {
    case 19093:
      sdf__u16_endianness_swap = SDF_BOOLEAN_FALSE;
      break;
    case 38218:
      sdf__u16_endianness_swap = SDF_BOOLEAN_TRUE;
      break;
    default:
      sdf_fail("unexpected endianness; u16[74, 149] = %u\n", (unsigned int)check.u16);
  }

  if (check.f32 == 4893668.500000f) {
    sdf__f32_endianness_swap = SDF_BOOLEAN_FALSE;
  } else if (check.f32 == -883028.62500f) {
    sdf__f32_endianness_swap = SDF_BOOLEAN_TRUE;
  } else {
    sdf_fail("unexpected endianness; f32[74, 149, 87, 201] = %f\n", check.f32);
  }
}

sdf_f32_t sdf_f32_infinity;

static void sdf__generate_f32_infinity(void) {
  union {
    sdf_u8_t u8[4];
    sdf_f32_t f32;
  } generate;
  if (sdf__f32_endianness_swap) {
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
  sdf_f32_infinity = generate.f32;
}

sdf_f32_t sdf_f32_not_a_number;

static void sdf__generate_f32_not_a_number(void) {
  union {
    sdf_u8_t u8[4];
    sdf_f32_t f32;
  } generate;
  if (sdf__f32_endianness_swap) {
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
  sdf_f32_not_a_number = generate.f32;
}


void sdf_types(void) {
  sdf__check_sizeof();
  sdf__check_max();
  sdf__check_byte_order();
  sdf__generate_f32_infinity();
  sdf__generate_f32_not_a_number();
}

#define SDF_SWAP_ENDIANNESS(type)                                        \
  void sdf_types_##type##_swap_endianness(                               \
    sdf_##type##_t * value                                               \
  ) {                                                                    \
    size_t byte = 0;                                                     \
    sdf_##type##_t copy = *value;                                        \
    sdf_u8_t * valueBytes = (sdf_u8_t*) value;                           \
    sdf_u8_t * copyBytes = (sdf_u8_t*) &copy;                            \
    if (sdf__##type##_endianness_swap) {                                 \
      while (byte < sizeof(sdf_##type##_t)) {                            \
        valueBytes[byte] = copyBytes[sizeof(sdf_##type##_t) - byte - 1]; \
        byte++;                                                          \
      }                                                                  \
    }                                                                    \
  }

SDF_SWAP_ENDIANNESS(u16)
SDF_SWAP_ENDIANNESS(f32)
