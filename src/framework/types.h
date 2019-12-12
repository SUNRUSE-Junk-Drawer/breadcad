#ifndef BC_TYPES_H
#define BC_TYPES_H

#include <stdlib.h>

typedef unsigned char bc_boolean_t;
#define BC_BOOLEAN_FALSE 0
#define BC_BOOLEAN_TRUE 1

typedef unsigned char bc_u8_t;
#define BC_U8_MAX 255
#define BC_U8_RANGE (BC_U8_MAX + 1)

typedef unsigned short bc_u16_t;
#define BC_U16_MAX 65535
#define BC_U16_RANGE (BC_U16_MAX + 1)

typedef float bc_number_t;
extern bc_number_t bc_number_infinity;
extern bc_number_t bc_number_not_a_number;

void bc_types(void);

void bc_types_u16_swap_endianness(bc_u16_t * value);
void bc_types_number_swap_endianness(bc_number_t * value);

#ifndef SIZE_MAX
#define SIZE_MAX ((size_t)(-1))
#endif

#endif
