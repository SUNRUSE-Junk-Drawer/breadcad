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

ALL_H = $(wildcard src/framework/*.h) $(wildcard src/executables/*.h)
ALL_FRAMEWORK_O = $(addprefix obj/framework/, $(addsuffix .o, $(basename $(notdir $(wildcard src/framework/*.c)))))
ALL_EXECUTABLES = $(addprefix bin/, $(basename $(notdir $(wildcard src/executables/*.c))))
ALL_TEST_FRAMEWORK = $(wildcard test/framework/*.bash)
ALL_TEST_RESULTS = $(addprefix test_results/, $(basename $(notdir $(wildcard test/executables/*.bash))))

obj/%.o: src/%.c $(ALL_H)
	mkdir -p $(dir $@)
	$(CC) -c -o $@ $<

bin/%: obj/executables/%.o $(ALL_FRAMEWORK_O)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $^

test_results/%: test/executables/%.bash bin/%  $(ALL_TEST_FRAMEWORK)
	mkdir -p test_results
	${SDF_BATS_PATH} $<
	touch $@

.PHONY: all clean test

all: $(ALL_EXECUTABLES)

clean:
	rm -rf bin obj test_results

test: $(ALL_TEST_RESULTS)
