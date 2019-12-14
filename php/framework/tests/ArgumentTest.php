<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Argument;

final class ArgumentTest extends TestCase {
  public function test_defines_names() {
    $this->assertEquals(['a', 'b', 'c'], Argument::NAMES);
  }

  public function test_exposes_pointer() {
    $this->assertEquals(0xDE8A, (new Argument(0xDE8A, 32.192))->pointer);
  }

  public function test_exposes_number_constant() {
    $this->assertEquals(32.192, (new Argument(0xDE8A, 32.192))->number_constant);
  }
}
