<?php

use PHPUnit\Framework\TestCase;
use Breadcad\Framework\Argument;
use Breadcad\Framework\Instruction;
use Breadcad\Framework\Store;

final class StoreTest extends TestCase {
  public function test_initial() {
    $this->assertEquals([], (new Store())->instructions);
  }

  public function test_clear() {
    $store = new Store();

    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $store->instruction($instruction_a);

    $this->assertEquals([$instruction_a], $store->instructions);
  }

  public function test_clear_clear() {
    $store = new Store();

    $store->clear();
    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_clear_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $store->clear();
    $store->instruction($instruction_a);

    $this->assertEquals([$instruction_a], $store->instructions);
  }

  public function test_instruction_clear() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $store->instruction($instruction_a);
    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_instruction_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);
    $instruction_b = new Instruction(0x88DC, [new Argument(0x742D, -543.1)]);

    $store->instruction($instruction_a);
    $store->instruction($instruction_b);

    $this->assertEquals([$instruction_a, $instruction_b], $store->instructions);
  }

  public function test_clear_clear_clear() {
    $store = new Store();

    $store->clear();
    $store->clear();
    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_clear_clear_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $store->clear();
    $store->clear();
    $store->instruction($instruction_a);

    $this->assertEquals([$instruction_a], $store->instructions);
  }

  public function test_clear_instruction_clear() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $store->clear();
    $store->instruction($instruction_a);
    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_clear_instruction_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);
    $instruction_b = new Instruction(0x88DC, [new Argument(0x742D, -543.1)]);

    $store->clear();
    $store->instruction($instruction_a);
    $store->instruction($instruction_b);

    $this->assertEquals([$instruction_a, $instruction_b], $store->instructions);
  }

  public function test_instruction_clear_clear() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);

    $store->instruction($instruction_a);
    $store->clear();
    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_instruction_clear_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);
    $instruction_b = new Instruction(0x88DC, [new Argument(0x742D, -543.1)]);

    $store->instruction($instruction_a);
    $store->clear();
    $store->instruction($instruction_b);

    $this->assertEquals([$instruction_b], $store->instructions);
  }

  public function test_instruction_instruction_clear() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);
    $instruction_b = new Instruction(0x88DC, [new Argument(0x742D, -543.1)]);

    $store->instruction($instruction_a);
    $store->instruction($instruction_b);
    $store->clear();

    $this->assertEquals([], $store->instructions);
  }

  public function test_instruction_instruction_instruction() {
    $store = new Store();
    $instruction_a = new Instruction(0x9ED1, [new Argument(0x842A, 232.12)]);
    $instruction_b = new Instruction(0x88DC, [new Argument(0x742D, -543.1)]);
    $instruction_c = new Instruction(0x43D2, [new Argument(0xCBA1, 24.7)]);

    $store->instruction($instruction_a);
    $store->instruction($instruction_b);
    $store->instruction($instruction_c);

    $this->assertEquals([$instruction_a, $instruction_b, $instruction_c], $store->instructions);
  }
}
