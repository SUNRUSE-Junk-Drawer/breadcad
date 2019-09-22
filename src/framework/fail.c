#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include "fail.h"

void sdf_fail (const char * format, ...) {
  va_list argptr;
  va_start(argptr, format);
  vfprintf(stderr, format, argptr);
  va_end(argptr);
  exit(1);
}
