#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "fail.h"
#include "malloc.h"
#include "types.h"
#include "executable.h"
#include "cli.h"
#include "read_bc.h"

static int bc__argc;
static char ** bc__argv;
static bc_boolean_t * bc__used;
static int * bc__lengths;
static bc_boolean_t bc__help;

static int bc__find_index(
  const char * short_name,
  const char * long_name
) {
  int argument = 0;
  while (argument < bc__argc) {
    if (!bc__used[argument]) {
      if (bc__lengths[argument] > 1 && bc__argv[argument][0] == '-') {
        if (!strcmp(&bc__argv[argument][1], short_name)) {
          bc__used[argument] = BC_BOOLEAN_TRUE;
          return argument;
        }

        if (bc__lengths[argument] > 2 && bc__argv[argument][1] == '-') {
          if (!strcmp(&bc__argv[argument][2], long_name)) {
            bc__used[argument] = BC_BOOLEAN_TRUE;
            return argument;
          }
        }
      }
    }
    argument++;
  }
  return -1;
}

static const char * bc__find_value(
  const char * short_name,
  const char * long_name
) {
  int argument = bc__find_index(short_name, long_name);

  if (argument == -1) {
    return NULL;
  }

  argument++;

  if (argument == bc__argc || bc__used[argument]) {
    bc_fail(
      "expected a value for command line argument -%s/--%s\n",
      short_name,
      long_name
    );
  }

  bc__used[argument] = BC_BOOLEAN_TRUE;
  return bc__argv[argument];
}

void bc_cli_flag(
  const char * short_name,
  const char * long_name,
  const char * description,
  bc_boolean_t * pointer_to_result
) {
  int argument;

  if (bc__help) {
    printf("    -%s, --%s: %s\n", short_name, long_name, description);
    return;
  }

  argument = bc__find_index(short_name, long_name);

  * pointer_to_result = argument != -1 ? BC_BOOLEAN_TRUE : BC_BOOLEAN_FALSE;
}

void bc_cli_number(
  const char * short_name,
  const char * long_name,
  const char * description,
  bc_number_t * pointer_to_result,
  bc_number_t default_value
) {
  const char * value;
  char waste;

  if (bc__help) {
    printf("    -%s [number], --%s [number]: %s (default: %f)\n", short_name, long_name, description, default_value);
    return;
  }

  value = bc__find_value(short_name, long_name);

  if (value) {
    if (sscanf(value, "%f%c", pointer_to_result, &waste) != 1) {
      bc_fail(
        "unable to parse command line argument -%s/--%s value \"%s\" as a number\n",
        short_name,
        long_name,
        value
      );
    }

    return;
  }

  * pointer_to_result = default_value;
}

static void bc__create_used(void) {
  int argument = 1;

  bc__used = BC_MALLOC(
    bc_boolean_t,
    bc__argc,
    "track which command line arguments have been used"
  );

  bc__used[0] = BC_BOOLEAN_TRUE;

  while (argument < bc__argc) {
    bc__used[argument] = BC_BOOLEAN_FALSE;
    argument++;
  }
}

static void bc__create_lengths(void) {
  int argument = 0;

  bc__lengths = BC_MALLOC(
    int,
    bc__argc,
    "track the lengths of the command line arguments"
  );

  while (argument < bc__argc) {
    bc__lengths[argument] = strlen(bc__argv[argument]);
    argument++;
  }
}

static void bc__check_whether_help(void) {
  int argument = 0;

  while (argument < bc__argc) {
    if (
      strcmp(bc__argv[argument], "/?") == 0
      || strcmp(bc__argv[argument], "-h") == 0
      || strcmp(bc__argv[argument], "--help") == 0
    ) {
      bc__help = BC_BOOLEAN_TRUE;
      printf("%s - %s\n", bc_executable_name, bc_executable_description);
      printf(
        "  usage: %s%s [options",
        bc_executable_usage_prefix,
        bc_executable_name
      );
      if (bc_executable_reads_models_from_command_line_arguments) {
        printf(", paths to bc streams");
      }
      printf("]%s\n", bc_executable_usage_suffix);
      printf("  options:\n");
      printf("    -h, --help, /?: display this message\n");
      return;
    }
    argument++;
  }

  bc__help = BC_BOOLEAN_FALSE;
}

static void bc__verify_all_used(void) {
  int argument = 0;

  while (argument < bc__argc) {
    if (!bc__used[argument]) {
      bc_fail("unexpected argument %s\n", bc__argv[argument]);
    }
    argument++;
  }
}

void bc_cli(int argc, char * argv[]) {
  bc__argc = argc;
  bc__argv = argv;
  bc__create_used();
  bc__create_lengths();
  bc__check_whether_help();
  bc_executable_cli();
  if (bc__help) {
    exit(0);
  } else {
    if (!bc_executable_reads_models_from_command_line_arguments) {
      bc__verify_all_used();
    }
  }
}

static void bc__read(
  int argument
) {
  FILE * file = fopen(bc__argv[argument], "rb");
  bc_read_bc(file);
  fclose(file);
}

void bc_cli_read(void) {
  int argument = 0;
  while (argument < bc__argc) {
    if (!bc__used[argument]) {
      bc__read(argument);
    }
    argument++;
  }
}
