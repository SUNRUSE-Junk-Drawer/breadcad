<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Types;

final class TypesTest extends TestCase {
  public function test_defines_u8_max() {
    $this->assertEquals(255, Types::U8_MAX);
  }

  public function test_defines_u8_range() {
    $this->assertEquals(256, Types::U8_RANGE);
  }

  public function test_defines_u16_max() {
    $this->assertEquals(65535, Types::U16_MAX);
  }

  public function test_defines_u16_range() {
    $this->assertEquals(65536, Types::U16_RANGE);
  }
}
