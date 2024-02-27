CC=cc
CFLAGS=
CFLAGSDBG=-g -Wall -O0
CFLAGSRELEASE=-Wall -O2
CFLAGSTEST=-g -Wall -O0
LDLIBS=
LDLIBSTEST=

OBJDIR=obj
BINDIR=bin
SRCDIR=src
TESTSDIR=tests
DBGDIR=$(BINDIR)/debug
RELEASEDIR=$(BINDIR)/release
TESTBINDIR=$(BINDIR)/test

PROJDIR=$(shell basename $(CURDIR))
SRCS=$(wildcard $(SRCDIR)/*.c)
OBJS=$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRCS))
TESTS=$(wildcard $(TESTSDIR)/*.c)
DBGBUILD=$(DBGDIR)/$(PROJDIR)
RELEASEBUILD=$(RELEASEDIR)/$(PROJDIR)
TESTBINS=$(patsubst $(TESTSDIR)/%.c, $(TESTBINDIR)/%, $(TESTS))

$(DBGBUILD): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDLIBS) -o $@

$(RELEASEBUILD): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDLIBS) -o $@

$(OBJDIR)/%o: $(SRCDIR)/%c
	$(CC) $(CFLAGS) -c $< -o $@

$(TESTBINDIR)/%: $(TESTSDIR)/%.c
	$(CC) $(CFLAGSTEST) $< $(LDLIBSTEST) -o $@

all: build

build: CFLAGS=$(CFLAGSDBG)
build: $(DBGBUILD)

release: CFLAGS=$(CFLAGSRELEASE)
release: clean $(RELEASEBUILD)

test: $(OBJS) $(TESTBINS)
	for test in $(TESTBINS); do ./$$test; done

clean:
	$(RM) -r $(OBJDIR)/* $(BINDIR)/*/*

run: $(DBGBUILD)
	./$(DBGBUILD)
