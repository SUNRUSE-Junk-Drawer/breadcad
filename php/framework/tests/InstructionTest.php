<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Argument;
use Breadcad\Framework\Instruction;

final class InstructionTest extends TestCase {
  public function test_exposes_opcode() {
    $arguments = [
      new Argument(0xDE8A, 32.192),
      new Argument(0x000D, -27.12),
      new Argument(0x342C, 0.4),
    ];

    $this->assertEquals(0xA91E, (new Instruction(0xA91E, $arguments))->opcode);
  }

  public function test_exposes_arguments() {
    $arguments = [
      new Argument(0xDE8A, 32.192),
      new Argument(0x000D, -27.12),
      new Argument(0x342C, 0.4),
    ];

    $this->assertEquals($arguments, (new Instruction(0xA91E, $arguments))->arguments);
  }
}
