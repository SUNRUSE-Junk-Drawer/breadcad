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

MAKEFILE = php/framework/makefile
ALL_COMPOSER = php/framework/composer.json php/framework/composer.lock
MARKERS_INSTALL = php/framework/markers/install

$(MARKERS_INSTALL): $(ALL_COMPOSER) $(MAKEFILE)
	mkdir -p php/framework/markers
	touch php/framework/markers/install
	cd php/framework && composer install

all: $(MARKERS_INSTALL)

clean:
	rm -rf php/framework/vendor php/framework/markers
	rm -rf php/framework/test_results

test: all
	mkdir -p php/framework/test_results
	cd php/framework && vendor/bin/phpunit --whitelist src --coverage-text tests/ | tee test_results/unit
	grep -E "^\s*Lines:\s*100.00%\s*\([0-9]+\/[0-9]+\)$$" php/framework/test_results/unit
