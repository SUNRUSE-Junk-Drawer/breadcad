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
	-m64                   \

ALL_H = $(wildcard c/src/framework/*.h) $(wildcard c/src/executables/*.h)
ALL_FRAMEWORK_O = $(addprefix c/obj/framework/, $(addsuffix .o, $(basename $(notdir $(wildcard c/src/framework/*.c)))))
ALL_EXECUTABLES = $(addprefix $(BC_EXECUTABLE_PREFIX), $(addsuffix $(BC_EXECUTABLE_SUFFIX), $(basename $(notdir $(wildcard c/src/executables/*.c)))))
ALL_TEST_FRAMEWORK = $(wildcard test/framework/*.bash)
ALL_TEST_RESULTS = $(addprefix c/test_results/, $(basename $(notdir $(wildcard test/executables/*.bash))))
ALL_TEST_BC = $(wildcard test/bc/*.bc)

c/obj/%.o: c/src/%.c $(ALL_H) c/makefile
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BC_EXECUTABLE_PREFIX)%$(BC_EXECUTABLE_SUFFIX): c/obj/executables/%.o $(ALL_FRAMEWORK_O)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $^ -lm

c/test_results/%: test/executables/%.bash $(ALL_EXECUTABLES) $(ALL_TEST_FRAMEWORK) $(ALL_TEST_BC)
	mkdir -p c/test_results
	bash submodules/bats-core/bin/bats $<
	touch $@

.PHONY: all clean test

all: $(ALL_EXECUTABLES)

clean:
	rm -rf c/bin c/obj c/test_results

test: $(ALL_TEST_RESULTS)
