<?php

namespace Breadcad\Framework;

use Breadcad\Framework\PlanStep;

final class Plan {
  public $steps;

  function __construct($steps) {
    $this->steps = $steps;
  }
}
