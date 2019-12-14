<?php

namespace Breadcad\Framework;

final class PlanStep {
  public $instruction;
  public $result;
  public $arguments;

  function __construct($instruction, $result, $arguments) {
    $this->instruction = $instruction;
    $this->result = $result;
    $this->arguments = $arguments;
  }
}
