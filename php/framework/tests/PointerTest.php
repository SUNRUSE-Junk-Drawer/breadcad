<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Pointer;

final class PointerTest extends TestCase {
  public function test_defines_max() {
    $this->assertEquals(65532, Pointer::MAX);
  }

  public function test_defines_range() {
    $this->assertEquals(65533, Pointer::RANGE);
  }

  public function test_defines_boolean_constant_false() {
    $this->assertEquals(65533, Pointer::BOOLEAN_CONSTANT_FALSE);
  }

  public function test_defines_boolean_constant_true() {
    $this->assertEquals(65534, Pointer::BOOLEAN_CONSTANT_TRUE);
  }

  public function test_defines_number_constant() {
    $this->assertEquals(65535, Pointer::NUMBER_CONSTANT);
  }
}
