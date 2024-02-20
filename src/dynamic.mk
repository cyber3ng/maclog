SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
DEP = $(OBJ:.o=.d)
CC = clang
CFLAGS = -Wall -MMD -I../include -DDYNAMIC_LIB
ifdef DEBUG
CFLAGS += -g
endif
LDFLAGS = -dynamiclib
FRAMEWORKS = -framework CoreGraphics -framework CoreFoundation -framework Carbon

../lib/libmaclog.dylib: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(FRAMEWORKS)
ifdef DEBUG
	dsymutil $@
endif
	

-include $(DEP)

.PHONY: clean
clean:
	rm -rf $(OBJ) $(DEP) ../lib/libmaclog.dylib ../lib/libmaclog.dSYM

