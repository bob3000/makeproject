CC=clang
CFLAGS=-g -Wall -O0
OBJDIR=obj
BINDIR=bin
SRCDIR=src

PROJDIR=$(shell basename $(CURDIR))
SRCS=$(wildcard $(SRCDIR)/*.c)
OBJS=$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRCS))
BIN=$(BINDIR)/$(PROJDIR)

all: $(BIN)

release: CFLAGS=-Wall -O2 -DNDBUG
release: clean $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

$(OBJDIR)/%o: $(SRCDIR)/%c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) -r $(BINDIR)/* $(OBJDIR)/*
