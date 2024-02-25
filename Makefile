CC=cc
CFLAGS=
CFLAGSDBG=-g -Wall -O0 $(CFLAGS)
CFLAGSRELEASE=-Wall -O2 $(CFLAGS)
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

all: $(DBGBUILD)

release: clean $(RELEASEBUILD)

$(DBGBUILD): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDLIBS) -o $@

$(RELEASEBUILD): $(OBJS)
	$(CC) $(CFLAGSRELEASE) $(OBJS) $(LDLIBS) -o $@

$(OBJDIR)/%o: $(SRCDIR)/%c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) -r $(DBGDIR)/* $(RELEASEDIR)/* $(OBJDIR)/*

run: $(DBGBUILD)
	./$(DBGBUILD)
