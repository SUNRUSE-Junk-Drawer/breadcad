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

@test "parameter x missing value" {
  check_failure "bin/sample -x" "expected a value for command line argument -x/--x"
}

@test "parameter x interrupted" {
  check_failure "bin/sample -x -y 14.21" "unable to parse command line argument -x/--x value \"-y\" as a float"
}

@test "parameter x non-numeric" {
  check_failure "bin/sample -x wadjilad" "unable to parse command line argument -x/--x value \"wadjilad\" as a float"
}

@test "parameter x partially numeric" {
  check_failure "bin/sample -x 53.34wa" "unable to parse command line argument -x/--x value \"53.34wa\" as a float"
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

@test "parameter y missing value" {
  check_failure "bin/sample -y" "expected a value for command line argument -y/--y"
}

@test "parameter y interrupted" {
  check_failure "bin/sample -y -z 14.21" "unable to parse command line argument -y/--y value \"-z\" as a float"
}

@test "parameter y non-numeric" {
  check_failure "bin/sample -y wadjilad" "unable to parse command line argument -y/--y value \"wadjilad\" as a float"
}

@test "parameter y partially numeric" {
  check_failure "bin/sample -y 53.34wa" "unable to parse command line argument -y/--y value \"53.34wa\" as a float"
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

@test "parameter z missing value" {
  check_failure "bin/sample -z" "expected a value for command line argument -z/--z"
}

@test "parameter z interrupted" {
  check_failure "bin/sample -z -x 14.21" "expected a value for command line argument -z/--z"
}

@test "parameter z non-numeric" {
  check_failure "bin/sample -z wadjilad" "unable to parse command line argument -z/--z value \"wadjilad\" as a float"
}

@test "parameter z partially numeric" {
  check_failure "bin/sample -z 53.34wa" "unable to parse command line argument -z/--z value \"53.34wa\" as a float"
}

@test "parameter w" {
  check_successful "bin/sample < test/sdf/parameter_w.sdf" "0.000000"
}

@test "parameter w with x y and z" {
  check_successful "bin/sample -x 3.26 -y -22.15 -z 14.27 < test/sdf/parameter_w.sdf" "0.000000"
}

@test "not false" {
  check_successful "bin/sample -x 12.216 -y 15.222 < test/sdf/not.sdf" "12.216000"
}

@test "not true" {
  check_successful "bin/sample -x 15.222 -y 12.216 < test/sdf/not.sdf" "12.216000"
}

@test "and false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/and.sdf" "22.150000"
}

@test "and false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/and.sdf" "22.150000"
}

@test "and true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/and.sdf" "3.260000"
}

@test "and true true" {
  check_successful "bin/sample -x 22.15 -y 14.27 -z 3.26 < test/sdf/and.sdf" "22.150000"
}

@test "or false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/or.sdf" "22.150000"
}

@test "or false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/or.sdf" "14.270000"
}

@test "or true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/or.sdf" "14.270000"
}

@test "or true true" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/or.sdf" "22.150000"
}

@test "equal false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/equal.sdf" "3.260000"
}

@test "equal false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/equal.sdf" "22.150000"
}

@test "equal true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/equal.sdf" "3.260000"
}

@test "equal true true" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/equal.sdf" "3.260000"
}

@test "not equal false false" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/not_equal.sdf" "22.150000"
}

@test "not equal false true" {
  check_successful "bin/sample -x 14.27 -y 22.15 -z 3.26 < test/sdf/not_equal.sdf" "14.270000"
}

@test "not equal true false" {
  check_successful "bin/sample -x 14.27 -y 3.26 -z 22.15 < test/sdf/not_equal.sdf" "14.270000"
}

@test "not equal true true" {
  check_successful "bin/sample -x 3.26 -y 22.15 -z 14.27 < test/sdf/not_equal.sdf" "22.150000"
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

@test "greater than (false) -> conditional number" {
  check_successful "bin/sample -x 12.216 -y 15.222 < test/sdf/greater_than_conditional_number_x_y.sdf" "15.222000"
}

@test "greater than (true) -> conditional number" {
  check_successful "bin/sample -x 15.222 -y 12.216 < test/sdf/greater_than_conditional_number_x_y.sdf" "15.222000"
}

@test "negate positive" {
  check_successful "bin/sample -x 12.216 < test/sdf/negate_x.sdf" "-12.216000"
}

@test "negate negative" {
  check_successful "bin/sample -x -12.216 < test/sdf/negate_x.sdf" "12.216000"
}

@test "sine" {
  check_successful "bin/sample -x 12.216 < test/sdf/sine_x.sdf" "-0.343246"
}

@test "cosine" {
  check_successful "bin/sample -x 12.216 < test/sdf/cosine_x.sdf" "0.939245"
}

@test "tangent" {
  check_successful "bin/sample -x 12.216 < test/sdf/tangent_x.sdf" "-0.365449"
}

@test "arc sine" {
  check_successful "bin/sample -x 0.216 < test/sdf/arc_sine_x.sdf" "0.217716"
}

@test "arc cosine" {
  check_successful "bin/sample -x 0.216 < test/sdf/arc_cosine_x.sdf" "1.353080"
}

@test "arc tangent" {
  check_successful "bin/sample -x 0.216 < test/sdf/arc_tangent_x.sdf" "0.212732"
}

@test "hyperbolic sine" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_sine_x.sdf" "0.217684"
}

@test "hyperbolic cosine" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_cosine_x.sdf" "1.023419"
}

@test "hyperbolic tangent" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_tangent_x.sdf" "0.212702"
}

@test "hyperbolic arc sine" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_arc_sine_x.sdf" "0.214355"
}

@test "hyperbolic arc cosine" {
  check_successful "bin/sample -x 2.467 < test/sdf/hyperbolic_arc_cosine_x.sdf" "1.552282"
}

@test "hyperbolic arc tangent" {
  check_successful "bin/sample -x 0.216 < test/sdf/hyperbolic_arc_tangent_x.sdf" "0.219457"
}

@test "absolute positive" {
  check_successful "bin/sample -x 0.216 < test/sdf/absolute_x.sdf" "0.216000"
}

@test "absolute negative" {
  check_successful "bin/sample -x -0.216 < test/sdf/absolute_x.sdf" "0.216000"
}

@test "square root" {
  check_successful "bin/sample -x 4.61304484 < test/sdf/square_root_x.sdf" "2.147800"
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

@test "natural logarithm" {
  check_successful "bin/sample -x 0.216 < test/sdf/natural_logarithm_x.sdf" "-1.532477"
}

@test "logarithm 10" {
  check_successful "bin/sample -x 0.216 < test/sdf/logarithm_10_x.sdf" "-0.665546"
}

@test "natural power" {
  check_successful "bin/sample -x 0.216 < test/sdf/natural_power_x.sdf" "1.241102"
}

@test "add" {
  check_successful "bin/sample -x 3.26 -y -11.01 < test/sdf/add_x_y.sdf" "-7.750000"
}

@test "subtract" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/subtract_x_y.sdf" "25.410000"
}

@test "multiply" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/multiply_x_y.sdf" "-72.209000"
}

@test "divide" {
  check_successful "bin/sample -x 3.26 -y -22.15 < test/sdf/divide_x_y.sdf" "-0.147178"
}

@test "pow" {
  check_successful "bin/sample -x 22.15 -y 3.26 < test/sdf/pow_x_y.sdf" "24317.466797"
}

@test "modulo -2.1 before" {
  check_successful "bin/sample -x -13.7 -y 3.45 < test/sdf/modulo_x_y.sdf" "-3.350000"
}

@test "modulo -2.1" {
  check_successful "bin/sample -x -10.45 -y 3.45 < test/sdf/modulo_x_y.sdf" "-0.100000"
}

@test "modulo -1.1 before" {
  check_successful "bin/sample -x -6.8 -y 3.45 < test/sdf/modulo_x_y.sdf" "-3.350000"
}

@test "modulo -1.1" {
  check_successful "bin/sample -x -3.55 -y 3.45 < test/sdf/modulo_x_y.sdf" "-0.100000"
}

@test "modulo -0.1 before" {
  check_successful "bin/sample -x -3.35 -y 3.45 < test/sdf/modulo_x_y.sdf" "-3.350000"
}

@test "modulo -0.1" {
  check_successful "bin/sample -x -0.1 -y 3.45 < test/sdf/modulo_x_y.sdf" "-0.100000"
}

@test "modulo 0" {
  check_successful "bin/sample -y 3.45 < test/sdf/modulo_x_y.sdf" "0.000000"
}

@test "modulo 0.1" {
  check_successful "bin/sample -x 0.1 -y 3.45 < test/sdf/modulo_x_y.sdf" "0.100000"
}

@test "modulo 0.1 before" {
  check_successful "bin/sample -x 3.35 -y 3.45 < test/sdf/modulo_x_y.sdf" "3.350000"
}

@test "modulo 1.1" {
  check_successful "bin/sample -x 3.55 -y 3.45 < test/sdf/modulo_x_y.sdf" "0.100000"
}

@test "modulo 1.1 before" {
  check_successful "bin/sample -x 6.8 -y 3.45 < test/sdf/modulo_x_y.sdf" "3.350000"
}

@test "modulo 2.1" {
  check_successful "bin/sample -x 10.45 -y 3.45 < test/sdf/modulo_x_y.sdf" "0.100000"
}

@test "modulo 2.1 before" {
  check_successful "bin/sample -x 13.7 -y 3.45 < test/sdf/modulo_x_y.sdf" "3.350000"
}

@test "arc tangent 2" {
  check_successful "bin/sample -x 14.217 -y -37.214 < test/sdf/arc_tangent_2_x_y.sdf" "2.776670"
  check_successful "bin/sample -x 14.217 -y 37.214 < test/sdf/arc_tangent_2_x_y.sdf" "0.364923"
  check_successful "bin/sample -x -14.217 -y 37.214 < test/sdf/arc_tangent_2_x_y.sdf" "-0.364923"
  check_successful "bin/sample -x -14.217 -y -37.214 < test/sdf/arc_tangent_2_x_y.sdf" "-2.776670"
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
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_missing.sdf" "unexpected eof reading float constant"
}

@test "unary argument a constant truncated a" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_truncated_a.sdf" "unexpected eof reading float constant"
}

@test "unary argument a constant truncated b" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_truncated_b.sdf" "unexpected eof reading float constant"
}

@test "unary argument a constant truncated c" {
  check_failure "bin/sample < test/sdf/unary_argument_a_constant_truncated_c.sdf" "unexpected eof reading float constant"
}

@test "binary argument a missing" {
  check_failure "bin/sample < test/sdf/binary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "binary argument a truncated" {
  check_failure "bin/sample < test/sdf/binary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "binary argument a constant missing" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_missing.sdf" "unexpected eof reading float constant"
}

@test "binary argument a constant truncated a" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_truncated_a.sdf" "unexpected eof reading float constant"
}

@test "binary argument a constant truncated b" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_truncated_b.sdf" "unexpected eof reading float constant"
}

@test "binary argument a constant truncated c" {
  check_failure "bin/sample < test/sdf/binary_argument_a_constant_truncated_c.sdf" "unexpected eof reading float constant"
}

@test "binary argument b missing" {
  check_failure "bin/sample < test/sdf/binary_argument_b_missing.sdf" "unexpected eof reading argument b"
}

@test "binary argument b truncated" {
  check_failure "bin/sample < test/sdf/binary_argument_b_truncated.sdf" "unexpected eof reading argument b"
}

@test "binary argument b constant missing" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_missing.sdf" "unexpected eof reading float constant"
}

@test "binary argument b constant truncated a" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_truncated_a.sdf" "unexpected eof reading float constant"
}

@test "binary argument b constant truncated b" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_truncated_b.sdf" "unexpected eof reading float constant"
}

@test "binary argument b constant truncated c" {
  check_failure "bin/sample < test/sdf/binary_argument_b_constant_truncated_c.sdf" "unexpected eof reading float constant"
}

@test "ternary argument a missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_missing.sdf" "unexpected eof reading argument a"
}

@test "ternary argument a truncated" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_truncated.sdf" "unexpected eof reading argument a"
}

@test "ternary argument a constant missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_missing.sdf" "unexpected eof reading float constant"
}

@test "ternary argument a constant truncated a" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_truncated_a.sdf" "unexpected eof reading float constant"
}

@test "ternary argument a constant truncated b" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_truncated_b.sdf" "unexpected eof reading float constant"
}

@test "ternary argument a constant truncated c" {
  check_failure "bin/sample < test/sdf/ternary_argument_a_constant_truncated_c.sdf" "unexpected eof reading float constant"
}

@test "ternary argument b missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_missing.sdf" "unexpected eof reading argument b"
}

@test "ternary argument b truncated" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_truncated.sdf" "unexpected eof reading argument b"
}

@test "ternary argument b constant missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_missing.sdf" "unexpected eof reading float constant"
}

@test "ternary argument b constant truncated a" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_truncated_a.sdf" "unexpected eof reading float constant"
}

@test "ternary argument b constant truncated b" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_truncated_b.sdf" "unexpected eof reading float constant"
}

@test "ternary argument b constant truncated c" {
  check_failure "bin/sample < test/sdf/ternary_argument_b_constant_truncated_c.sdf" "unexpected eof reading float constant"
}

@test "ternary argument c missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_missing.sdf" "unexpected eof reading argument c"
}

@test "ternary argument c truncated" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_truncated.sdf" "unexpected eof reading argument c"
}

@test "ternary argument c constant missing" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_missing.sdf" "unexpected eof reading float constant"
}

@test "ternary argument c constant truncated a" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_truncated_a.sdf" "unexpected eof reading float constant"
}

@test "ternary argument c constant truncated b" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_truncated_b.sdf" "unexpected eof reading float constant"
}

@test "ternary argument c constant truncated c" {
  check_failure "bin/sample < test/sdf/ternary_argument_c_constant_truncated_c.sdf" "unexpected eof reading float constant"
}
