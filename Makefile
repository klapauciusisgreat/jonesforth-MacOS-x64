SHELL	:= /bin/bash

all:	jonesforth

jonesforth: jonesforth.S
	gcc -nostdlib -static -o $@ $<

run:
	cat jonesforth.f $(PROG) - | ./jonesforth

clean:
	rm -f jonesforth perf_dupdrop *~ core .test_*

# Tests.

TESTS	:= $(patsubst %.f,%.test,$(wildcard test_*.f))

test check: $(TESTS)

test_%.test: test_%.f jonesforth
	@echo -n "$< ... "
	@rm -f .$@
	@cat <(echo ': TEST-MODE ;') jonesforth.f $< <(echo 'TEST') | \
	  ./jonesforth 2>&1 | \
	  sed 's/DSP=[0-9]*//g' > .$@
	@diff -u .$@ $<.out
	@rm -f .$@
	@echo "ok"

# Performance.

perf_dupdrop: perf_dupdrop.c
	gcc -O3 -Wall -Werror -o $@ $<

run_perf_dupdrop: jonesforth
	cat <(echo ': TEST-MODE ;') jonesforth.f perf_dupdrop.f | ./jonesforth

.SUFFIXES: .f .test
.PHONY: test check run run_perf_dupdrop

