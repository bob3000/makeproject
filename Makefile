CC=cc
CFLAGS=
CFLAGSDBG=-g -Wall -O0
CFLAGSRELEASE=-Wall -O2
LDLIBS=
OBJDIR=obj
BINDIR=bin
SRCDIR=src
DBGDIR=$(BINDIR)/debug
RELEASEDIR=$(BINDIR)/release

PROJDIR=$(shell basename $(CURDIR))
SRCS=$(wildcard $(SRCDIR)/*.c)
OBJS=$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRCS))
DBGBUILD=$(DBGDIR)/$(PROJDIR)
RELEASEBUILD=$(RELEASEDIR)/$(PROJDIR)

all: build

build: CFLAGS=$(CFLAGSDBG)
build: $(DBGBUILD)

release: CFLAGS=$(CFLAGSRELEASE)
release: clean $(RELEASEBUILD)

$(DBGBUILD): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDLIBS) -o $@

$(RELEASEBUILD): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDLIBS) -o $@

$(OBJDIR)/%o: $(SRCDIR)/%c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) -r $(DBGDIR)/* $(RELEASEDIR)/* $(OBJDIR)/*

run: $(DBGBUILD)
	./$(DBGBUILD)
