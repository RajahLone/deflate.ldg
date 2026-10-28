CMINI = libcmini/lib

CFLAGS  = -Wall -O -fomit-frame-pointer -DATARI -DNO_GZIP -DPKZIP_BUG_WORKAROUND
LDFLAGS = -s -nostdlib $(CMINI)/crt0.o
LDLIBS  = -L$(CMINI) -lcmini -lgcc -lcmini -lldg -lcmini #-lm -lcmini

#
# create manually
# ./build/68000/
# ./build/68020/
# ./build/ColdFire/
# folders for the targets to be placed.
#

TARGET = deflate.ldg

# list header files here
HEADER = adler32.c crc32.h deflate.h inffast.h inffixed.h inflate.h inftrees.h trees.h zconf.h zlib.h zutil.h

# list C files here
#
COBJS = adler32.c crc32.c deflate.c infback.c inffast.c inflate.c inftrees.c trees.c zutil.c main.c
#
# list assembler files here
SOBJS =

SRCFILES = $(HEADER) $(COBJS) $(SOBJS)

#############################
CROSSPREFIX=/opt/cross-mint/bin/m68k-atari-mint-
PREFIX=/opt/cross-mint
PATH = $(PREFIX)/m68k-atari-mint/bin:$(PREFIX)/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
LD_LIBRARY_PATH=$(PREFIX)/lib:$(PREFIX)/m68k-atari-mint/lib:$LD_LIBRARY_PATH

CC = $(CROSSPREFIX)gcc
AS = $(CC)
AR = $(CROSSPREFIX)ar
RANLIB = $(CROSSPREFIX)ranlib
STRIP = $(CROSSPREFIX)strip
FLAGS = $(CROSSPREFIX)flags
STACK = $(CROSSPREFIX)stack

OBJS = $(COBJS:.c=.o)

all: $(TARGET)
	$(STRIP) ./build/68000/$(TARGET)
	$(STACK) -S 32k ./build/68000/$(TARGET)
	-@rm -f ./build/68000/*.o
	$(STRIP) ./build/68020/$(TARGET)
	$(STACK) -S 32k ./build/68020/$(TARGET)
	-@rm -f ./build/68020/*.o
	$(STRIP) ./build/ColdFire/$(TARGET)
	$(STACK) -S 32k ./build/ColdFire/$(TARGET)
	-@rm -f ./build/ColdFire/*.o
	@echo All done

clean:
	-@rm -f ./build/68000/*.o
	-@rm -f ./build/68000/$(TARGET)
	-@rm -f ./build/68020/*.o
	-@rm -f ./build/68020/$(TARGET)
	-@rm -f ./build/ColdFire/*.o
	-@rm -f ./build/ColdFire/$(TARGET)
	@echo Cleaned

new: clean
	-@rm -f ./build/68000/$(TARGET)
	-@rm -f ./build/68020/$(TARGET)
	-@rm -f ./build/ColdFire/$(TARGET)
	$(MAKE) all


.SUFFIXES:
.SUFFIXES: .c .S .o

.c.o:
	$(CC) $(CFLAGS) -m68000 -c $*.c -o ./build/68000/$*.o
	$(CC) $(CFLAGS) -m68020-60 -c $*.c -o ./build/68020/$*.o
	$(CC) $(CFLAGS) -mcpu=5475 -c $*.c -o ./build/ColdFire/$*.o

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) ./build/68000/*.o -o ./build/68000/$(TARGET) -m68000 $(LDLIBS)
	$(CC) $(LDFLAGS) ./build/68020/*.o -o ./build/68020/$(TARGET) -m68020-60 $(LDLIBS)
	$(CC) $(LDFLAGS) ./build/ColdFire/*.o -o ./build/ColdFire/$(TARGET) -mcpu=5475 $(LDLIBS)

