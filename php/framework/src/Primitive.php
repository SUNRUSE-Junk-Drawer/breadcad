<?php

namespace Breadcad\Framework;

final class Primitive {
  private function __construct() {}

  const NONE = 0;
  const BOOLEAN = 1;
  const NUMBER = 2;
  const RESERVED = 3;

  const MAX = 3;
  const RANGE = Primitive::MAX + 1;
}
