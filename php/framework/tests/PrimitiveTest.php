<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Primitive;

final class PrimitiveTest extends TestCase {
  public function test_defines_none() {
    $this->assertEquals(0, Primitive::NONE);
  }

  public function test_defines_boolean() {
    $this->assertEquals(1, Primitive::BOOLEAN);
  }

  public function test_defines_number() {
    $this->assertEquals(2, Primitive::NUMBER);
  }

  public function test_defines_reserved() {
    $this->assertEquals(3, Primitive::RESERVED);
  }

  public function test_defines_max() {
    $this->assertEquals(3, Primitive::MAX);
  }

  public function test_defines_range() {
    $this->assertEquals(4, Primitive::RANGE);
  }
}
