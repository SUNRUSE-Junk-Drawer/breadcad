<?php

namespace Breadcad\Framework;

final class Argument {
  public $pointer;
  public $number_constant;

  function __construct(int $pointer, float $number_constant) {
    $this->pointer = $pointer;
    $this->number_constant = $number_constant;
  }

  const NAMES = ['a', 'b', 'c'];
}
