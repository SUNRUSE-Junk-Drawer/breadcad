<?php

namespace Breadcad\Framework;

use Breadcad\Framework\Types;

final class Pointer {
  private function __construct() {}

  const MAX = Types::U16_MAX - 3;
  const RANGE = Types::U16_RANGE - 3;
  const BOOLEAN_CONSTANT_FALSE = Types::U16_MAX - 2;
  const BOOLEAN_CONSTANT_TRUE = Types::U16_MAX - 1;
  const NUMBER_CONSTANT = Types::U16_MAX;
}
