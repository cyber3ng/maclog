SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
DEP = $(OBJ:.o=.d)
CC = clang
CFLAGS = -Wall -MMD -I../include
ifdef DEBUG
CFLAGS += -g
endif
FRAMEWORKS = -framework CoreGraphics -framework CoreFoundation -framework Carbon

../bin/maclog: exec.o ../lib/libmaclog.a
	$(CC) $(CFLAGS) exec.o -o $@ ../lib/libmaclog.a $(FRAMEWORKS)
ifdef DEBUG
	dsymutil $@
endif
	
-include $(DEP)

.PHONY: clean
clean:
	rm -rf $(OBJ) $(DEP) 
	rm -rf ../bin/maclog ../bin/maclog.dSYM
