<?php

namespace Breadcad\Framework;

use Breadcad\Framework\Instruction;

final class Store {
  public $instructions = [];

  function clear() {
    array_splice($this->instructions, 0, count($this->instructions));
  }

  function instruction(Instruction $instruction) {
    array_push($this->instructions, $instruction);
  }
}
