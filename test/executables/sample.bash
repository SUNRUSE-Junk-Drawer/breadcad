load "../framework/main"

executable_name=sample
executable_help="sample - sample a sdf stream at a single point in space
  usage: [sdf stream] | sample [options]
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
  check_successful "bin/sample < test/sdf/parameter_x.sdf" "0.000000"
}

@test "parameter x positive" {
  check_successful "bin/sample -x 3.26 < test/sdf/parameter_x.sdf" "3.260000"
}

@test "parameter x negative" {
  check_successful "bin/sample -x -3.26 < test/sdf/parameter_x.sdf" "-3.260000"
}

@test "parameter x default with y and z" {
  check_successful "bin/sample -y 3.26 -z -22.15 < test/sdf/parameter_x.sdf" "0.000000"
}

@test "parameter x set with y and z" {
  check_successful "bin/sample -x 3.26 -y -22.15 -z 14.27 < test/sdf/parameter_x.sdf" "3.260000"
}

@test "parameter x validation" {
  number_parameter "sample" "x" "x"
}

@test "parameter y default" {
  check_successful "bin/sample < test/sdf/parameter_y.sdf" "0.000000"
}

@test "parameter y positive" {
  check_successful "bin/sample -y 3.26 < test/sdf/parameter_y.sdf" "3.260000"
}

@test "parameter y negative" {
  check_successful "bin/sample -y -3.26 < test/sdf/parameter_y.sdf" "-3.260000"
}

@test "parameter y default with x and z" {
  check_successful "bin/sample -x 3.26 -z -22.15 < test/sdf/parameter_y.sdf" "0.000000"
}

@test "parameter y set with x and z" {
  check_successful "bin/sample -x 3.26 -y -22.15 -z 14.27 < test/sdf/parameter_y.sdf" "-22.150000"
}

@test "parameter y validation" {
  number_parameter "sample" "y" "y"
}

@test "parameter z default" {
  check_successful "bin/sample < test/sdf/parameter_z.sdf" "0.000000"
}

@test "parameter z positive" {
  check_successful "bin/sample -z 3.26 < test/sdf/parameter_z.sdf" "3.260000"
}

@test "parameter z negative" {
  check_successful "bin/sample -z -3.26 < test/sdf/parameter_z.sdf" "-3.260000"
}

@test "parameter z default with x and y" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/parameter_z.sdf" "0.000000"
}

@test "parameter z set with x and y" {
  check_successful "bin/sample -x 3.26 -y -22.15 -z 14.27 < test/sdf/parameter_z.sdf" "14.270000"
}

@test "parameter z validation" {
  number_parameter "sample" "z" "z"
}

@test "parameter w" {
  check_successful "bin/sample < test/sdf/parameter_w.sdf" "0.000000"
}

@test "parameter w with x y and z" {
  check_successful "bin/sample -x 3.26 -y -22.15 -z 14.27 < test/sdf/parameter_w.sdf" "0.000000"
}

@test "not parameter false" {
  check_successful "bin/sample -x 12.216 -y 15.222 < test/sdf/not_parameter.sdf" "12.216000"
}

@test "not parameter true" {
  check_successful "bin/sample -x 15.222 -y 12.216 < test/sdf/not_parameter.sdf" "12.216000"
}

@test "not constant false" {
  check_successful "bin/sample < test/sdf/not_false.sdf" "3.260000"
}

@test "not constant true" {
  check_successful "bin/sample < test/sdf/not_true.sdf" "-22.150000"
}

@test "and parameter parameter false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/and_parameter_parameter.sdf" "22.150000"
}

@test "and parameter parameter false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/and_parameter_parameter.sdf" "22.150000"
}

@test "and parameter parameter true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/and_parameter_parameter.sdf" "3.260000"
}

@test "and parameter parameter true true" {
  check_successful "bin/sample -x 22.15 -y 14.27 -z 3.26 < test/sdf/and_parameter_parameter.sdf" "22.150000"
}

@test "and parameter constant false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/and_parameter_false.sdf" "-22.150000"
}

@test "and parameter constant false true" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/and_parameter_true.sdf" "-22.150000"
}

@test "and parameter constant true false" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/and_parameter_false.sdf" "-22.150000"
}

@test "and parameter constant true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/and_parameter_true.sdf" "3.260000"
}

@test "and constant parameter false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/and_false_parameter.sdf" "-22.150000"
}

@test "and constant parameter false true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/and_false_parameter.sdf" "-22.150000"
}

@test "and constant parameter true false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/and_true_parameter.sdf" "-22.150000"
}

@test "and constant parameter true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/and_true_parameter.sdf" "3.260000"
}

@test "and constant constant false false" {
  check_successful "bin/sample < test/sdf/and_false_false.sdf" "-22.150000"
}

@test "and constant constant false true" {
  check_successful "bin/sample < test/sdf/and_false_true.sdf" "-22.150000"
}

@test "and constant constant true false" {
  check_successful "bin/sample < test/sdf/and_true_false.sdf" "-22.150000"
}

@test "and constant constant true true" {
  check_successful "bin/sample < test/sdf/and_true_true.sdf" "3.260000"
}

@test "or parameter parameter false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/or_parameter_parameter.sdf" "22.150000"
}

@test "or parameter parameter false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/or_parameter_parameter.sdf" "14.270000"
}

@test "or parameter parameter true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/or_parameter_parameter.sdf" "14.270000"
}

@test "or parameter parameter true true" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/or_parameter_parameter.sdf" "22.150000"
}

@test "or parameter constant false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/or_parameter_false.sdf" "-22.150000"
}

@test "or parameter constant false true" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/or_parameter_true.sdf" "3.260000"
}

@test "or parameter constant true false" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/or_parameter_false.sdf" "3.260000"
}

@test "or parameter constant true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/or_parameter_true.sdf" "3.260000"
}

@test "or constant parameter false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/or_false_parameter.sdf" "-22.150000"
}

@test "or constant parameter false true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/or_false_parameter.sdf" "3.260000"
}

@test "or constant parameter true false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/or_true_parameter.sdf" "3.260000"
}

@test "or constant parameter true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/or_true_parameter.sdf" "3.260000"
}

@test "or constant constant false false" {
  check_successful "bin/sample < test/sdf/or_false_false.sdf" "-22.150000"
}

@test "or constant constant false true" {
  check_successful "bin/sample < test/sdf/or_false_true.sdf" "3.260000"
}

@test "or constant constant true false" {
  check_successful "bin/sample < test/sdf/or_true_false.sdf" "3.260000"
}

@test "or constant constant true true" {
  check_successful "bin/sample < test/sdf/or_true_true.sdf" "3.260000"
}

@test "equal parameter parameter false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/equal_parameter_parameter.sdf" "3.260000"
}

@test "equal parameter parameter false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/equal_parameter_parameter.sdf" "22.150000"
}

@test "equal parameter parameter true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/equal_parameter_parameter.sdf" "3.260000"
}

@test "equal parameter parameter true true" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/equal_parameter_parameter.sdf" "3.260000"
}

@test "equal parameter constant false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/equal_parameter_false.sdf" "3.260000"
}

@test "equal parameter constant false true" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/equal_parameter_true.sdf" "-22.150000"
}

@test "equal parameter constant true false" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/equal_parameter_false.sdf" "-22.150000"
}

@test "equal parameter constant true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/equal_parameter_true.sdf" "3.260000"
}

@test "equal constant parameter false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/equal_false_parameter.sdf" "3.260000"
}

@test "equal constant parameter false true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/equal_false_parameter.sdf" "-22.150000"
}

@test "equal constant parameter true false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/equal_true_parameter.sdf" "-22.150000"
}

@test "equal constant parameter true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/equal_true_parameter.sdf" "3.260000"
}

@test "equal constant constant false false" {
  check_successful "bin/sample < test/sdf/equal_false_false.sdf" "3.260000"
}

@test "equal constant constant false true" {
  check_successful "bin/sample < test/sdf/equal_false_true.sdf" "-22.150000"
}

@test "equal constant constant true false" {
  check_successful "bin/sample < test/sdf/equal_true_false.sdf" "-22.150000"
}

@test "equal constant constant true true" {
  check_successful "bin/sample < test/sdf/equal_true_true.sdf" "3.260000"
}

@test "not equal parameter parameter false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/not_equal_parameter_parameter.sdf" "22.150000"
}

@test "not equal parameter parameter false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/not_equal_parameter_parameter.sdf" "14.270000"
}

@test "not equal parameter parameter true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/not_equal_parameter_parameter.sdf" "14.270000"
}

@test "not equal parameter parameter true true" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/not_equal_parameter_parameter.sdf" "22.150000"
}

@test "not equal parameter constant false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/not_equal_parameter_false.sdf" "-22.150000"
}

@test "not equal parameter constant false true" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/not_equal_parameter_true.sdf" "3.260000"
}

@test "not equal parameter constant true false" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/not_equal_parameter_false.sdf" "3.260000"
}

@test "not equal parameter constant true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/not_equal_parameter_true.sdf"  "-22.150000"
}

@test "not equal constant parameter false false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/not_equal_false_parameter.sdf" "-22.150000"
}

@test "not equal constant parameter false true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/not_equal_false_parameter.sdf" "3.260000"
}

@test "not equal constant parameter true false" {
  check_successful "bin/sample -x 1 -y 2 < test/sdf/not_equal_true_parameter.sdf" "3.260000"
}

@test "not equal constant parameter true true" {
  check_successful "bin/sample -x 2 -y 1 < test/sdf/not_equal_true_parameter.sdf" "-22.150000"
}

@test "not equal constant constant false false" {
  check_successful "bin/sample < test/sdf/not_equal_false_false.sdf" "-22.150000"
}

@test "not equal constant constant false true" {
  check_successful "bin/sample < test/sdf/not_equal_false_true.sdf" "3.260000"
}

@test "not equal constant constant true false" {
  check_successful "bin/sample < test/sdf/not_equal_true_false.sdf" "3.260000"
}

@test "not equal constant constant true true" {
  check_successful "bin/sample < test/sdf/not_equal_true_true.sdf" "-22.150000"
}

# conditional_boolean_a is the following:
# X
# Y
# Z
# X > Z
# X > Y
# Y > Z
# X > Z ? X > Y : Y > Z
# (X > Z ? X > Y : Y > Z) ? X : Y

@test "conditional boolean false false false" {
  check_successful "bin/sample -x 12.216 -y 15.222 -z 17.775 < test/sdf/conditional_boolean_a.sdf" "15.222000"
}

@test "conditional boolean false true false" {
  check_successful "bin/sample -x 15.216 -y 12.222 -z 17.775 < test/sdf/conditional_boolean_a.sdf" "12.222000"
}

@test "conditional boolean false false true" {
  check_successful "bin/sample -x 12.216 -y 17.222 -z 15.775 < test/sdf/conditional_boolean_a.sdf" "12.216000"
}

@test "conditional boolean true true true" {
  check_successful "bin/sample -x 17.775 -y 15.222 -z 12.216 < test/sdf/conditional_boolean_a.sdf" "17.775000"
}

@test "conditional boolean true true false" {
  check_successful "bin/sample -x 17.775 -y 12.222 -z 15.216 < test/sdf/conditional_boolean_a.sdf" "17.775000"
}

# conditional_boolean_b is the following:
# X
# Y
# Z
# X > Y
# Y > Z
# X > Z
# X > Y ? Y > Z : X > Z
# (X > Y ? Y > Z : X > Z) ? X : Y

@test "conditional boolean false true true" {
  check_successful "bin/sample -x 15.216 -y 17.222 -z 12.775 < test/sdf/conditional_boolean_b.sdf" "15.216000"
}

@test "conditional boolean true false false" {
  check_successful "bin/sample -x 15.216 -y 12.222 -z 17.775 < test/sdf/conditional_boolean_b.sdf" "12.222000"
}

@test "conditional boolean true false true" {
  check_successful "bin/sample -x 17.216 -y 12.222 -z 15.775 < test/sdf/conditional_boolean_b.sdf" "12.222000"
}

@test "greater than parameter parameter (false) -> conditional number" {
  check_successful "bin/sample -x 12.216 -y 15.222 < test/sdf/greater_than_conditional_number_x_y.sdf" "15.222000"
}

@test "greater than parameter parameter (true) -> conditional number" {
  check_successful "bin/sample -x 15.222 -y 12.216 < test/sdf/greater_than_conditional_number_x_y.sdf" "15.222000"
}

@test "greater than parameter constant (false) -> conditional number" {
  check_successful "bin/sample -x 12.216 < test/sdf/greater_than_conditional_number_x_constant.sdf" "14.217000"
}

@test "greater than parameter constant (true) -> conditional number" {
  check_successful "bin/sample -x 15.222 < test/sdf/greater_than_conditional_number_x_constant.sdf" "15.222000"
}

@test "greater than constant parameter (false) -> conditional number" {
  check_successful "bin/sample -x 15.222 < test/sdf/greater_than_conditional_number_constant_x.sdf" "15.222000"
}

@test "greater than constant parameter (true) -> conditional number" {
  check_successful "bin/sample -x 12.216 < test/sdf/greater_than_conditional_number_constant_x.sdf" "14.217000"
}

@test "greater than constant constant (false) -> conditional number" {
  check_successful "bin/sample < test/sdf/greater_than_conditional_number_constant_constant_false.sdf" "14.217000"
}

@test "greater than constant constant (true) -> conditional number" {
  check_successful "bin/sample < test/sdf/greater_than_conditional_number_constant_constant_true.sdf" "15.222000"
}

@test "conditional number constant parameter parameter false" {
  check_successful "bin/sample -x 15.222 -y 12.216 < test/sdf/conditional_number_false_parameter_parameter.sdf" "12.216000"
}

@test "conditional number constant parameter parameter true" {
  check_successful "bin/sample -x 15.222 -y 12.216 < test/sdf/conditional_number_true_parameter_parameter.sdf" "15.222000"
}

@test "conditional number constant parameter constant false" {
check_successful "bin/sample -x 15.222 < test/sdf/conditional_number_false_parameter_constant.sdf" "-22.150000"
}

@test "conditional number constant parameter constant true" {
check_successful "bin/sample -x 15.222 < test/sdf/conditional_number_true_parameter_constant.sdf" "15.222000"
}

@test "conditional number constant constant parameter false" {
check_successful "bin/sample -x 15.222 < test/sdf/conditional_number_false_constant_parameter.sdf" "15.222000"
}

@test "conditional number constant constant parameter true" {
check_successful "bin/sample -x 15.222 < test/sdf/conditional_number_true_constant_parameter.sdf" "-22.150000"
}

@test "conditional number constant constant constant false" {
  check_successful "bin/sample < test/sdf/conditional_number_false_constant_constant.sdf" "-22.150000"
}

@test "conditional number constant constant constant true" {
  check_successful "bin/sample < test/sdf/conditional_number_true_constant_constant.sdf" "3.260000"
}

@test "negate positive" {
  check_successful "bin/sample -x 12.216 < test/sdf/negate_x.sdf" "-12.216000"
}

@test "negate negative" {
  check_successful "bin/sample -x -12.216 < test/sdf/negate_x.sdf" "12.216000"
}

@test "negate constant positive" {
  check_successful "bin/sample < test/sdf/negate_constant_positive.sdf" "-12.216000"
}

@test "negate constant negative" {
  check_successful "bin/sample < test/sdf/negate_constant_negative.sdf" "12.216000"
}

@test "sine" {
  check_successful "bin/sample -x 12.216 < test/sdf/sine_x.sdf" "-0.343246"
}

@test "sine constant" {
  check_successful "bin/sample < test/sdf/sine_constant.sdf" "-0.343246"
}

@test "cosine" {
  check_successful "bin/sample -x 12.216 < test/sdf/cosine_x.sdf" "0.939245"
}

@test "cosine constant" {
  check_successful "bin/sample < test/sdf/cosine_constant.sdf" "0.939245"
}

@test "tangent" {
  check_successful "bin/sample -x 12.216 < test/sdf/tangent_x.sdf" "-0.365449"
}

@test "tangent constant" {
  check_successful "bin/sample < test/sdf/tangent_constant.sdf" "-0.365449"
}

@test "arc sine" {
  check_successful "bin/sample -x 0.216 < test/sdf/arc_sine_x.sdf" "0.217716"
}

@test "arc sine constant" {
  check_successful "bin/sample < test/sdf/arc_sine_constant.sdf" "0.217716"
}

@test "arc cosine" {
  check_successful "bin/sample -x 0.216 < test/sdf/arc_cosine_x.sdf" "1.353080"
}

@test "arc cosine constant" {
  check_successful "bin/sample < test/sdf/arc_cosine_constant.sdf" "1.353080"
}

@test "arc tangent" {
  check_successful "bin/sample -x 0.216 < test/sdf/arc_tangent_x.sdf" "0.212732"
}

@test "arc tangent constant" {
  check_successful "bin/sample < test/sdf/arc_tangent_constant.sdf" "0.212732"
}

@test "hyperbolic sine" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_sine_x.sdf" "0.217684"
}

@test "hyperbolic sine constant" {
  check_successful "bin/sample < test/sdf/hyperbolic_sine_constant.sdf" "0.217684"
}

@test "hyperbolic cosine" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_cosine_x.sdf" "1.023419"
}

@test "hyperbolic cosine constant" {
  check_successful "bin/sample < test/sdf/hyperbolic_cosine_constant.sdf" "1.023419"
}

@test "hyperbolic tangent" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_tangent_x.sdf" "0.212702"
}

@test "hyperbolic tangent constant" {
  check_successful "bin/sample < test/sdf/hyperbolic_tangent_constant.sdf" "0.212702"
}

@test "hyperbolic arc sine" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_arc_sine_x.sdf" "0.214355"
}

@test "hyperbolic arc sine constant" {
  check_successful "bin/sample < test/sdf/hyperbolic_arc_sine_constant.sdf" "0.214355"
}

@test "hyperbolic arc cosine" {
  check_successful "bin/sample -x 2.467 < test/sdf/hyperbolic_arc_cosine_x.sdf" "1.552282"
}

@test "hyperbolic arc cosine constant" {
  check_successful "bin/sample < test/sdf/hyperbolic_arc_cosine_constant.sdf" "1.552282"
}

@test "hyperbolic arc tangent" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_arc_tangent_x.sdf" "0.219457"
}

@test "hyperbolic arc tangent constant" {
  check_successful "bin/sample < test/sdf/hyperbolic_arc_tangent_constant.sdf" "0.219457"
}

@test "absolute positive" {
  check_successful "bin/sample -x 0.216 < test/sdf/absolute_x.sdf" "0.216000"
}

@test "absolute negative" {
  check_successful "bin/sample -x -0.216 < test/sdf/absolute_x.sdf" "0.216000"
}

@test "absolute constant positive" {
  check_successful "bin/sample < test/sdf/absolute_constant_positive.sdf" "0.216000"
}

@test "absolute constant negative" {
  check_successful "bin/sample < test/sdf/absolute_constant_negative.sdf" "0.216000"
}

@test "square root" {
  check_successful "bin/sample -x 4.61304484 < test/sdf/square_root_x.sdf" "2.147800"
}

@test "square root constant" {
  check_successful "bin/sample < test/sdf/square_root_constant.sdf" "2.147799"
}

@test "floor -3.1" {
  check_successful "bin/sample -x -3.1 < test/sdf/floor_x.sdf" "-4.000000"
}

@test "floor -2.9" {
  check_successful "bin/sample -x -2.9 < test/sdf/floor_x.sdf" "-3.000000"
}

@test "floor -2.1" {
  check_successful "bin/sample -x -2.1 < test/sdf/floor_x.sdf" "-3.000000"
}

@test "floor -1.9" {
  check_successful "bin/sample -x -1.9 < test/sdf/floor_x.sdf" "-2.000000"
}

@test "floor -1.1" {
  check_successful "bin/sample -x -1.1 < test/sdf/floor_x.sdf" "-2.000000"
}

@test "floor -0.9" {
  check_successful "bin/sample -x -0.9 < test/sdf/floor_x.sdf" "-1.000000"
}

@test "floor -0.1" {
  check_successful "bin/sample -x -0.1 < test/sdf/floor_x.sdf" "-1.000000"
}

@test "floor 0" {
  check_successful "bin/sample < test/sdf/floor_x.sdf" "0.000000"
}

@test "floor 0.1" {
  check_successful "bin/sample -x 0.1 < test/sdf/floor_x.sdf" "0.000000"
}

@test "floor 0.9" {
  check_successful "bin/sample -x 0.9 < test/sdf/floor_x.sdf" "0.000000"
}

@test "floor 1.1" {
  check_successful "bin/sample -x 1.1 < test/sdf/floor_x.sdf" "1.000000"
}

@test "floor 1.9" {
  check_successful "bin/sample -x 1.9 < test/sdf/floor_x.sdf" "1.000000"
}

@test "floor 2.1" {
  check_successful "bin/sample -x 2.1 < test/sdf/floor_x.sdf" "2.000000"
}

@test "floor 2.9" {
  check_successful "bin/sample -x 2.9 < test/sdf/floor_x.sdf" "2.000000"
}

@test "floor 3.1" {
  check_successful "bin/sample -x 3.1 < test/sdf/floor_x.sdf" "3.000000"
}

@test "floor constant -3.1" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_3.1.sdf" "-4.000000"
}

@test "floor constant -2.9" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_2.9.sdf" "-3.000000"
}

@test "floor constant -2.1" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_2.1.sdf" "-3.000000"
}

@test "floor constant -1.9" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_1.9.sdf" "-2.000000"
}

@test "floor constant -1.1" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_1.1.sdf" "-2.000000"
}

@test "floor constant -0.9" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_0.9.sdf" "-1.000000"
}

@test "floor constant -0.1" {
  check_successful "bin/sample < test/sdf/floor_constant_negative_0.1.sdf" "-1.000000"
}

@test "floor constant 0" {
  check_successful "bin/sample < test/sdf/floor_constant_zero.sdf" "0.000000"
}

@test "floor constant 0.1" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_0.1.sdf" "0.000000"
}

@test "floor constant 0.9" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_0.9.sdf" "0.000000"
}

@test "floor constant 1.1" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_1.1.sdf" "1.000000"
}

@test "floor constant 1.9" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_1.9.sdf" "1.000000"
}

@test "floor constant 2.1" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_2.1.sdf" "2.000000"
}

@test "floor constant 2.9" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_2.9.sdf" "2.000000"
}

@test "floor constant 3.1" {
  check_successful "bin/sample < test/sdf/floor_constant_positive_3.1.sdf" "3.000000"
}

@test "ceiling -3.1" {
  check_successful "bin/sample -x -3.1 < test/sdf/ceiling_x.sdf" "-3.000000"
}

@test "ceiling -2.9" {
  check_successful "bin/sample -x -2.9 < test/sdf/ceiling_x.sdf" "-2.000000"
}

@test "ceiling -2.1" {
  check_successful "bin/sample -x -2.1 < test/sdf/ceiling_x.sdf" "-2.000000"
}

@test "ceiling -1.9" {
  check_successful "bin/sample -x -1.9 < test/sdf/ceiling_x.sdf" "-1.000000"
}

@test "ceiling -1.1" {
  check_successful "bin/sample -x -1.1 < test/sdf/ceiling_x.sdf" "-1.000000"
}

@test "ceiling -0.9" {
  check_successful "bin/sample -x -0.9 < test/sdf/ceiling_x.sdf" "-0.000000"
}

@test "ceiling -0.1" {
  check_successful "bin/sample -x -0.1 < test/sdf/ceiling_x.sdf" "-0.000000"
}

@test "ceiling 0" {
  check_successful "bin/sample < test/sdf/ceiling_x.sdf" "0.000000"
}

@test "ceiling 0.1" {
  check_successful "bin/sample -x 0.1 < test/sdf/ceiling_x.sdf" "1.000000"
}

@test "ceiling 0.9" {
  check_successful "bin/sample -x 0.9 < test/sdf/ceiling_x.sdf" "1.000000"
}

@test "ceiling 1.1" {
  check_successful "bin/sample -x 1.1 < test/sdf/ceiling_x.sdf" "2.000000"
}

@test "ceiling 1.9" {
  check_successful "bin/sample -x 1.9 < test/sdf/ceiling_x.sdf" "2.000000"
}

@test "ceiling 2.1" {
  check_successful "bin/sample -x 2.1 < test/sdf/ceiling_x.sdf" "3.000000"
}

@test "ceiling 2.9" {
  check_successful "bin/sample -x 2.9 < test/sdf/ceiling_x.sdf" "3.000000"
}

@test "ceiling 3.1" {
  check_successful "bin/sample -x 3.1 < test/sdf/ceiling_x.sdf" "4.000000"
}

@test "ceiling constant -3.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_3.1.sdf" "-3.000000"
}

@test "ceiling constant -2.9" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_2.9.sdf" "-2.000000"
}

@test "ceiling constant -2.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_2.1.sdf" "-2.000000"
}

@test "ceiling constant -1.9" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_1.9.sdf" "-1.000000"
}

@test "ceiling constant -1.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_1.1.sdf" "-1.000000"
}

@test "ceiling constant -0.9" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_0.9.sdf" "-0.000000"
}

@test "ceiling constant -0.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_negative_0.1.sdf" "-0.000000"
}

@test "ceiling constant 0" {
  check_successful "bin/sample < test/sdf/ceiling_constant_zero.sdf" "0.000000"
}

@test "ceiling constant 0.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_0.1.sdf" "1.000000"
}

@test "ceiling constant 0.9" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_0.9.sdf" "1.000000"
}

@test "ceiling constant 1.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_1.1.sdf" "2.000000"
}

@test "ceiling constant 1.9" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_1.9.sdf" "2.000000"
}

@test "ceiling constant 2.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_2.1.sdf" "3.000000"
}

@test "ceiling constant 2.9" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_2.9.sdf" "3.000000"
}

@test "ceiling constant 3.1" {
  check_successful "bin/sample < test/sdf/ceiling_constant_positive_3.1.sdf" "4.000000"
}

@test "natural logarithm" {
  check_successful "bin/sample -x 0.216 < test/sdf/natural_logarithm_x.sdf" "-1.532477"
}

@test "natural logarithm constant" {
  check_successful "bin/sample < test/sdf/natural_logarithm_constant.sdf" "-1.532477"
}

@test "logarithm 10" {
  check_successful "bin/sample -x 0.216 < test/sdf/logarithm_10_x.sdf" "-0.665546"
}

@test "logarithm 10 constant" {
  check_successful "bin/sample < test/sdf/logarithm_10_constant.sdf" "-0.665546"
}

@test "natural power" {
  check_successful "bin/sample -x 0.216 < test/sdf/natural_power_x.sdf" "1.241102"
}

@test "natural power constant" {
  check_successful "bin/sample < test/sdf/natural_power_constant.sdf" "1.241102"
}

@test "add parameter parameter" {
  check_successful "bin/sample -x 3.26 -y -11.01 < test/sdf/add_x_y.sdf" "-7.750000"
}

@test "add parameter constant" {
  check_successful "bin/sample -x 3.26 < test/sdf/add_x_constant.sdf" "-7.750000"
}

@test "add constant parameter" {
  check_successful "bin/sample -x -11.01 < test/sdf/add_constant_x.sdf" "-7.750000"
}

@test "add constant constant" {
  check_successful "bin/sample < test/sdf/add_constant_constant.sdf" "-7.750000"
}

@test "subtract parameter parameter" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/subtract_x_y.sdf" "25.410000"
}

@test "subtract parameter constant" {
  check_successful "bin/sample -x 3.26 < test/sdf/subtract_x_constant.sdf" "25.410000"
}

@test "subtract constant parameter" {
  check_successful "bin/sample -x -22.15 < test/sdf/subtract_constant_x.sdf" "25.410000"
}

@test "subtract constant constant" {
  check_successful "bin/sample < test/sdf/subtract_constant_constant.sdf" "25.410000"
}

@test "multiply parameter parameter" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/multiply_x_y.sdf" "-72.209000"
}

@test "multiply parameter constant" {
  check_successful "bin/sample -x 3.26 < test/sdf/multiply_x_constant.sdf" "-72.209000"
}

@test "multiply constant parameter" {
  check_successful "bin/sample -x -22.15 < test/sdf/multiply_constant_x.sdf" "-72.209000"
}

@test "multiply constant constant" {
  check_successful "bin/sample < test/sdf/multiply_constant_constant.sdf" "-72.209000"
}

@test "divide parameter parameter" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/divide_x_y.sdf" "-0.147178"
}

@test "divide parameter constant" {
  check_successful "bin/sample -x 3.26 < test/sdf/divide_x_constant.sdf" "-0.147178"
}

@test "divide constant parameter" {
  check_successful "bin/sample -x -22.15 < test/sdf/divide_constant_x.sdf" "-0.147178"
}

@test "divide constant constant" {
  check_successful "bin/sample < test/sdf/divide_constant_constant.sdf" "-0.147178"
}

@test "pow parameter parameter" {
  check_successful "bin/sample -x 22.15 -y 3.26 < test/sdf/pow_x_y.sdf" "24317.466797"
}

@test "pow parameter constant" {
  check_successful "bin/sample -x 22.15 < test/sdf/pow_x_constant.sdf" "24317.466797"
}

@test "pow constant parameter" {
  check_successful "bin/sample -x 3.26 < test/sdf/pow_constant_x.sdf" "24317.466797"
}

@test "pow constant constant" {
  check_successful "bin/sample < test/sdf/pow_constant_constant.sdf" "24317.466797"
}

@test "modulo parameter parameter -2.1 before" {
  check_successful "bin/sample -x -13.7 -y 3.45 < test/sdf/modulo_x_y.sdf" "-3.350000"
}

@test "modulo parameter parameter -2.1" {
  check_successful "bin/sample -x -10.45 -y 3.45 < test/sdf/modulo_x_y.sdf" "-0.100000"
}

@test "modulo parameter parameter -1.1 before" {
  check_successful "bin/sample -x -6.8 -y 3.45 < test/sdf/modulo_x_y.sdf" "-3.350000"
}

@test "modulo parameter parameter -1.1" {
  check_successful "bin/sample -x -3.55 -y 3.45 < test/sdf/modulo_x_y.sdf" "-0.100000"
}

@test "modulo parameter parameter -0.1 before" {
  check_successful "bin/sample -x -3.35 -y 3.45 < test/sdf/modulo_x_y.sdf" "-3.350000"
}

@test "modulo parameter parameter -0.1" {
  check_successful "bin/sample -x -0.1 -y 3.45 < test/sdf/modulo_x_y.sdf" "-0.100000"
}

@test "modulo parameter parameter 0" {
  check_successful "bin/sample -y 3.45 < test/sdf/modulo_x_y.sdf" "0.000000"
}

@test "modulo parameter parameter 0.1" {
  check_successful "bin/sample -x 0.1 -y 3.45 < test/sdf/modulo_x_y.sdf" "0.100000"
}

@test "modulo parameter parameter 0.1 before" {
  check_successful "bin/sample -x 3.35 -y 3.45 < test/sdf/modulo_x_y.sdf" "3.350000"
}

@test "modulo parameter parameter 1.1" {
  check_successful "bin/sample -x 3.55 -y 3.45 < test/sdf/modulo_x_y.sdf" "0.100000"
}

@test "modulo parameter parameter 1.1 before" {
  check_successful "bin/sample -x 6.8 -y 3.45 < test/sdf/modulo_x_y.sdf" "3.350000"
}

@test "modulo parameter parameter 2.1" {
  check_successful "bin/sample -x 10.45 -y 3.45 < test/sdf/modulo_x_y.sdf" "0.100000"
}

@test "modulo parameter parameter 2.1 before" {
  check_successful "bin/sample -x 13.7 -y 3.45 < test/sdf/modulo_x_y.sdf" "3.350000"
}

@test "modulo parameter constant -2.1 before" {
  check_successful "bin/sample -x -13.7 < test/sdf/modulo_x_constant.sdf" "-3.350000"
}

@test "modulo parameter constant -2.1" {
  check_successful "bin/sample -x -10.45 < test/sdf/modulo_x_constant.sdf" "-0.100000"
}

@test "modulo parameter constant -1.1 before" {
  check_successful "bin/sample -x -6.8 < test/sdf/modulo_x_constant.sdf" "-3.350000"
}

@test "modulo parameter constant -1.1" {
  check_successful "bin/sample -x -3.55 < test/sdf/modulo_x_constant.sdf" "-0.100000"
}

@test "modulo parameter constant -0.1 before" {
  check_successful "bin/sample -x -3.35 < test/sdf/modulo_x_constant.sdf" "-3.350000"
}

@test "modulo parameter constant -0.1" {
  check_successful "bin/sample -x -0.1 < test/sdf/modulo_x_constant.sdf" "-0.100000"
}

@test "modulo parameter constant 0" {
  check_successful "bin/sample < test/sdf/modulo_x_constant.sdf" "0.000000"
}

@test "modulo parameter constant 0.1" {
  check_successful "bin/sample -x 0.1 < test/sdf/modulo_x_constant.sdf" "0.100000"
}

@test "modulo parameter constant 0.1 before" {
  check_successful "bin/sample -x 3.35 < test/sdf/modulo_x_constant.sdf" "3.350000"
}

@test "modulo parameter constant 1.1" {
  check_successful "bin/sample -x 3.55 < test/sdf/modulo_x_constant.sdf" "0.100000"
}

@test "modulo parameter constant 1.1 before" {
  check_successful "bin/sample -x 6.8 < test/sdf/modulo_x_constant.sdf" "3.350000"
}

@test "modulo parameter constant 2.1" {
  check_successful "bin/sample -x 10.45 < test/sdf/modulo_x_constant.sdf" "0.100000"
}

@test "modulo parameter constant 2.1 before" {
  check_successful "bin/sample -x 13.7 < test/sdf/modulo_x_constant.sdf" "3.350000"
}

@test "modulo constant parameter -2.1 before" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_negative_2.1_before_x.sdf" "-3.350000"
}

@test "modulo constant parameter -2.1" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_negative_2.1_x.sdf" "-0.100000"
}

@test "modulo constant parameter -1.1 before" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_negative_1.1_before_x.sdf" "-3.350000"
}

@test "modulo constant parameter -1.1" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_negative_1.1_x.sdf" "-0.100000"
}

@test "modulo constant parameter -0.1 before" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_negative_0.1_before_x.sdf" "-3.350000"
}

@test "modulo constant parameter -0.1" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_negative_0.1_x.sdf" "-0.100000"
}

@test "modulo constant parameter 0" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_zero_x.sdf" "0.000000"
}

@test "modulo constant parameter 0.1" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_positive_0.1_x.sdf" "0.100000"
}

@test "modulo constant parameter 0.1 before" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_positive_0.1_before_x.sdf" "3.350000"
}

@test "modulo constant parameter 1.1" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_positive_1.1_x.sdf" "0.100000"
}

@test "modulo constant parameter 1.1 before" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_positive_1.1_before_x.sdf" "3.350000"
}

@test "modulo constant parameter 2.1" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_positive_2.1_x.sdf" "0.100000"
}

@test "modulo constant parameter 2.1 before" {
  check_successful "bin/sample -x 3.45 < test/sdf/modulo_constant_positive_2.1_before_x.sdf" "3.350000"
}

@test "modulo constant constant -2.1 before" {
  check_successful "bin/sample < test/sdf/modulo_constant_negative_2.1_before_constant.sdf" "-3.350000"
}

@test "modulo constant constant -2.1" {
  check_successful "bin/sample < test/sdf/modulo_constant_negative_2.1_constant.sdf" "-0.100000"
}

@test "modulo constant constant -1.1 before" {
  check_successful "bin/sample < test/sdf/modulo_constant_negative_1.1_before_constant.sdf" "-3.350000"
}

@test "modulo constant constant -1.1" {
  check_successful "bin/sample < test/sdf/modulo_constant_negative_1.1_constant.sdf" "-0.100000"
}

@test "modulo constant constant -0.1 before" {
  check_successful "bin/sample < test/sdf/modulo_constant_negative_0.1_before_constant.sdf" "-3.350000"
}

@test "modulo constant constant -0.1" {
  check_successful "bin/sample < test/sdf/modulo_constant_negative_0.1_constant.sdf" "-0.100000"
}

@test "modulo constant constant 0" {
  check_successful "bin/sample < test/sdf/modulo_constant_zero_constant.sdf" "0.000000"
}

@test "modulo constant constant 0.1" {
  check_successful "bin/sample < test/sdf/modulo_constant_positive_0.1_constant.sdf" "0.100000"
}

@test "modulo constant constant 0.1 before" {
  check_successful "bin/sample < test/sdf/modulo_constant_positive_0.1_before_constant.sdf" "3.350000"
}

@test "modulo constant constant 1.1" {
  check_successful "bin/sample < test/sdf/modulo_constant_positive_1.1_constant.sdf" "0.100000"
}

@test "modulo constant constant 1.1 before" {
  check_successful "bin/sample < test/sdf/modulo_constant_positive_1.1_before_constant.sdf" "3.350000"
}

@test "modulo constant constant 2.1" {
  check_successful "bin/sample < test/sdf/modulo_constant_positive_2.1_constant.sdf" "0.100000"
}

@test "modulo constant constant 2.1 before" {
  check_successful "bin/sample < test/sdf/modulo_constant_positive_2.1_before_constant.sdf" "3.350000"
}

@test "arc tangent 2 parameter parameter positive negative" {
  check_successful "bin/sample -x 14.217 -y -37.214 < test/sdf/arc_tangent_2_x_y.sdf" "2.776670"
}

@test "arc tangent 2 parameter parameter positive positive" {
  check_successful "bin/sample -x 14.217 -y 37.214 < test/sdf/arc_tangent_2_x_y.sdf" "0.364923"
}

@test "arc tangent 2 parameter parameter negative positive" {
  check_successful "bin/sample -x -14.217 -y 37.214 < test/sdf/arc_tangent_2_x_y.sdf" "-0.364923"
}

@test "arc tangent 2 parameter parameter negative negative" {
  check_successful "bin/sample -x -14.217 -y -37.214 < test/sdf/arc_tangent_2_x_y.sdf" "-2.776670"
}

@test "arc tangent 2 parameter constant positive negative" {
  check_successful "bin/sample -x 14.217 < test/sdf/arc_tangent_2_x_constant_negative.sdf" "2.776670"
}

@test "arc tangent 2 parameter constant positive positive" {
  check_successful "bin/sample -x 14.217 < test/sdf/arc_tangent_2_x_constant_positive.sdf" "0.364923"
}

@test "arc tangent 2 parameter constant negative positive" {
  check_successful "bin/sample -x -14.217 < test/sdf/arc_tangent_2_x_constant_positive.sdf" "-0.364923"
}

@test "arc tangent 2 parameter constant negative negative" {
  check_successful "bin/sample -x -14.217 < test/sdf/arc_tangent_2_x_constant_negative.sdf" "-2.776670"
}

@test "arc tangent 2 constant parameter positive negative" {
  check_successful "bin/sample -x -37.214 < test/sdf/arc_tangent_2_constant_positive_x.sdf" "2.776670"
}

@test "arc tangent 2 constant parameter positive positive" {
  check_successful "bin/sample -x 37.214 < test/sdf/arc_tangent_2_constant_positive_x.sdf" "0.364923"
}

@test "arc tangent 2 constant parameter negative positive" {
  check_successful "bin/sample -x 37.214 < test/sdf/arc_tangent_2_constant_negative_x.sdf" "-0.364923"
}

@test "arc tangent 2 constant parameter negative negative" {
  check_successful "bin/sample -x -37.214 < test/sdf/arc_tangent_2_constant_negative_x.sdf" "-2.776670"
}

@test "arc tangent 2 constant constant positive negative" {
  check_successful "bin/sample < test/sdf/arc_tangent_2_constant_positive_constant_negative.sdf" "2.776670"
}

@test "arc tangent 2 constant constant positive positive" {
  check_successful "bin/sample < test/sdf/arc_tangent_2_constant_positive_constant_positive.sdf" "0.364923"
}

@test "arc tangent 2 constant constant negative positive" {
  check_successful "bin/sample < test/sdf/arc_tangent_2_constant_negative_constant_positive.sdf" "-0.364923"
}

@test "arc tangent 2 constant constant negative negative" {
  check_successful "bin/sample < test/sdf/arc_tangent_2_constant_negative_constant_negative.sdf" "-2.776670"
}

@test "min parameter parameter a" {
  check_successful "bin/sample -x 3.2312 -y 4.2771 < test/sdf/min_x_y.sdf" "3.231200"
}

@test "min parameter parameter equal" {
  check_successful "bin/sample -x 3.2312 -y 3.2312 < test/sdf/min_x_y.sdf" "3.231200"
}

@test "min parameter parameter b" {
  check_successful "bin/sample -x 4.2771 -y 3.2312 < test/sdf/min_x_y.sdf" "3.231200"
}

@test "min parameter constant a" {
  check_successful "bin/sample -x 4.2771 < test/sdf/min_x_constant.sdf" "3.231200"
}

@test "min parameter constant equal" {
  check_successful "bin/sample -x 3.2312 < test/sdf/min_x_constant.sdf" "3.231200"
}

@test "min parameter constant b" {
  check_successful "bin/sample -x 2.8745 < test/sdf/min_x_constant.sdf" "2.874500"
}

@test "min constant parameter a" {
  check_successful "bin/sample -x 4.2771 < test/sdf/min_constant_x.sdf" "3.231200"
}

@test "min constant parameter equal" {
  check_successful "bin/sample -x 3.2312 < test/sdf/min_constant_x.sdf" "3.231200"
}

@test "min constant parameter b" {
  check_successful "bin/sample -x 2.8745 < test/sdf/min_constant_x.sdf" "2.874500"
}

@test "min constant constant a" {
  check_successful "bin/sample < test/sdf/min_constant_constant_a.sdf" "3.231200"
}

@test "min constant constant equal" {
  check_successful "bin/sample < test/sdf/min_constant_constant_equal.sdf" "3.231200"
}

@test "min constant constant b" {
  check_successful "bin/sample < test/sdf/min_constant_constant_b.sdf" "3.231200"
}

@test "max parameter parameter a" {
  check_successful "bin/sample -x 4.2771 -y 3.2312 < test/sdf/max_x_y.sdf" "4.277100"
}

@test "max parameter parameter equal" {
  check_successful "bin/sample -x 3.2312 -y 3.2312 < test/sdf/max_x_y.sdf" "3.231200"
}

@test "max parameter parameter b" {
  check_successful "bin/sample -x 3.2312 -y 4.2771 < test/sdf/max_x_y.sdf" "4.277100"
}

@test "max parameter constant a" {
  check_successful "bin/sample -x 2.8745 < test/sdf/max_x_constant.sdf" "3.231200"
}

@test "max parameter constant equal" {
  check_successful "bin/sample -x 3.2312 < test/sdf/max_x_constant.sdf" "3.231200"
}

@test "max parameter constant b" {
  check_successful "bin/sample -x 4.2771 < test/sdf/max_x_constant.sdf" "4.277100"
}

@test "max constant parameter a" {
  check_successful "bin/sample -x 2.8745 < test/sdf/max_constant_x.sdf" "3.231200"
}

@test "max constant parameter equal" {
  check_successful "bin/sample -x 3.2312 < test/sdf/max_constant_x.sdf" "3.231200"
}

@test "max constant parameter b" {
  check_successful "bin/sample -x 4.2771 < test/sdf/max_constant_x.sdf" "4.277100"
}

@test "max constant constant a" {
  check_successful "bin/sample < test/sdf/max_constant_constant_a.sdf" "4.242350"
}

@test "max constant constant equal" {
  check_successful "bin/sample < test/sdf/max_constant_constant_equal.sdf" "3.231200"
}

@test "max constant constant b" {
  check_successful "bin/sample < test/sdf/max_constant_constant_b.sdf" "4.242350"
}

@test "empty" {
  check_successful "bin/sample < test/sdf/empty.sdf" "inf"
}

@test "unsupported opcode" {
  check_failure "bin/sample < test/sdf/unsupported_opcode.sdf" "unsupported opcode 0xa8ff"
}

@test "truncated opcode" {
  check_failure "bin/sample < test/sdf/truncated_opcode.sdf" "unexpected eof reading opcode"
}

@test "unary argument a missing" {
  check_failure "bin/sample < test/sdf/unary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "unary argument a truncated" {
  check_failure "bin/sample < test/sdf/unary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "unary argument a constant missing" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated a" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated b" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "unary argument a constant truncated c" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "binary argument a missing" {
  check_failure "bin/sample < test/sdf/binary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "binary argument a truncated" {
  check_failure "bin/sample < test/sdf/binary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "binary argument a constant missing" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated a" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated b" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "binary argument a constant truncated c" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "binary argument b missing" {
  check_failure "bin/sample < test/sdf/binary_argument_b_missing.sdf" "unexpected eof reading argument b"
}

@test "binary argument b truncated" {
  check_failure "bin/sample < test/sdf/binary_argument_b_truncated.sdf" "unexpected eof reading argument b"
}

@test "binary argument b constant missing" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated a" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated b" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "binary argument b constant truncated c" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "ternary argument a truncated" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "ternary argument a constant missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated a" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated b" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "ternary argument a constant truncated c" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_missing.sdf" "unexpected eof reading argument b"
}

@test "ternary argument b truncated" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_truncated.sdf" "unexpected eof reading argument b"
}

@test "ternary argument b constant missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated a" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated b" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "ternary argument b constant truncated c" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_truncated_c.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_missing.sdf" "unexpected eof reading argument c"
}

@test "ternary argument c truncated" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_truncated.sdf" "unexpected eof reading argument c"
}

@test "ternary argument c constant missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_missing.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated a" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_truncated_a.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated b" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_truncated_b.sdf" "unexpected eof reading number constant"
}

@test "ternary argument c constant truncated c" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_truncated_c.sdf" "unexpected eof reading number constant"
}
