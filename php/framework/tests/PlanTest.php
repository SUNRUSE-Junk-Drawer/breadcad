<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Argument;
use Breadcad\Framework\Instruction;
use Breadcad\Framework\PlanStep;
use Breadcad\Framework\Plan;

final class PlanTest extends TestCase {
  public function test_exposes_steps() {
    $instruction = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $steps = [
      new PlanStep(
        new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]),
        27,
        [31, 27, 18, 21, 40],
      ),
      new PlanStep(
        new Instruction(0x88DC, [new Argument(0x742D, -543.1)]),
        151,
        [8, 7],
      ),
      new PlanStep(
        new Instruction(0x43D2, [new Argument(0xCBA1, 24.7)]),
        22,
        [8, 6, 10],
      ),
    ];

    $plan = new Plan($steps);

    $this->assertEquals($steps, $plan->steps);
  }
}
