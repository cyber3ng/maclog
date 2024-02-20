SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
DEP = $(OBJ:.o=.d)
CC = clang
CFLAGS = -Wall -MMD -I../include
ifdef DEBUG
CFLAGS += -g
endif

# Change the target from libmaclog.dylib to libmaclog.a
../lib/libmaclog.a: $(OBJ)
	# Use the ar command to create a static library
	ar rcs $@ $^

-include $(DEP)

.PHONY: clean
clean:
	rm -rf $(OBJ) $(DEP) ../lib/libmaclog.a
