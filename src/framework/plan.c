#include "types.h"
#include "malloc.h"
#include "primitive.h"
#include "pointer.h"
#include "opcode.h"
#include "store.h"
#include "plan.h"

size_t sdf_plan_buffers = 0;
sdf_primitive_t * sdf_plan_buffer_primitives = NULL;
size_t * sdf_plan_result_buffers = NULL;
size_t * sdf_plan_argument_buffers = NULL;

static size_t * sdf__buffer_users;

static void sdf__reset(void) {
  sdf_plan_buffers = 0;
  free(sdf_plan_buffer_primitives);
  sdf_plan_buffer_primitives = NULL;
  free(sdf_plan_result_buffers);
  sdf_plan_result_buffers = SDF_MALLOC(size_t, sdf_store_total_opcodes, "plan which buffers instruction results are written to");
  free(sdf_plan_argument_buffers);
  sdf_plan_argument_buffers = SDF_MALLOC(size_t, sdf_store_total_arguments, "plan which buffers instruction arguments are read from");

  sdf__buffer_users = NULL;
}

static size_t sdf__find_unused_buffer(
  sdf_primitive_t primitive
) {
  size_t buffer = 0;
  while (buffer < sdf_plan_buffers) {
    if (sdf__buffer_users[buffer] == SIZE_MAX && sdf_plan_buffer_primitives[buffer] == primitive) {
      return buffer;
    }
    buffer++;
  }
  return SIZE_MAX;
}

static size_t sdf__create_new_buffer(
  sdf_primitive_t primitive
) {
  size_t buffer = sdf_plan_buffers;
  sdf_plan_buffers++;
  SDF_REALLOC(sdf_primitive_t, sdf_plan_buffers, "record the primitive types of buffers", sdf_plan_buffer_primitives);
  SDF_REALLOC(size_t, sdf_plan_buffers, "record pointers to the instructions of which results are currently being held in buffers", sdf__buffer_users);
  sdf_plan_buffer_primitives[buffer] = primitive;
  return buffer;
}

static size_t sdf__find_unused_or_create_new_buffer(
  sdf_primitive_t primitive
) {
  size_t buffer = sdf__find_unused_buffer(primitive);
  if (buffer == SIZE_MAX) {
    buffer = sdf__create_new_buffer(primitive);
  }
  return buffer;
}

static void sdf__release_buffer_if_unused(
  size_t buffer,
  size_t after_argument
) {
  while (after_argument < sdf_store_total_arguments) {
    if (sdf_store_arguments[after_argument] == sdf__buffer_users[buffer]) {
      return;
    }
    after_argument++;
  }

  sdf__buffer_users[buffer] = SIZE_MAX;
}

static size_t sdf__find_buffer_by_writing_instruction(
  size_t instruction
) {
  size_t buffer = 0;
  while (sdf__buffer_users[buffer] != instruction) {
    buffer++;
  }
  return buffer;
}

static void sdf__find_buffers_for_arguments(
  size_t first_argument,
  size_t end_of_arguments
) {
  while (first_argument < end_of_arguments) {
    sdf_plan_argument_buffers[first_argument] = sdf__find_buffer_by_writing_instruction(sdf_store_arguments[first_argument]);
    first_argument++;
  }
}

static void sdf__release_buffers_if_unused(
  size_t instruction,
  size_t first_argument,
  size_t end_of_arguments
) {
  sdf__release_buffer_if_unused(
    sdf_plan_result_buffers[instruction],
    end_of_arguments
  );

  while (first_argument < end_of_arguments) {
    sdf__release_buffer_if_unused(
      sdf_plan_argument_buffers[first_argument],
      end_of_arguments
    );
    first_argument++;
  }
}

void sdf_plan(void) {
  size_t instruction = 0;
  sdf_pointer_t first_argument = 0;
  size_t end_of_arguments;
  size_t buffer;
  sdf_opcode_t opcode;

  sdf__reset();

  while (instruction < sdf_store_total_opcodes) {
    opcode = sdf_store_opcodes[instruction];

    buffer = sdf__find_unused_or_create_new_buffer(sdf_opcode_result(opcode));
    sdf_plan_result_buffers[instruction] = buffer;
    sdf__buffer_users[buffer] = instruction;

    end_of_arguments = first_argument + sdf_opcode_arity(opcode);
    sdf__find_buffers_for_arguments(first_argument, end_of_arguments);

    sdf__release_buffers_if_unused(instruction, first_argument, end_of_arguments);

    first_argument = end_of_arguments;
    instruction++;
  }

  free(sdf__buffer_users);
}
