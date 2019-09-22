#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "fail.h"
#include "malloc.h"
#include "types.h"
#include "executable.h"
#include "cli.h"

static int sdf__argc;
static char ** sdf__argv;
static sdf_boolean_t * sdf__used;
static int * sdf__lengths;
static sdf_boolean_t sdf__help;

static int sdf__find_index(
  const char * short_name,
  const char * long_name
) {
  int argument = 0;
  while (argument < sdf__argc) {
    if (!sdf__used[argument]) {
      if (sdf__lengths[argument] > 1 && sdf__argv[argument][0] == '-') {
        if (!strcmp(&sdf__argv[argument][1], short_name)) {
          sdf__used[argument] = SDF_BOOLEAN_TRUE;
          return argument;
        }

        if (sdf__lengths[argument] > 2 && sdf__argv[argument][1] == '-') {
          if (!strcmp(&sdf__argv[argument][2], long_name)) {
            sdf__used[argument] = SDF_BOOLEAN_TRUE;
            return argument;
          }
        }
      }
    }
    argument++;
  }
  return -1;
}

static const char * sdf__find_value(
  const char * short_name,
  const char * long_name
) {
  int argument = sdf__find_index(short_name, long_name);

  if (argument == -1) {
    return NULL;
  }

  argument++;

  if (argument == sdf__argc || sdf__used[argument]) {
    sdf_fail(
      "expected a value for command line argument -%s/--%s\n",
      short_name,
      long_name
    );
  }

  sdf__used[argument] = SDF_BOOLEAN_TRUE;
  return sdf__argv[argument];
}

void sdf_cli_flag(
  const char * short_name,
  const char * long_name,
  const char * description,
  sdf_boolean_t * pointer_to_result
) {
  int argument;

  if (sdf__help) {
    printf("    -%s, --%s: %s\n", short_name, long_name, description);
    return;
  }

  argument = sdf__find_index(short_name, long_name);

  * pointer_to_result = argument != -1 ? SDF_BOOLEAN_TRUE : SDF_BOOLEAN_FALSE;
}

void sdf_cli_float(
  const char * short_name,
  const char * long_name,
  const char * description,
  sdf_f32_t * pointer_to_result,
  sdf_f32_t default_value
) {
  const char * value;
  char waste;

  if (sdf__help) {
    printf("    -%s [number], --%s [number]: %s (default: %f)\n", short_name, long_name, description, default_value);
    return;
  }

  value = sdf__find_value(short_name, long_name);

  if (value) {
    if (sscanf(value, "%f%c", pointer_to_result, &waste) != 1) {
      sdf_fail(
        "unable to parse command line argument -%s/--%s value \"%s\" as a float\n",
        short_name,
        long_name,
        value
      );
    }

    return;
  }

  * pointer_to_result = default_value;
}

static void sdf__create_used(void) {
  int argument = 1;

  sdf__used = SDF_MALLOC(
    sdf_boolean_t,
    sdf__argc,
    "track which command line arguments have been used"
  );

  sdf__used[0] = SDF_BOOLEAN_TRUE;

  while (argument < sdf__argc) {
    sdf__used[argument] = SDF_BOOLEAN_FALSE;
    argument++;
  }
}

static void sdf__create_lengths(void) {
  int argument = 0;

  sdf__lengths = SDF_MALLOC(
    int,
    sdf__argc,
    "track the lengths of the command line arguments"
  );

  while (argument < sdf__argc) {
    sdf__lengths[argument] = strlen(sdf__argv[argument]);
    argument++;
  }
}

static void sdf__check_whether_help(void) {
  int argument = 0;

  while (argument < sdf__argc) {
    if (
      strcmp(sdf__argv[argument], "/?") == 0
      || strcmp(sdf__argv[argument], "-h") == 0
      || strcmp(sdf__argv[argument], "--help") == 0
    ) {
      sdf__help = SDF_BOOLEAN_TRUE;
      printf("%s - %s\n", sdf_executable_name, sdf_executable_description);
      printf(
        "  usage: %s%s [options]%s\n",
        sdf_executable_usage_prefix,
        sdf_executable_name,
        sdf_executable_usage_suffix
      );
      printf("  options:\n");
      printf("    -h, --help, /?: display this message\n");
      return;
    }
    argument++;
  }

  sdf__help = SDF_BOOLEAN_FALSE;
}

static void sdf__verify_all_used(void) {
  int argument = 0;

  while (argument < sdf__argc) {
    if (!sdf__used[argument]) {
      sdf_fail("unexpected argument %s\n", sdf__argv[argument]);
    }
    argument++;
  }
}

void sdf_cli(int argc, char * argv[]) {
  sdf__argc = argc;
  sdf__argv = argv;
  sdf__create_used();
  sdf__create_lengths();
  sdf__check_whether_help();
  sdf_executable_cli();
  if (sdf__help) {
    exit(0);
  } else {
    sdf__verify_all_used();
  }
}
