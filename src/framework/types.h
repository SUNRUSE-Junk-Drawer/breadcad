#ifndef SDF_TYPES_H
#define SDF_TYPES_H

#include <stdlib.h>

typedef unsigned char sdf_boolean_t;
#define SDF_BOOLEAN_FALSE 0
#define SDF_BOOLEAN_TRUE 1

typedef unsigned char sdf_u8_t;
#define SDF_U8_MAX 255
#define SDF_U8_RANGE (SDF_U8_MAX + 1)

typedef unsigned short sdf_u16_t;
#define SDF_U16_MAX 65535
#define SDF_U16_RANGE (SDF_U16_MAX + 1)

typedef float sdf_f32_t;
extern sdf_f32_t sdf_f32_infinity;

void sdf_types(void);

void sdf_types_u16_swap_endianness(sdf_u16_t * value);
void sdf_types_f32_swap_endianness(sdf_f32_t * value);

#ifndef SIZE_MAX
#define SIZE_MAX ((size_t)(-1))
#endif

#endif
