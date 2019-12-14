<?php

namespace Breadcad\Framework;

final class Opcode {
  private function __construct() {}

  const ID_MAX = Types::U8_MAX;
  const ID_RANGE = Types::U8_RANGE;

  const ARITY_MAX = 3;

  const NOT = 0x5000;
  const AND = 0x5400;
  const OR = 0x5401;
  const EQUAL = 0x5402;
  const NOT_EQUAL = 0x5403;
  const CONDITIONAL_BOOLEAN = 0x5500;
  const GREATER_THAN = 0x6800;
  const PARAMETER_MIN = 0x8000;
  const PARAMETER_MAX = 0x80FF;
  const CONDITIONAL_NUMBER = 0x9A00;
  const NEGATE = 0xA000;
  const SINE = 0xA001;
  const COSINE = 0xA002;
  const TANGENT = 0xA003;
  const ARC_SINE = 0xA004;
  const ARC_COSINE = 0xA005;
  const ARC_TANGENT = 0xA006;
  const HYPERBOLIC_SINE = 0xA007;
  const HYPERBOLIC_COSINE = 0xA008;
  const HYPERBOLIC_TANGENT = 0xA009;
  const HYPERBOLIC_ARC_SINE = 0xA00A;
  const HYPERBOLIC_ARC_COSINE = 0xA00B;
  const HYPERBOLIC_ARC_TANGENT = 0xA00C;
  const ABSOLUTE = 0xA00D;
  const SQUARE_ROOT = 0xA00E;
  const FLOOR = 0xA00F;
  const CEILING = 0xA010;
  const NATURAL_LOGARITHM = 0xA011;
  const LOGARITHM_10 = 0xA012;
  const NATURAL_POWER = 0xA013;
  const ADD = 0xA800;
  const SUBTRACT = 0xA801;
  const MULTIPLY = 0xA802;
  const DIVIDE = 0xA803;
  const POWER = 0xA804;
  const MODULO = 0xA805;
  const ARC_TANGENT_2 = 0xA806;
  const MINIMUM = 0xA807;
  const MAXIMUM = 0xA808;

  static function result(
    int $opcode
  ): int {
    return $opcode
      / Primitive::RANGE
      / Primitive::RANGE
      / Primitive::RANGE
      / Opcode::ID_RANGE;
  }

  static function parameter_a(
    int $opcode
  ): int {
    return (
        $opcode
        - (
          self::result($opcode)
          * Primitive::RANGE
          * Primitive::RANGE
          * Primitive::RANGE
          * Opcode::ID_RANGE
        )
      )
      / Primitive::RANGE
      / Primitive::RANGE
      / Opcode::ID_RANGE;
  }

  static function parameter_b(
    int $opcode
  ): int {
    return (
        $opcode
        - (
          self::result($opcode)
          * Primitive::RANGE
          * Primitive::RANGE
          * Primitive::RANGE
          * Opcode::ID_RANGE
        )
        - (
          self::parameter_a($opcode)
          * Primitive::RANGE
          * Primitive::RANGE
          * Opcode::ID_RANGE
        )
      )
      / Primitive::RANGE
      / Opcode::ID_RANGE;
  }

  static function parameter_c(
    int $opcode
  ): int {
    return (
        $opcode
        - (
          self::result($opcode)
          * Primitive::RANGE
          * Primitive::RANGE
          * Primitive::RANGE
          * Opcode::ID_RANGE
        )
        - (
          self::parameter_a($opcode)
          * Primitive::RANGE
          * Primitive::RANGE
          * Opcode::ID_RANGE
        )
        - (
          self::parameter_b($opcode)
          * Primitive::RANGE
          * Opcode::ID_RANGE
        )
      )
      / Opcode::ID_RANGE;
  }

  static function arity(
    int $opcode
  ): int {
    if (self::parameter_c($opcode)) {
      return 3;
    }

    if (self::parameter_b($opcode)) {
      return 2;
    }

    if (self::parameter_a($opcode)) {
      return 1;
    }

    return 0;
  }

  static function id(
    int $opcode
  ): int {
    return $opcode
      - (
        self::result($opcode)
        * Primitive::RANGE
        * Primitive::RANGE
        * Primitive::RANGE
        * self::ID_RANGE
      )
      - (
        self::parameter_a($opcode)
        * Primitive::RANGE
        * Primitive::RANGE
        * self::ID_RANGE
      )
      - (
        self::parameter_b($opcode)
        * Primitive::RANGE
        * self::ID_RANGE
      )
      - (
        self::parameter_c($opcode)
        * self::ID_RANGE
      );
  }
}
