.PHONY: all
all: dynamic static exec

.PHONY: dynamic
dynamic:
	mkdir -p ./lib
	$(MAKE) -C ./src -f dynamic.mk

.PHONY: static
static:
	mkdir -p ./lib
	$(MAKE) -C ./src -f static.mk

.PHONY: exec
exec: static
	mkdir -p ./bin
	$(MAKE) -C ./src -f exec.mk

.PHONY: tests
tests: dynamic static
	mkdir -p ./bin
	$(MAKE) -C ./tests -f tests.mk

.PHONY: debug
debug:
	mkdir -p ./lib
	mkdir -p ./bin
	$(MAKE) -C ./src -f dynamic.mk DEBUG=1
	$(MAKE) -C ./src -f static.mk DEBUG=1
	$(MAKE) -C ./tests -f tests.mk DEBUG=1

.PHONY: clean
clean:
	$(MAKE) -C ./src -f dynamic.mk clean
	$(MAKE) -C ./src -f static.mk clean
	$(MAKE) -C ./tests -f tests.mk clean
	rm -rf ./bin
	rm -rf ./lib

