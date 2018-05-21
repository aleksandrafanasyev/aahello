.PHONY : All target host clean libs

SHELL := /bin/sh
CC = gcc
C_FILES := aahello.c
H_FILES := libhello.h libgoodbye.h
LIBS := -lhello -lgoodbye
LIB := libhello.so
SONAME := libhello.so.0
CFLAGS = -Wall -Werror
LDFLAGS = -L. 
LDLIBS = -fPIC --shared -Wl,-soname,$(SONAME)
target: DIR := target
host: DIR := host

All: host

target: aahello

host: aahello

aahello: libs $(C_FILES) $(H_FILES)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $(C_FILES) $(LDFLAGS) $(LIBS)  -o aahello
	mkdir $(DIR)
	mv aahello $(DIR)/aahello
	mv libhello.so $(DIR)/$(SONAME)
	mv libgoodbye.a $(DIR)/libgoodbey.a

libs: libhello.c libgoodbye.c
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $(LDLIBS) libhello.c -o $(LIB)
	$(CROSS_COMPILE)$(CC) -c $(CFLAGS) libgoodbye.c  -o libgoodbye.o
	$(CROSS_COMPILE)$(AR) rcs libgoodbye.a libgoodbye.o

clean:
	rm -f ./target/aahello
	rm -f ./host/aahello
	rm -f *.o
	rm -f ./target/libgoodbye.a
	rm -f ./target/libhello.so
	rm -f ./host/libgoodbye.a
	rm -f ./host/libhello.so
	rm -rf ./target
	rm -rf ./host





