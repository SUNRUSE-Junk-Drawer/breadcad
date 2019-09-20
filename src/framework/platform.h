#ifndef SDF_PLATFORM_H
#define SDF_PLATFORM_H

#ifdef _WIN32
  #define SDF_PLATFORM_LINE_BREAK "\r\n"
#else
  #define SDF_PLATFORM_LINE_BREAK "\n"
#endif

#endif
