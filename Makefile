EMACS=emacs
EMACS_BATCH = $(EMACS) -Q -batch
EMACS_LOADPATH = -L .
EMACS_LOAD = $(EMACS_BATCH) $(EMACS_LOADPATH)
TARGET=$(patsubst %.el,%.elc,$(wildcard *.el))

.PHONY: all clean tags test
.PRECIOUS: %.elc

all: $(TARGET)

%.elc: %.el
	@echo "Compiling $<"
	@$(EMACS_LOAD) -f batch-byte-compile $<

check-declare:
	@$(EMACS_LOAD) --eval '(check-declare-file "url-scgi.el")'
	@$(EMACS_LOAD) --eval '(check-declare-file "url-scgi-tests.el")'

clean:
	rm -f $(TARGET) TAGS

tags:
	etags url-scgi.el

test: all check-declare
	@$(EMACS_LOAD) -l url-scgi-tests.el -f ert-run-tests-batch-and-exit
