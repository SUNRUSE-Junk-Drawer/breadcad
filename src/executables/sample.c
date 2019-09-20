#include "../framework/types.h"
#include "../framework/cli.h"

const char * sdf_executable_name = "sample";
const char * sdf_executable_description = "sample a sdf stream at a single point in space";
const char * sdf_executable_usage_prefix = "[sdf stream] | ";
const char * sdf_executable_usage_suffix = "";

static sdf_f32_t sdf__x;
static sdf_f32_t sdf__y;
static sdf_f32_t sdf__z;

void sdf_executable_cli(void) {
  sdf_cli_float("x", "x", "location from which to sample (millimeters)", &sdf__x, 0.0f);
  sdf_cli_float("y", "y", "location from which to sample (millimeters)", &sdf__y, 0.0f);
  sdf_cli_float("z", "z", "location from which to sample (millimeters)", &sdf__z, 0.0f);
}
