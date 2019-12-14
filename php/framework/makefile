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

test: all
	cd php/framework && vendor/bin/phpunit --whitelist src --coverage-text tests/
