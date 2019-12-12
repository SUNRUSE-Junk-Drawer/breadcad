load "../framework/main"

executable_name=sample
executable_help="sample - sample a bc stream at a single point in space
  usage: [bc stream] | sample [options]
  options:
    -h, --help, /?: display this message
    -x [number], --x [number]: location from which to sample on the x axis (millimeters) (default: 0.000000)
    -y [number], --y [number]: location from which to sample on the y axis (millimeters) (default: 0.000000)
    -z [number], --z [number]: location from which to sample on the z axis (millimeters) (default: 0.000000)"

@test "help (short name)" {
  test_help "-h"
}

@test "help (long name)" {
  test_help "--help"
}

@test "help (query)" {
  test_help "/?"
}

@test "parameter x default" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_x.bc" "0.000000"
}

@test "parameter x positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 < test/bc/parameter_x.bc" "3.260000"
}

@test "parameter x negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.26 < test/bc/parameter_x.bc" "-3.260000"
}

@test "parameter x default with y and z" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y 3.26 -z -22.15 < test/bc/parameter_x.bc" "0.000000"
}

@test "parameter x set with y and z" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 -z 14.27 < test/bc/parameter_x.bc" "3.260000"
}

@test "parameter x validation" {
  number_parameter "sample" "x" "x"
}

@test "parameter y default" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_y.bc" "0.000000"
}

@test "parameter y positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y 3.26 < test/bc/parameter_y.bc" "3.260000"
}

@test "parameter y negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y -3.26 < test/bc/parameter_y.bc" "-3.260000"
}

@test "parameter y default with x and z" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -z -22.15 < test/bc/parameter_y.bc" "0.000000"
}

@test "parameter y set with x and z" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 -z 14.27 < test/bc/parameter_y.bc" "-22.150000"
}

@test "parameter y validation" {
  number_parameter "sample" "y" "y"
}

@test "parameter z default" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_z.bc" "0.000000"
}

@test "parameter z positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -z 3.26 < test/bc/parameter_z.bc" "3.260000"
}

@test "parameter z negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -z -3.26 < test/bc/parameter_z.bc" "-3.260000"
}

@test "parameter z default with x and y" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 < test/bc/parameter_z.bc" "0.000000"
}

@test "parameter z set with x and y" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 -z 14.27 < test/bc/parameter_z.bc" "14.270000"
}

@test "parameter z validation" {
  number_parameter "sample" "z" "z"
}

@test "parameter w" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/parameter_w.bc" "0.000000"
}

@test "parameter w with x y and z" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 -z 14.27 < test/bc/parameter_w.bc" "0.000000"
}

@test "not parameter false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 -y 15.222 < test/bc/not_parameter.bc" "12.216000"
}

@test "not parameter true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 -y 12.216 < test/bc/not_parameter.bc" "12.216000"
}

@test "not constant false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/not_false.bc" "3.260000"
}

@test "not constant true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/not_true.bc" "-22.150000"
}

@test "and parameter parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/and_parameter_parameter.bc" "22.150000"
}

@test "and parameter parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 22.15 -z 3.26 < test/bc/and_parameter_parameter.bc" "22.150000"
}

@test "and parameter parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 3.26 -z 22.15 < test/bc/and_parameter_parameter.bc" "3.260000"
}

@test "and parameter parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 22.15 -y 14.27 -z 3.26 < test/bc/and_parameter_parameter.bc" "22.150000"
}

@test "and parameter constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/and_parameter_false.bc" "-22.150000"
}

@test "and parameter constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/and_parameter_true.bc" "-22.150000"
}

@test "and parameter constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/and_parameter_false.bc" "-22.150000"
}

@test "and parameter constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/and_parameter_true.bc" "3.260000"
}

@test "and constant parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/and_false_parameter.bc" "-22.150000"
}

@test "and constant parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/and_false_parameter.bc" "-22.150000"
}

@test "and constant parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/and_true_parameter.bc" "-22.150000"
}

@test "and constant parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/and_true_parameter.bc" "3.260000"
}

@test "and constant constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/and_false_false.bc" "-22.150000"
}

@test "and constant constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/and_false_true.bc" "-22.150000"
}

@test "and constant constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/and_true_false.bc" "-22.150000"
}

@test "and constant constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/and_true_true.bc" "3.260000"
}

@test "or parameter parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/or_parameter_parameter.bc" "22.150000"
}

@test "or parameter parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 22.15 -z 3.26 < test/bc/or_parameter_parameter.bc" "14.270000"
}

@test "or parameter parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 3.26 -z 22.15 < test/bc/or_parameter_parameter.bc" "14.270000"
}

@test "or parameter parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/or_parameter_parameter.bc" "22.150000"
}

@test "or parameter constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/or_parameter_false.bc" "-22.150000"
}

@test "or parameter constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/or_parameter_true.bc" "3.260000"
}

@test "or parameter constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/or_parameter_false.bc" "3.260000"
}

@test "or parameter constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/or_parameter_true.bc" "3.260000"
}

@test "or constant parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/or_false_parameter.bc" "-22.150000"
}

@test "or constant parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/or_false_parameter.bc" "3.260000"
}

@test "or constant parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/or_true_parameter.bc" "3.260000"
}

@test "or constant parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/or_true_parameter.bc" "3.260000"
}

@test "or constant constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/or_false_false.bc" "-22.150000"
}

@test "or constant constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/or_false_true.bc" "3.260000"
}

@test "or constant constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/or_true_false.bc" "3.260000"
}

@test "or constant constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/or_true_true.bc" "3.260000"
}

@test "equal parameter parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/equal_parameter_parameter.bc" "3.260000"
}

@test "equal parameter parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 22.15 -z 3.26 < test/bc/equal_parameter_parameter.bc" "22.150000"
}

@test "equal parameter parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 3.26 -z 22.15 < test/bc/equal_parameter_parameter.bc" "3.260000"
}

@test "equal parameter parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/equal_parameter_parameter.bc" "3.260000"
}

@test "equal parameter constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/equal_parameter_false.bc" "3.260000"
}

@test "equal parameter constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/equal_parameter_true.bc" "-22.150000"
}

@test "equal parameter constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/equal_parameter_false.bc" "-22.150000"
}

@test "equal parameter constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/equal_parameter_true.bc" "3.260000"
}

@test "equal constant parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/equal_false_parameter.bc" "3.260000"
}

@test "equal constant parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/equal_false_parameter.bc" "-22.150000"
}

@test "equal constant parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/equal_true_parameter.bc" "-22.150000"
}

@test "equal constant parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/equal_true_parameter.bc" "3.260000"
}

@test "equal constant constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/equal_false_false.bc" "3.260000"
}

@test "equal constant constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/equal_false_true.bc" "-22.150000"
}

@test "equal constant constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/equal_true_false.bc" "-22.150000"
}

@test "equal constant constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/equal_true_true.bc" "3.260000"
}

@test "not equal parameter parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/not_equal_parameter_parameter.bc" "22.150000"
}

@test "not equal parameter parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 22.15 -z 3.26 < test/bc/not_equal_parameter_parameter.bc" "14.270000"
}

@test "not equal parameter parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.27 -y 3.26 -z 22.15 < test/bc/not_equal_parameter_parameter.bc" "14.270000"
}

@test "not equal parameter parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y 22.15 -z 14.27 < test/bc/not_equal_parameter_parameter.bc" "22.150000"
}

@test "not equal parameter constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/not_equal_parameter_false.bc" "-22.150000"
}

@test "not equal parameter constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/not_equal_parameter_true.bc" "3.260000"
}

@test "not equal parameter constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/not_equal_parameter_false.bc" "3.260000"
}

@test "not equal parameter constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/not_equal_parameter_true.bc"  "-22.150000"
}

@test "not equal constant parameter false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/not_equal_false_parameter.bc" "-22.150000"
}

@test "not equal constant parameter false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/not_equal_false_parameter.bc" "3.260000"
}

@test "not equal constant parameter true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 2 < test/bc/not_equal_true_parameter.bc" "3.260000"
}

@test "not equal constant parameter true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2 -y 1 < test/bc/not_equal_true_parameter.bc" "-22.150000"
}

@test "not equal constant constant false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/not_equal_false_false.bc" "-22.150000"
}

@test "not equal constant constant false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/not_equal_false_true.bc" "3.260000"
}

@test "not equal constant constant true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/not_equal_true_false.bc" "3.260000"
}

@test "not equal constant constant true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/not_equal_true_true.bc" "-22.150000"
}

@test "conditional boolean parameter parameter parameter false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 -z 1 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter parameter parameter false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 -z 3 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean parameter parameter parameter false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 -z 1 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter parameter parameter false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 -z 3 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean parameter parameter parameter true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 -z 1 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter parameter parameter true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 -z 3 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter parameter parameter true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 -z 1 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean parameter parameter parameter true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 -z 3 < test/bc/conditional_boolean_parameter_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean parameter parameter constant false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 < test/bc/conditional_boolean_parameter_parameter_false.bc" "-22.150000"
}

@test "conditional boolean parameter parameter constant false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 < test/bc/conditional_boolean_parameter_parameter_true.bc" "3.260000"
}

@test "conditional boolean parameter parameter constant false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 < test/bc/conditional_boolean_parameter_parameter_false.bc" "-22.150000"
}

@test "conditional boolean parameter parameter constant false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 < test/bc/conditional_boolean_parameter_parameter_true.bc" "3.260000"
}

@test "conditional boolean parameter parameter constant true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 < test/bc/conditional_boolean_parameter_parameter_false.bc" "-22.150000"
}

@test "conditional boolean parameter parameter constant true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 < test/bc/conditional_boolean_parameter_parameter_true.bc" "-22.150000"
}

@test "conditional boolean parameter parameter constant true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 < test/bc/conditional_boolean_parameter_parameter_false.bc" "3.260000"
}

@test "conditional boolean parameter parameter constant true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 < test/bc/conditional_boolean_parameter_parameter_true.bc" "3.260000"
}

@test "conditional boolean parameter constant parameter false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 < test/bc/conditional_boolean_parameter_false_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter constant parameter false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 < test/bc/conditional_boolean_parameter_false_parameter.bc" "3.260000"
}

@test "conditional boolean parameter constant parameter false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 < test/bc/conditional_boolean_parameter_true_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter constant parameter false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 < test/bc/conditional_boolean_parameter_true_parameter.bc" "3.260000"
}

@test "conditional boolean parameter constant parameter true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 < test/bc/conditional_boolean_parameter_false_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter constant parameter true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 < test/bc/conditional_boolean_parameter_false_parameter.bc" "-22.150000"
}

@test "conditional boolean parameter constant parameter true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 < test/bc/conditional_boolean_parameter_true_parameter.bc" "3.260000"
}

@test "conditional boolean parameter constant parameter true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 < test/bc/conditional_boolean_parameter_true_parameter.bc" "3.260000"
}

@test "conditional boolean parameter constant constant false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_parameter_false_false.bc" "-22.150000"
}

@test "conditional boolean parameter constant constant false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_parameter_false_true.bc" "3.260000"
}

@test "conditional boolean parameter constant constant false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_parameter_true_false.bc" "-22.150000"
}

@test "conditional boolean parameter constant constant false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_parameter_true_true.bc" "3.260000"
}

@test "conditional boolean parameter constant constant true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_parameter_false_false.bc" "-22.150000"
}

@test "conditional boolean parameter constant constant true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_parameter_false_true.bc" "-22.150000"
}

@test "conditional boolean parameter constant constant true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_parameter_true_false.bc" "3.260000"
}

@test "conditional boolean parameter constant constant true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_parameter_true_true.bc" "3.260000"
}

@test "conditional boolean constant parameter parameter false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 < test/bc/conditional_boolean_false_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean constant parameter parameter false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 < test/bc/conditional_boolean_false_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean constant parameter parameter false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 < test/bc/conditional_boolean_false_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean constant parameter parameter false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 < test/bc/conditional_boolean_false_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean constant parameter parameter true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 1 < test/bc/conditional_boolean_true_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean constant parameter parameter true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 -y 3 < test/bc/conditional_boolean_true_parameter_parameter.bc" "-22.150000"
}

@test "conditional boolean constant parameter parameter true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 1 < test/bc/conditional_boolean_true_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean constant parameter parameter true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 -y 3 < test/bc/conditional_boolean_true_parameter_parameter.bc" "3.260000"
}

@test "conditional boolean constant parameter constant false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_false_parameter_false.bc" "-22.150000"
}

@test "conditional boolean constant parameter constant false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_false_parameter_true.bc" "3.260000"
}

@test "conditional boolean constant parameter constant false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_false_parameter_false.bc" "-22.150000"
}

@test "conditional boolean constant parameter constant false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_false_parameter_true.bc" "3.260000"
}

@test "conditional boolean constant parameter constant true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_true_parameter_false.bc" "-22.150000"
}

@test "conditional boolean constant parameter constant true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_true_parameter_true.bc" "-22.150000"
}

@test "conditional boolean constant parameter constant true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_true_parameter_false.bc" "3.260000"
}

@test "conditional boolean constant parameter constant true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_true_parameter_true.bc" "3.260000"
}

@test "conditional boolean constant constant parameter false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_false_false_parameter.bc" "-22.150000"
}

@test "conditional boolean constant constant parameter false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_false_false_parameter.bc" "3.260000"
}

@test "conditional boolean constant constant parameter false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_false_true_parameter.bc" "-22.150000"
}

@test "conditional boolean constant constant parameter false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_false_true_parameter.bc" "3.260000"
}

@test "conditional boolean constant constant parameter true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_true_false_parameter.bc" "-22.150000"
}

@test "conditional boolean constant constant parameter true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_true_false_parameter.bc" "-22.150000"
}

@test "conditional boolean constant constant parameter true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1 < test/bc/conditional_boolean_true_true_parameter.bc" "3.260000"
}

@test "conditional boolean constant constant parameter true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3 < test/bc/conditional_boolean_true_true_parameter.bc" "3.260000"
}

@test "conditional boolean constant constant constant false false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_false_false_false.bc" "-22.150000"
}

@test "conditional boolean constant constant constant false false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_false_false_true.bc" "3.260000"
}

@test "conditional boolean constant constant constant false true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_false_true_false.bc" "-22.150000"
}

@test "conditional boolean constant constant constant false true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_false_true_true.bc" "3.260000"
}

@test "conditional boolean constant constant constant true false false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_true_false_false.bc" "-22.150000"
}

@test "conditional boolean constant constant constant true false true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_true_false_true.bc" "-22.150000"
}

@test "conditional boolean constant constant constant true true false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_true_true_false.bc" "3.260000"
}

@test "conditional boolean constant constant constant true true true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_boolean_true_true_true.bc" "3.260000"
}

@test "greater than parameter parameter (false) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 -y 15.222 < test/bc/greater_than_conditional_number_x_y.bc" "15.222000"
}

@test "greater than parameter parameter (true) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 -y 12.216 < test/bc/greater_than_conditional_number_x_y.bc" "15.222000"
}

@test "greater than parameter constant (false) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 < test/bc/greater_than_conditional_number_x_constant.bc" "14.217000"
}

@test "greater than parameter constant (true) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 < test/bc/greater_than_conditional_number_x_constant.bc" "15.222000"
}

@test "greater than constant parameter (false) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 < test/bc/greater_than_conditional_number_constant_x.bc" "15.222000"
}

@test "greater than constant parameter (true) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 < test/bc/greater_than_conditional_number_constant_x.bc" "14.217000"
}

@test "greater than constant constant (false) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/greater_than_conditional_number_constant_constant_false.bc" "14.217000"
}

@test "greater than constant constant (true) -> conditional number" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/greater_than_conditional_number_constant_constant_true.bc" "15.222000"
}

@test "conditional number constant parameter parameter false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 -y 12.216 < test/bc/conditional_number_false_parameter_parameter.bc" "12.216000"
}

@test "conditional number constant parameter parameter true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 -y 12.216 < test/bc/conditional_number_true_parameter_parameter.bc" "15.222000"
}

@test "conditional number constant parameter constant false" {
check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 < test/bc/conditional_number_false_parameter_constant.bc" "-22.150000"
}

@test "conditional number constant parameter constant true" {
check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 < test/bc/conditional_number_true_parameter_constant.bc" "15.222000"
}

@test "conditional number constant constant parameter false" {
check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 < test/bc/conditional_number_false_constant_parameter.bc" "15.222000"
}

@test "conditional number constant constant parameter true" {
check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 15.222 < test/bc/conditional_number_true_constant_parameter.bc" "-22.150000"
}

@test "conditional number constant constant constant false" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_number_false_constant_constant.bc" "-22.150000"
}

@test "conditional number constant constant constant true" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/conditional_number_true_constant_constant.bc" "3.260000"
}

@test "negate positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 < test/bc/negate_x.bc" "-12.216000"
}

@test "negate negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -12.216 < test/bc/negate_x.bc" "12.216000"
}

@test "negate constant positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/negate_constant_positive.bc" "-12.216000"
}

@test "negate constant negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/negate_constant_negative.bc" "12.216000"
}

@test "sine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 < test/bc/sine_x.bc" "-0.343246"
}

@test "sine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/sine_constant.bc" "-0.343246"
}

@test "cosine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 < test/bc/cosine_x.bc" "0.939245"
}

@test "cosine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/cosine_constant.bc" "0.939245"
}

@test "tangent" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 12.216 < test/bc/tangent_x.bc" "-0.365449"
}

@test "tangent constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/tangent_constant.bc" "-0.365449"
}

@test "arc sine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/arc_sine_x.bc" "0.217716"
}

@test "arc sine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_sine_constant.bc" "0.217716"
}

@test "arc cosine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/arc_cosine_x.bc" "1.353080"
}

@test "arc cosine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_cosine_constant.bc" "1.353080"
}

@test "arc tangent" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/arc_tangent_x.bc" "0.212732"
}

@test "arc tangent constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_tangent_constant.bc" "0.212732"
}

@test "hyperbolic sine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/hyperbolic_sine_x.bc" "0.217684"
}

@test "hyperbolic sine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/hyperbolic_sine_constant.bc" "0.217684"
}

@test "hyperbolic cosine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/hyperbolic_cosine_x.bc" "1.023419"
}

@test "hyperbolic cosine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/hyperbolic_cosine_constant.bc" "1.023419"
}

@test "hyperbolic tangent" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/hyperbolic_tangent_x.bc" "0.212702"
}

@test "hyperbolic tangent constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/hyperbolic_tangent_constant.bc" "0.212702"
}

@test "hyperbolic arc sine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/hyperbolic_arc_sine_x.bc" "0.214355"
}

@test "hyperbolic arc sine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/hyperbolic_arc_sine_constant.bc" "0.214355"
}

@test "hyperbolic arc cosine" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.467 < test/bc/hyperbolic_arc_cosine_x.bc" "1.552282"
}

@test "hyperbolic arc cosine constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/hyperbolic_arc_cosine_constant.bc" "1.552282"
}

@test "hyperbolic arc tangent" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/hyperbolic_arc_tangent_x.bc" "0.219457"
}

@test "hyperbolic arc tangent constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/hyperbolic_arc_tangent_constant.bc" "0.219457"
}

@test "absolute positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/absolute_x.bc" "0.216000"
}

@test "absolute negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.216 < test/bc/absolute_x.bc" "0.216000"
}

@test "absolute constant positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/absolute_constant_positive.bc" "0.216000"
}

@test "absolute constant negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/absolute_constant_negative.bc" "0.216000"
}

@test "square root" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.61304484 < test/bc/square_root_x.bc" "2.147800"
}

@test "square root constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/square_root_constant.bc" "2.147799"
}

@test "floor -3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.1 < test/bc/floor_x.bc" "-4.000000"
}

@test "floor -2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -2.9 < test/bc/floor_x.bc" "-3.000000"
}

@test "floor -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -2.1 < test/bc/floor_x.bc" "-3.000000"
}

@test "floor -1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -1.9 < test/bc/floor_x.bc" "-2.000000"
}

@test "floor -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -1.1 < test/bc/floor_x.bc" "-2.000000"
}

@test "floor -0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.9 < test/bc/floor_x.bc" "-1.000000"
}

@test "floor -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 < test/bc/floor_x.bc" "-1.000000"
}

@test "floor 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_x.bc" "0.000000"
}

@test "floor 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 < test/bc/floor_x.bc" "0.000000"
}

@test "floor 0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.9 < test/bc/floor_x.bc" "0.000000"
}

@test "floor 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 < test/bc/floor_x.bc" "1.000000"
}

@test "floor 1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.9 < test/bc/floor_x.bc" "1.000000"
}

@test "floor 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.1 < test/bc/floor_x.bc" "2.000000"
}

@test "floor 2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.9 < test/bc/floor_x.bc" "2.000000"
}

@test "floor 3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.1 < test/bc/floor_x.bc" "3.000000"
}

@test "floor constant -3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_3.1.bc" "-4.000000"
}

@test "floor constant -2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_2.9.bc" "-3.000000"
}

@test "floor constant -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_2.1.bc" "-3.000000"
}

@test "floor constant -1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_1.9.bc" "-2.000000"
}

@test "floor constant -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_1.1.bc" "-2.000000"
}

@test "floor constant -0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_0.9.bc" "-1.000000"
}

@test "floor constant -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_negative_0.1.bc" "-1.000000"
}

@test "floor constant 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_zero.bc" "0.000000"
}

@test "floor constant 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_0.1.bc" "0.000000"
}

@test "floor constant 0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_0.9.bc" "0.000000"
}

@test "floor constant 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_1.1.bc" "1.000000"
}

@test "floor constant 1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_1.9.bc" "1.000000"
}

@test "floor constant 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_2.1.bc" "2.000000"
}

@test "floor constant 2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_2.9.bc" "2.000000"
}

@test "floor constant 3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/floor_constant_positive_3.1.bc" "3.000000"
}

@test "ceiling -3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.1 < test/bc/ceiling_x.bc" "-3.000000"
}

@test "ceiling -2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -2.9 < test/bc/ceiling_x.bc" "-2.000000"
}

@test "ceiling -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -2.1 < test/bc/ceiling_x.bc" "-2.000000"
}

@test "ceiling -1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -1.9 < test/bc/ceiling_x.bc" "-1.000000"
}

@test "ceiling -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -1.1 < test/bc/ceiling_x.bc" "-1.000000"
}

@test "ceiling -0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.9 < test/bc/ceiling_x.bc" "-0.000000"
}

@test "ceiling -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 < test/bc/ceiling_x.bc" "-0.000000"
}

@test "ceiling 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_x.bc" "0.000000"
}

@test "ceiling 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 < test/bc/ceiling_x.bc" "1.000000"
}

@test "ceiling 0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.9 < test/bc/ceiling_x.bc" "1.000000"
}

@test "ceiling 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.1 < test/bc/ceiling_x.bc" "2.000000"
}

@test "ceiling 1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 1.9 < test/bc/ceiling_x.bc" "2.000000"
}

@test "ceiling 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.1 < test/bc/ceiling_x.bc" "3.000000"
}

@test "ceiling 2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.9 < test/bc/ceiling_x.bc" "3.000000"
}

@test "ceiling 3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.1 < test/bc/ceiling_x.bc" "4.000000"
}

@test "ceiling constant -3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_3.1.bc" "-3.000000"
}

@test "ceiling constant -2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_2.9.bc" "-2.000000"
}

@test "ceiling constant -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_2.1.bc" "-2.000000"
}

@test "ceiling constant -1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_1.9.bc" "-1.000000"
}

@test "ceiling constant -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_1.1.bc" "-1.000000"
}

@test "ceiling constant -0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_0.9.bc" "-0.000000"
}

@test "ceiling constant -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_negative_0.1.bc" "-0.000000"
}

@test "ceiling constant 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_zero.bc" "0.000000"
}

@test "ceiling constant 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_0.1.bc" "1.000000"
}

@test "ceiling constant 0.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_0.9.bc" "1.000000"
}

@test "ceiling constant 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_1.1.bc" "2.000000"
}

@test "ceiling constant 1.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_1.9.bc" "2.000000"
}

@test "ceiling constant 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_2.1.bc" "3.000000"
}

@test "ceiling constant 2.9" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_2.9.bc" "3.000000"
}

@test "ceiling constant 3.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ceiling_constant_positive_3.1.bc" "4.000000"
}

@test "natural logarithm" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/natural_logarithm_x.bc" "-1.532477"
}

@test "natural logarithm constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/natural_logarithm_constant.bc" "-1.532477"
}

@test "logarithm 10" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/logarithm_10_x.bc" "-0.665546"
}

@test "logarithm 10 constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/logarithm_10_constant.bc" "-0.665546"
}

@test "natural power" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.216 < test/bc/natural_power_x.bc" "1.241102"
}

@test "natural power constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/natural_power_constant.bc" "1.241102"
}

@test "add parameter parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -11.01 < test/bc/add_x_y.bc" "-7.750000"
}

@test "add parameter constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 < test/bc/add_x_constant.bc" "-7.750000"
}

@test "add constant parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -11.01 < test/bc/add_constant_x.bc" "-7.750000"
}

@test "add constant constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/add_constant_constant.bc" "-7.750000"
}

@test "subtract parameter parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 < test/bc/subtract_x_y.bc" "25.410000"
}

@test "subtract parameter constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 < test/bc/subtract_x_constant.bc" "25.410000"
}

@test "subtract constant parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -22.15 < test/bc/subtract_constant_x.bc" "25.410000"
}

@test "subtract constant constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/subtract_constant_constant.bc" "25.410000"
}

@test "multiply parameter parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 < test/bc/multiply_x_y.bc" "-72.209000"
}

@test "multiply parameter constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 < test/bc/multiply_x_constant.bc" "-72.209000"
}

@test "multiply constant parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -22.15 < test/bc/multiply_constant_x.bc" "-72.209000"
}

@test "multiply constant constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/multiply_constant_constant.bc" "-72.209000"
}

@test "divide parameter parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 -y -22.15 < test/bc/divide_x_y.bc" "-0.147178"
}

@test "divide parameter constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 < test/bc/divide_x_constant.bc" "-0.147178"
}

@test "divide constant parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -22.15 < test/bc/divide_constant_x.bc" "-0.147178"
}

@test "divide constant constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/divide_constant_constant.bc" "-0.147178"
}

@test "pow parameter parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 22.15 -y 3.26 < test/bc/pow_x_y.bc" "24317.466797"
}

@test "pow parameter constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 22.15 < test/bc/pow_x_constant.bc" "24317.466797"
}

@test "pow constant parameter" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.26 < test/bc/pow_constant_x.bc" "24317.466797"
}

@test "pow constant constant" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/pow_constant_constant.bc" "24317.466797"
}

@test "modulo parameter parameter -2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -13.7 -y 3.45 < test/bc/modulo_x_y.bc" "-3.350000"
}

@test "modulo parameter parameter -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -10.45 -y 3.45 < test/bc/modulo_x_y.bc" "-0.100000"
}

@test "modulo parameter parameter -1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -6.8 -y 3.45 < test/bc/modulo_x_y.bc" "-3.350000"
}

@test "modulo parameter parameter -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.55 -y 3.45 < test/bc/modulo_x_y.bc" "-0.100000"
}

@test "modulo parameter parameter -0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.35 -y 3.45 < test/bc/modulo_x_y.bc" "-3.350000"
}

@test "modulo parameter parameter -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 -y 3.45 < test/bc/modulo_x_y.bc" "-0.100000"
}

@test "modulo parameter parameter 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -y 3.45 < test/bc/modulo_x_y.bc" "0.000000"
}

@test "modulo parameter parameter 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 -y 3.45 < test/bc/modulo_x_y.bc" "0.100000"
}

@test "modulo parameter parameter 0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.35 -y 3.45 < test/bc/modulo_x_y.bc" "3.350000"
}

@test "modulo parameter parameter 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.55 -y 3.45 < test/bc/modulo_x_y.bc" "0.100000"
}

@test "modulo parameter parameter 1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.8 -y 3.45 < test/bc/modulo_x_y.bc" "3.350000"
}

@test "modulo parameter parameter 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 10.45 -y 3.45 < test/bc/modulo_x_y.bc" "0.100000"
}

@test "modulo parameter parameter 2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 13.7 -y 3.45 < test/bc/modulo_x_y.bc" "3.350000"
}

@test "modulo parameter constant -2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -13.7 < test/bc/modulo_x_constant.bc" "-3.350000"
}

@test "modulo parameter constant -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -10.45 < test/bc/modulo_x_constant.bc" "-0.100000"
}

@test "modulo parameter constant -1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -6.8 < test/bc/modulo_x_constant.bc" "-3.350000"
}

@test "modulo parameter constant -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.55 < test/bc/modulo_x_constant.bc" "-0.100000"
}

@test "modulo parameter constant -0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -3.35 < test/bc/modulo_x_constant.bc" "-3.350000"
}

@test "modulo parameter constant -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -0.1 < test/bc/modulo_x_constant.bc" "-0.100000"
}

@test "modulo parameter constant 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_x_constant.bc" "0.000000"
}

@test "modulo parameter constant 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 0.1 < test/bc/modulo_x_constant.bc" "0.100000"
}

@test "modulo parameter constant 0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.35 < test/bc/modulo_x_constant.bc" "3.350000"
}

@test "modulo parameter constant 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.55 < test/bc/modulo_x_constant.bc" "0.100000"
}

@test "modulo parameter constant 1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 6.8 < test/bc/modulo_x_constant.bc" "3.350000"
}

@test "modulo parameter constant 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 10.45 < test/bc/modulo_x_constant.bc" "0.100000"
}

@test "modulo parameter constant 2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 13.7 < test/bc/modulo_x_constant.bc" "3.350000"
}

@test "modulo constant parameter -2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_negative_2.1_before_x.bc" "-3.350000"
}

@test "modulo constant parameter -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_negative_2.1_x.bc" "-0.100000"
}

@test "modulo constant parameter -1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_negative_1.1_before_x.bc" "-3.350000"
}

@test "modulo constant parameter -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_negative_1.1_x.bc" "-0.100000"
}

@test "modulo constant parameter -0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_negative_0.1_before_x.bc" "-3.350000"
}

@test "modulo constant parameter -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_negative_0.1_x.bc" "-0.100000"
}

@test "modulo constant parameter 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_zero_x.bc" "0.000000"
}

@test "modulo constant parameter 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_positive_0.1_x.bc" "0.100000"
}

@test "modulo constant parameter 0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_positive_0.1_before_x.bc" "3.350000"
}

@test "modulo constant parameter 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_positive_1.1_x.bc" "0.100000"
}

@test "modulo constant parameter 1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_positive_1.1_before_x.bc" "3.350000"
}

@test "modulo constant parameter 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_positive_2.1_x.bc" "0.100000"
}

@test "modulo constant parameter 2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.45 < test/bc/modulo_constant_positive_2.1_before_x.bc" "3.350000"
}

@test "modulo constant constant -2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_negative_2.1_before_constant.bc" "-3.350000"
}

@test "modulo constant constant -2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_negative_2.1_constant.bc" "-0.100000"
}

@test "modulo constant constant -1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_negative_1.1_before_constant.bc" "-3.350000"
}

@test "modulo constant constant -1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_negative_1.1_constant.bc" "-0.100000"
}

@test "modulo constant constant -0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_negative_0.1_before_constant.bc" "-3.350000"
}

@test "modulo constant constant -0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_negative_0.1_constant.bc" "-0.100000"
}

@test "modulo constant constant 0" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_zero_constant.bc" "0.000000"
}

@test "modulo constant constant 0.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_positive_0.1_constant.bc" "0.100000"
}

@test "modulo constant constant 0.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_positive_0.1_before_constant.bc" "3.350000"
}

@test "modulo constant constant 1.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_positive_1.1_constant.bc" "0.100000"
}

@test "modulo constant constant 1.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_positive_1.1_before_constant.bc" "3.350000"
}

@test "modulo constant constant 2.1" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_positive_2.1_constant.bc" "0.100000"
}

@test "modulo constant constant 2.1 before" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/modulo_constant_positive_2.1_before_constant.bc" "3.350000"
}

@test "arc tangent 2 parameter parameter positive negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.217 -y -37.214 < test/bc/arc_tangent_2_x_y.bc" "2.776670"
}

@test "arc tangent 2 parameter parameter positive positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.217 -y 37.214 < test/bc/arc_tangent_2_x_y.bc" "0.364923"
}

@test "arc tangent 2 parameter parameter negative positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -14.217 -y 37.214 < test/bc/arc_tangent_2_x_y.bc" "-0.364923"
}

@test "arc tangent 2 parameter parameter negative negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -14.217 -y -37.214 < test/bc/arc_tangent_2_x_y.bc" "-2.776670"
}

@test "arc tangent 2 parameter constant positive negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.217 < test/bc/arc_tangent_2_x_constant_negative.bc" "2.776670"
}

@test "arc tangent 2 parameter constant positive positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 14.217 < test/bc/arc_tangent_2_x_constant_positive.bc" "0.364923"
}

@test "arc tangent 2 parameter constant negative positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -14.217 < test/bc/arc_tangent_2_x_constant_positive.bc" "-0.364923"
}

@test "arc tangent 2 parameter constant negative negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -14.217 < test/bc/arc_tangent_2_x_constant_negative.bc" "-2.776670"
}

@test "arc tangent 2 constant parameter positive negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -37.214 < test/bc/arc_tangent_2_constant_positive_x.bc" "2.776670"
}

@test "arc tangent 2 constant parameter positive positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 37.214 < test/bc/arc_tangent_2_constant_positive_x.bc" "0.364923"
}

@test "arc tangent 2 constant parameter negative positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 37.214 < test/bc/arc_tangent_2_constant_negative_x.bc" "-0.364923"
}

@test "arc tangent 2 constant parameter negative negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x -37.214 < test/bc/arc_tangent_2_constant_negative_x.bc" "-2.776670"
}

@test "arc tangent 2 constant constant positive negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_tangent_2_constant_positive_constant_negative.bc" "2.776670"
}

@test "arc tangent 2 constant constant positive positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_tangent_2_constant_positive_constant_positive.bc" "0.364923"
}

@test "arc tangent 2 constant constant negative positive" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_tangent_2_constant_negative_constant_positive.bc" "-0.364923"
}

@test "arc tangent 2 constant constant negative negative" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/arc_tangent_2_constant_negative_constant_negative.bc" "-2.776670"
}

@test "min parameter parameter a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 -y 4.2771 < test/bc/min_x_y.bc" "3.231200"
}

@test "min parameter parameter equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 -y 3.2312 < test/bc/min_x_y.bc" "3.231200"
}

@test "min parameter parameter b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.2771 -y 3.2312 < test/bc/min_x_y.bc" "3.231200"
}

@test "min parameter constant a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.2771 < test/bc/min_x_constant.bc" "3.231200"
}

@test "min parameter constant equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 < test/bc/min_x_constant.bc" "3.231200"
}

@test "min parameter constant b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.8745 < test/bc/min_x_constant.bc" "2.874500"
}

@test "min constant parameter a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.2771 < test/bc/min_constant_x.bc" "3.231200"
}

@test "min constant parameter equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 < test/bc/min_constant_x.bc" "3.231200"
}

@test "min constant parameter b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.8745 < test/bc/min_constant_x.bc" "2.874500"
}

@test "min constant constant a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/min_constant_constant_a.bc" "3.231200"
}

@test "min constant constant equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/min_constant_constant_equal.bc" "3.231200"
}

@test "min constant constant b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/min_constant_constant_b.bc" "3.231200"
}

@test "max parameter parameter a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.2771 -y 3.2312 < test/bc/max_x_y.bc" "4.277100"
}

@test "max parameter parameter equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 -y 3.2312 < test/bc/max_x_y.bc" "3.231200"
}

@test "max parameter parameter b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 -y 4.2771 < test/bc/max_x_y.bc" "4.277100"
}

@test "max parameter constant a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.8745 < test/bc/max_x_constant.bc" "3.231200"
}

@test "max parameter constant equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 < test/bc/max_x_constant.bc" "3.231200"
}

@test "max parameter constant b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.2771 < test/bc/max_x_constant.bc" "4.277100"
}

@test "max constant parameter a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 2.8745 < test/bc/max_constant_x.bc" "3.231200"
}

@test "max constant parameter equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 3.2312 < test/bc/max_constant_x.bc" "3.231200"
}

@test "max constant parameter b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} -x 4.2771 < test/bc/max_constant_x.bc" "4.277100"
}

@test "max constant constant a" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/max_constant_constant_a.bc" "4.242350"
}

@test "max constant constant equal" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/max_constant_constant_equal.bc" "3.231200"
}

@test "max constant constant b" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/max_constant_constant_b.bc" "4.242350"
}

@test "empty" {
  check_successful "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/empty.bc" "inf"
}

@test "unsupported opcode" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unsupported_opcode.bc" "unsupported opcode 0xa8ff"
}

@test "truncated opcode" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/truncated_opcode.bc" "unexpected eof reading opcode"
}

@test "unary argument a missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_missing.bc" "unexpected eof reading argument a"
}

@test "unary argument a truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_truncated.bc" "unexpected eof reading argument a"
}

@test "unary argument a constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_missing.bc" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/unary_argument_a_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "binary argument a missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_missing.bc" "unexpected eof reading argument a"
}

@test "binary argument a truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_truncated.bc" "unexpected eof reading argument a"
}

@test "binary argument a constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_missing.bc" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_a_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "binary argument b missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_missing.bc" "unexpected eof reading argument b"
}

@test "binary argument b truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_truncated.bc" "unexpected eof reading argument b"
}

@test "binary argument b constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_missing.bc" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/binary_argument_b_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "ternary argument a missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_missing.bc" "unexpected eof reading argument a"
}

@test "ternary argument a truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_truncated.bc" "unexpected eof reading argument a"
}

@test "ternary argument a constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_missing.bc" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_a_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "ternary argument b missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_missing.bc" "unexpected eof reading argument b"
}

@test "ternary argument b truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_truncated.bc" "unexpected eof reading argument b"
}

@test "ternary argument b constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_missing.bc" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_b_constant_truncated_c.bc" "unexpected eof reading number constant"
}

@test "ternary argument c missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_missing.bc" "unexpected eof reading argument c"
}

@test "ternary argument c truncated" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_truncated.bc" "unexpected eof reading argument c"
}

@test "ternary argument c constant missing" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_missing.bc" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated a" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_truncated_a.bc" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated b" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_truncated_b.bc" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated c" {
  check_failure "${BC_EXECUTABLE_PREFIX}sample${BC_EXECUTABLE_SUFFIX} < test/bc/ternary_argument_c_constant_truncated_c.bc" "unexpected eof reading number constant"
}
