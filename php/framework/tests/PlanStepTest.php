<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Argument;
use Breadcad\Framework\Instruction;
use Breadcad\Framework\PlanStep;

final class PlanStepTest extends TestCase {
  public function test_exposes_instruction() {
    $instruction = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $step = new PlanStep($instruction, 27, [31, 27, 18, 21, 40]);

    $this->assertEquals($instruction, $step->instruction);
  }

  public function test_exposes_result() {
    $instruction = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $step = new PlanStep($instruction, 27, [31, 27, 18, 21, 40]);

    $this->assertEquals(27, $step->result);
  }

  public function test_exposes_arguments() {
    $instruction = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $step = new PlanStep($instruction, 27, [31, 27, 18, 21, 40]);

    $this->assertEquals([31, 27, 18, 21, 40], $step->arguments);
  }
}
