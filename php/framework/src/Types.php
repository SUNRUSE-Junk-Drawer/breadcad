<?php

namespace Breadcad\Framework;

final class Types {
  private function __construct() {}

  const U8_MAX = 255;
  const U8_RANGE = self::U8_MAX + 1;

  const U16_MAX = 65535;
  const U16_RANGE = self::U16_MAX + 1;
}
