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

void sdf_types(void) {
  sdf__check_sizeof();
  sdf__check_max();
  sdf__check_byte_order();
}
