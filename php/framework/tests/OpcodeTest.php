<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Primitive;
use Breadcad\Framework\Opcode;

final class OpcodeTest extends TestCase {
  public function test_defines_id_max() {
    $this->assertEquals(255, Opcode::ID_MAX);
  }

  public function test_defines_id_range() {
    $this->assertEquals(256, Opcode::ID_RANGE);
  }

  public function test_defines_arity_max() {
    $this->assertEquals(3, Opcode::ARITY_MAX);
  }

  public function test_defines_not() {
    $this->assertEquals(0x5000, Opcode::NOT);
  }

  public function test_defines_and() {
    $this->assertEquals(0x5400, Opcode::AND);
  }

  public function test_defines_or() {
    $this->assertEquals(0x5401, Opcode::OR);
  }

  public function test_defines_equal() {
    $this->assertEquals(0x5402, Opcode::EQUAL);
  }

  public function test_defines_not_equal() {
    $this->assertEquals(0x5403, Opcode::NOT_EQUAL);
  }

  public function test_defines_conditional_boolean() {
    $this->assertEquals(0x5500, Opcode::CONDITIONAL_BOOLEAN);
  }

  public function test_defines_greater_than() {
    $this->assertEquals(0x6800, Opcode::GREATER_THAN);
  }

  public function test_defines_parameter_min() {
    $this->assertEquals(0x8000, Opcode::PARAMETER_MIN);
  }

  public function test_defines_parameter_max() {
    $this->assertEquals(0x80FF, Opcode::PARAMETER_MAX);
  }

  public function test_defines_conditional_number() {
    $this->assertEquals(0x9A00, Opcode::CONDITIONAL_NUMBER);
  }

  public function test_defines_negate() {
    $this->assertEquals(0xA000, Opcode::NEGATE);
  }

  public function test_defines_sine() {
    $this->assertEquals(0xA001, Opcode::SINE);
  }

  public function test_defines_cosine() {
    $this->assertEquals(0xA002, Opcode::COSINE);
  }

  public function test_defines_tangent() {
    $this->assertEquals(0xA003, Opcode::TANGENT);
  }

  public function test_defines_arc_sine() {
    $this->assertEquals(0xA004, Opcode::ARC_SINE);
  }

  public function test_defines_arc_cosine() {
    $this->assertEquals(0xA005, Opcode::ARC_COSINE);
  }

  public function test_defines_arc_tangent() {
    $this->assertEquals(0xA006, Opcode::ARC_TANGENT);
  }

  public function test_defines_hyperbolic_sine() {
    $this->assertEquals(0xA007, Opcode::HYPERBOLIC_SINE);
  }

  public function test_defines_hyperbolic_cosine() {
    $this->assertEquals(0xA008, Opcode::HYPERBOLIC_COSINE);
  }

  public function test_defines_hyperbolic_tangent() {
    $this->assertEquals(0xA009, Opcode::HYPERBOLIC_TANGENT);
  }

  public function test_defines_hyperbolic_arc_sine() {
    $this->assertEquals(0xA00A, Opcode::HYPERBOLIC_ARC_SINE);
  }

  public function test_defines_hyperbolic_arc_cosine() {
    $this->assertEquals(0xA00B, Opcode::HYPERBOLIC_ARC_COSINE);
  }

  public function test_defines_hyperbolic_arc_tangent() {
    $this->assertEquals(0xA00C, Opcode::HYPERBOLIC_ARC_TANGENT);
  }

  public function test_defines_absolute() {
    $this->assertEquals(0xA00D, Opcode::ABSOLUTE);
  }

  public function test_defines_square_root() {
    $this->assertEquals(0xA00E, Opcode::SQUARE_ROOT);
  }

  public function test_defines_floor() {
    $this->assertEquals(0xA00F, Opcode::FLOOR);
  }

  public function test_defines_ceiling() {
    $this->assertEquals(0xA010, Opcode::CEILING);
  }

  public function test_defines_natural_logarithm() {
    $this->assertEquals(0xA011, Opcode::NATURAL_LOGARITHM);
  }

  public function test_defines_logarithm_10() {
    $this->assertEquals(0xA012, Opcode::LOGARITHM_10);
  }

  public function test_defines_natural_power() {
    $this->assertEquals(0xA013, Opcode::NATURAL_POWER);
  }

  public function test_defines_add() {
    $this->assertEquals(0xA800, Opcode::ADD);
  }

  public function test_defines_subtract() {
    $this->assertEquals(0xA801, Opcode::SUBTRACT);
  }

  public function test_defines_multiply() {
    $this->assertEquals(0xA802, Opcode::MULTIPLY);
  }

  public function test_defines_divide() {
    $this->assertEquals(0xA803, Opcode::DIVIDE);
  }

  public function test_defines_power() {
    $this->assertEquals(0xA804, Opcode::POWER);
  }

  public function test_defines_modulo() {
    $this->assertEquals(0xA805, Opcode::MODULO);
  }

  public function test_defines_arc_tangent_2() {
    $this->assertEquals(0xA806, Opcode::ARC_TANGENT_2);
  }

  public function test_defines_minimum() {
    $this->assertEquals(0xA807, Opcode::MINIMUM);
  }

  public function test_defines_maximum() {
    $this->assertEquals(0xA808, Opcode::MAXIMUM);
  }

  public function test_result_finds_none() {
    $this->assertEquals(Primitive::NONE, Opcode::result(0x2D41));
  }

  public function test_result_finds_boolean() {
    $this->assertEquals(Primitive::BOOLEAN, Opcode::result(0x6D41));
  }

  public function test_result_finds_number() {
    $this->assertEquals(Primitive::NUMBER, Opcode::result(0xAD41));
  }

  public function test_result_finds_reserved() {
    $this->assertEquals(Primitive::RESERVED, Opcode::result(0xED41));
  }

  public function test_parameter_a_finds_none() {
    $this->assertEquals(Primitive::NONE, Opcode::parameter_a(0x8941));
  }

  public function test_parameter_a_finds_boolean() {
    $this->assertEquals(Primitive::BOOLEAN, Opcode::parameter_a(0x9941));
  }

  public function test_parameter_a_finds_number() {
    $this->assertEquals(Primitive::NUMBER, Opcode::parameter_a(0xA941));
  }

  public function test_parameter_a_finds_reserved() {
    $this->assertEquals(Primitive::RESERVED, Opcode::parameter_a(0xB941));
  }

  public function test_parameter_b_finds_none() {
    $this->assertEquals(Primitive::NONE, Opcode::parameter_b(0xB241));
  }

  public function test_parameter_b_finds_boolean() {
    $this->assertEquals(Primitive::BOOLEAN, Opcode::parameter_b(0xB641));
  }

  public function test_parameter_b_finds_number() {
    $this->assertEquals(Primitive::NUMBER, Opcode::parameter_b(0xBA41));
  }

  public function test_parameter_b_finds_reserved() {
    $this->assertEquals(Primitive::RESERVED, Opcode::parameter_b(0xBE41));
  }

  public function test_parameter_c_finds_none() {
    $this->assertEquals(Primitive::NONE, Opcode::parameter_c(0xB841));
  }

  public function test_parameter_c_finds_boolean() {
    $this->assertEquals(Primitive::BOOLEAN, Opcode::parameter_c(0xB941));
  }

  public function test_parameter_c_finds_number() {
    $this->assertEquals(Primitive::NUMBER, Opcode::parameter_c(0xBA41));
  }

  public function test_parameter_c_finds_reserved() {
    $this->assertEquals(Primitive::RESERVED, Opcode::parameter_c(0xBB41));
  }

  public function test_arity_none_none_none_finds_0() {
    $this->assertEquals(0, Opcode::arity(0x8041));
  }

  public function test_arity_none_none_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8141));
  }

  public function test_arity_none_none_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8241));
  }

  public function test_arity_none_none_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8341));
  }

  public function test_arity_none_boolean_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0x8441));
  }

  public function test_arity_none_boolean_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8541));
  }

  public function test_arity_none_boolean_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8641));
  }

  public function test_arity_none_boolean_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8741));
  }

  public function test_arity_none_number_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0x8841));
  }

  public function test_arity_none_number_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8941));
  }

  public function test_arity_none_number_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8A41));
  }

  public function test_arity_none_number_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8B41));
  }

  public function test_arity_none_reserved_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0x8C41));
  }

  public function test_arity_none_reserved_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8D41));
  }

  public function test_arity_none_reserved_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8E41));
  }

  public function test_arity_none_reserved_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x8F41));
  }

  public function test_arity_boolean_none_none_finds_1() {
    $this->assertEquals(1, Opcode::arity(0x9041));
  }

  public function test_arity_boolean_none_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9141));
  }

  public function test_arity_boolean_none_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9241));
  }

  public function test_arity_boolean_none_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9341));
  }

  public function test_arity_boolean_boolean_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0x9441));
  }

  public function test_arity_boolean_boolean_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9541));
  }

  public function test_arity_boolean_boolean_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9641));
  }

  public function test_arity_boolean_boolean_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9741));
  }

  public function test_arity_boolean_number_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0x9841));
  }

  public function test_arity_boolean_number_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9941));
  }

  public function test_arity_boolean_number_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9A41));
  }

  public function test_arity_boolean_number_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9B41));
  }

  public function test_arity_boolean_reserved_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0x9C41));
  }

  public function test_arity_boolean_reserved_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9D41));
  }

  public function test_arity_boolean_reserved_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9E41));
  }

  public function test_arity_boolean_reserved_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0x9F41));
  }

  public function test_arity_number_none_none_finds_1() {
    $this->assertEquals(1, Opcode::arity(0xA041));
  }

  public function test_arity_number_none_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA141));
  }

  public function test_arity_number_none_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA241));
  }

  public function test_arity_number_none_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA341));
  }

  public function test_arity_number_boolean_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0xA441));
  }

  public function test_arity_number_boolean_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA541));
  }

  public function test_arity_number_boolean_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA641));
  }

  public function test_arity_number_boolean_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA741));
  }

  public function test_arity_number_number_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0xA841));
  }

  public function test_arity_number_number_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xA941));
  }

  public function test_arity_number_number_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xAA41));
  }

  public function test_arity_number_number_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xAB41));
  }

  public function test_arity_number_reserved_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0xAC41));
  }

  public function test_arity_number_reserved_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xAD41));
  }

  public function test_arity_number_reserved_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xAE41));
  }

  public function test_arity_number_reserved_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xAF41));
  }

  public function test_arity_reserved_none_none_finds_1() {
    $this->assertEquals(1, Opcode::arity(0xB041));
  }

  public function test_arity_reserved_none_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB141));
  }

  public function test_arity_reserved_none_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB241));
  }

  public function test_arity_reserved_none_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB341));
  }

  public function test_arity_reserved_boolean_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0xB441));
  }

  public function test_arity_reserved_boolean_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB541));
  }

  public function test_arity_reserved_boolean_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB641));
  }

  public function test_arity_reserved_boolean_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB741));
  }

  public function test_arity_reserved_number_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0xB841));
  }

  public function test_arity_reserved_number_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xB941));
  }

  public function test_arity_reserved_number_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xBA41));
  }

  public function test_arity_reserved_number_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xBB41));
  }

  public function test_arity_reserved_reserved_none_finds_2() {
    $this->assertEquals(2, Opcode::arity(0xBC41));
  }

  public function test_arity_reserved_reserved_boolean_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xBD41));
  }

  public function test_arity_reserved_reserved_number_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xBE41));
  }

  public function test_arity_reserved_reserved_reserved_finds_3() {
    $this->assertEquals(3, Opcode::arity(0xBF41));
  }

  public function test_id() {
    $this->assertEquals(0x41, Opcode::id(0x9741));
  }
}
