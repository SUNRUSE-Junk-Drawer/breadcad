<?php

namespace Breadcad\Framework;

final class Instruction {
  public $opcode;

  public $arguments;

  function __construct(int $opcode, array $arguments) {
    $this->opcode = $opcode;
    $this->arguments = $arguments;
  }
}
