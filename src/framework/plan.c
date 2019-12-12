#include "types.h"
#include "malloc.h"
#include "primitive.h"
#include "pointer.h"
#include "opcode.h"
#include "store.h"
#include "plan.h"

size_t bc_plan_buffers = 0;
bc_primitive_t * bc_plan_buffer_primitives = NULL;
size_t * bc_plan_result_buffers = NULL;
size_t * bc_plan_argument_buffers = NULL;

static size_t * bc__buffer_users;

static void bc__reset(void) {
  bc_plan_buffers = 0;
  free(bc_plan_buffer_primitives);
  bc_plan_buffer_primitives = NULL;
  free(bc_plan_result_buffers);
  bc_plan_result_buffers = BC_MALLOC(size_t, bc_store_total_opcodes, "plan which buffers instruction results are written to");
  free(bc_plan_argument_buffers);
  bc_plan_argument_buffers = BC_MALLOC(size_t, bc_store_total_arguments, "plan which buffers instruction arguments are read from");

  bc__buffer_users = NULL;
}

static size_t bc__find_unused_buffer(
  bc_primitive_t primitive
) {
  size_t buffer = 0;
  while (buffer < bc_plan_buffers) {
    if (bc__buffer_users[buffer] == SIZE_MAX && bc_plan_buffer_primitives[buffer] == primitive) {
      return buffer;
    }
    buffer++;
  }
  return SIZE_MAX;
}

static size_t bc__create_new_buffer(
  bc_primitive_t primitive
) {
  size_t buffer = bc_plan_buffers;
  bc_plan_buffers++;
  BC_REALLOC(bc_primitive_t, bc_plan_buffers, "record the primitive types of buffers", bc_plan_buffer_primitives);
  BC_REALLOC(size_t, bc_plan_buffers, "record pointers to the instructions of which results are currently being held in buffers", bc__buffer_users);
  bc_plan_buffer_primitives[buffer] = primitive;
  return buffer;
}

static size_t bc__find_unused_or_create_new_buffer(
  bc_primitive_t primitive
) {
  size_t buffer = bc__find_unused_buffer(primitive);
  if (buffer == SIZE_MAX) {
    buffer = bc__create_new_buffer(primitive);
  }
  return buffer;
}

static void bc__release_buffer_if_unused(
  size_t buffer,
  size_t after_argument
) {
  if (buffer != SIZE_MAX) {
    while (after_argument < bc_store_total_arguments) {
      if (bc_store_arguments[after_argument].pointer == bc__buffer_users[buffer]) {
        return;
      }
      after_argument++;
    }

    bc__buffer_users[buffer] = SIZE_MAX;
  }
}

static size_t bc__find_buffer_by_writing_instruction(
  size_t instruction
) {
  size_t buffer = 0;
  while (bc__buffer_users[buffer] != instruction) {
    buffer++;
  }
  return buffer;
}

static void bc__find_buffers_for_arguments(
  size_t first_argument,
  size_t end_of_arguments
) {
  bc_pointer_t pointer;
  while (first_argument < end_of_arguments) {
    pointer = bc_store_arguments[first_argument].pointer;
    if (pointer > BC_POINTER_MAX) {
      bc_plan_argument_buffers[first_argument] = SIZE_MAX;
    } else {
      bc_plan_argument_buffers[first_argument] = bc__find_buffer_by_writing_instruction(pointer);
    }
    first_argument++;
  }
}

static void bc__release_buffers_if_unused(
  size_t instruction,
  size_t first_argument,
  size_t end_of_arguments
) {
  bc__release_buffer_if_unused(
    bc_plan_result_buffers[instruction],
    end_of_arguments
  );

  while (first_argument < end_of_arguments) {
    bc__release_buffer_if_unused(
      bc_plan_argument_buffers[first_argument],
      end_of_arguments
    );
    first_argument++;
  }
}

void bc_plan(void) {
  size_t instruction = 0;
  bc_pointer_t first_argument = 0;
  size_t end_of_arguments;
  size_t buffer;
  bc_opcode_t opcode;

  bc__reset();

  while (instruction < bc_store_total_opcodes) {
    opcode = bc_store_opcodes[instruction];

    buffer = bc__find_unused_or_create_new_buffer(bc_opcode_result(opcode));
    bc_plan_result_buffers[instruction] = buffer;
    bc__buffer_users[buffer] = instruction;

    end_of_arguments = first_argument + bc_opcode_arity(opcode);
    bc__find_buffers_for_arguments(first_argument, end_of_arguments);

    bc__release_buffers_if_unused(instruction, first_argument, end_of_arguments);

    first_argument = end_of_arguments;
    instruction++;
  }

  free(bc__buffer_users);
}
