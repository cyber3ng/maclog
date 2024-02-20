SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
DEP = $(OBJ:.o=.d)
CC = clang
CFLAGS = -Wall -MMD -I../include
ifdef DEBUG
CFLAGS += -g
endif
LDFLAGS = -L../lib
LDLIBS = -lmaclog
FRAMEWORKS = -framework CoreGraphics -framework CoreFoundation -framework Carbon

all: ../bin/dynamic ../bin/static

../bin/dynamic: dynamic.o ../lib/libmaclog.dylib
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
ifdef DEBUG
	dsymutil $@
endif

../bin/static: static.o ../lib/libmaclog.a
	$(CC) $(CFLAGS) static.o -o $@ ../lib/libmaclog.a $(FRAMEWORKS)
ifdef DEBUG
	dsymutil $@
endif
	
-include $(DEP)

.PHONY: clean
clean:
	rm -rf $(OBJ) $(DEP) 
	rm -rf ../bin/dynamic ../bin/dynamic.dSYM
	rm -rf ../bin/static ../bin/static.dSYM

