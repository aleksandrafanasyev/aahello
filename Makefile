.PHONY : All target host clean libs

SHELL := /bin/sh
CC = gcc
C_FILES := aahello.c
H_FILES := libhello.h libgoodbye.h
LIBS := -lhello -lgoodbye
CFLAGS = -Wall -Werror
LDFLAGS = -L$(DIR) -Wl,-rpath=.
LDLIBS = -fPIC --shared
target: DIR := target
host: DIR := host

All: host

target: aahello

host: aahello

aahello: libs $(C_FILES) $(H_FILES)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $(C_FILES) $(LDFLAGS) $(LIBS)  -o $(DIR)/aahello

libs: libhello.c libgoodbye.c
	mkdir $(DIR)	
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $(LDLIBS) libhello.c -o $(DIR)/libhello.so
	$(CROSS_COMPILE)$(CC) -c $(CFLAGS) libgoodbye.c  -o libgoodbye.o
	$(CROSS_COMPILE)$(AR) rcs $(DIR)/libgoodbye.a libgoodbye.o

clean:
	rm -f ./target/aahello
	rm -f ./host/aahello
	rm -f *.o
	rm -f ./target/*.a
	rm -f ./target/*.so
	rm -f ./host/*.a
	rm -f ./host/*.so
	rm -rf ./target
	rm -rf ./host





