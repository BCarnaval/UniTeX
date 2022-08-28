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
GARBAGE = {pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls,fdb_latexmk,synctex.gz}


# Setting LaTeX compile (latexmk) options & flags
MK = latexmk
OUT = pdf # Generate pdf version of document using pdflatex
OUT_MODE = pvc # Run a file previewer and continually update the files
GENERATOR = pdflatex # Sets the generation of pdf files by pdflatex
OPT = -interaction=batchmode

HIDE = @

# OS specific part
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
	$(MK) -CA

dry: $(SOURCE)
	$(MK) -$(OUT) -$(GENERATOR)="pdflatex $(OPT)" $(MAIN)

clean:
	$(MK) -CA
	$(HIDE)echo -e "'Classic' template cleaned!\n"

targz:
	$(MAKE) clean
	$(MAKE)
	$(MAKE) clean
	tar czf $(PROJECT)_$(DATE).tgz $(SOURCE)

zip:
	$(MAKE) clean
	$(MAKE)
	$(MAKE) clean
	zip -q $(PROJECT)_$(DATE).zip $(SOURCE)

