MAIN = main
SHELL = /bin/bash
PROJECT = UnITeX_Classic
DATE = $(shell date +"%F-%H")

# Retreiving all source files
BIB = refs.bib
FIGS = $(shell find figs/* -type f)
STY = $(wildcard *.sty)
TEX = $(wildcard *.tex) $(wildcard sections/*.tex)

SOURCE = $(BIB) $(STY) $(TEX) $(FIGS)
GARBAGE = {bbl,synctex.gz}

# Setting LaTeX compile (latexmk) options & flags
MK = latexmk
# Generate pdf version of document using pdflatex
OUT = pdf
# Run a file previewer and continually update the files
OUT_MODE = pvc
# Sets the generation of pdf files by pdflatex
GENERATOR = pdflatex
OPT = -interaction=batchmode

HIDE = @
MAKE = make

# OS commands specific part
ifeq ($(OS),Windows_NT)
    RM = del /F /Q 
    RMDIR = -RMDIR /S /Q
    MKDIR = -mkdir
else
    RM = -rm -f 
    RMDIR = -rm -rf 
    MKDIR = -mkdir -p
endif

.PHONY: all $(MAIN).pdf clean targz zip

all: $(MAIN).pdf

$(MAIN).pdf: $(SOURCE)
	$(MK) -$(OUT) -$(OUT_MODE) -$(GENERATOR)="pdflatex $(OPT)" $(MAIN)
	$(MK) -c

dry: $(SOURCE)
	$(MK) -$(OUT) -$(GENERATOR)="pdflatex $(OPT)" $(MAIN)

clean:
	$(HIDE)$(RM) $(MAIN).$(GARBAGE)
	$(MK) -c
	$(HIDE)echo -e "\n'Classic' template cleaned !"

targz:
	$(MAKE) clean
	$(MAKE) dry
	$(MAKE) clean
	tar czf $(PROJECT)_$(DATE).tgz $(SOURCE)

zip:
	$(MAKE) clean
	$(MAKE) dry
	$(MAKE) clean
	zip -q $(PROJECT)_$(DATE).zip $(SOURCE)

