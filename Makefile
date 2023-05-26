VERSION	= 0.9.1

PREFIX	= /usr

CC	= gcc
CFLAGS	= -W -Wall -Wextra -Werror -Wimplicit-fallthrough=1 \
	-DVERSION=\"$(VERSION)\" \
	-g
LDFLAGS =

ifeq "REMOVE_THIS_FOR_RELEASE" "REMOVE_THIS_FOR_RELEASE"
%.spec: %.spec.in Makefile
	sed s/@VERSION@/$(VERSION)/g < $@.in > $@

all: atinout atinout.1 atinout.spec
else
all: atinout
endif

atinout: atinout.c
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $^

ifeq "REMOVE_THIS_FOR_RELEASE" "REMOVE_THIS_FOR_RELEASE"

dist:
	make -f make.dist dist_tar_file

atinout.1 atinout.1.html: atinout.1.ronn
	ronn $^

clean:
	rm -f atinout atinout.1 atinout.1.html atinout.spec
else
clean:
	rm -f atinout
endif

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp atinout $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1
	cp atinout.1 $(DESTDIR)$(PREFIX)/share/man/man1/atinout.1
