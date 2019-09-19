#include "types.h"
#include "executable.h"
#include "cli.h"

int main(int argc, char * argv[]) {
  sdf_types();
  sdf_cli(argc, argv);
  return 0;
}
