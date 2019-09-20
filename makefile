CFLAGS =                 \
	-O3                    \
	-Wall                  \
	-Wextra                \
	-Werror                \
	-std=c89               \
	-pedantic              \
	-Wmissing-prototypes   \
	-Wstrict-prototypes    \
	-Wold-style-definition \

ALL_H = $(shell find src -name *.h)
ALL_FRAMEWORK_O = $(addsuffix .o, $(addprefix obj/framework/, $(basename $(shell find src/framework -name *.c -printf "%P "))))
ALL_EXECUTABLES = $(addprefix bin/, $(basename $(shell find src/executables -name *.c -printf "%P ")))
ALL_TEST_FRAMEWORK = $(shell find test/framework -name *.bash)
ALL_TEST_RESULTS = $(addprefix test_results/, $(basename $(shell find test/executables -name *.bash -printf "%P ")))

obj/%.o: src/%.c $(ALL_H)
	mkdir -p $(dir $@)
	$(CC) -c -o $@ $<

bin/%: obj/executables/%.o $(ALL_FRAMEWORK_O)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $^

test_results/%: test/executables/%.bash bin/%  $(ALL_TEST_FRAMEWORK)
	mkdir -p test_results
	${BATS_PATH} $<
	touch $@

.PHONY: all clean test

all: $(ALL_EXECUTABLES)

clean:
	rm -rf bin obj test_results

test: $(ALL_TEST_RESULTS)
