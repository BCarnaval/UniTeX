# Usage docs
#
#

.PHONY: all $(MAIN).pdf nomk clean clean_nomk targz zip

MAIN = main
SHELL = /bin/bash
PROJECT = 'UnITeX_Article'
DATE = $(shell date +"%F-%H")

# Retreiving all source files
BIB = refs.bib
FIGS = $(shell find figs/* -type f)
STY = $(wildcard *.sty)
TEX = $(wildcard *.tex) $(wildcard sections/*.tex)

OPT = -interaction=batchmode
SOURCE = $(BIB) $(STY) $(TEX) $(FIGS)

all: $(MAIN).pdf

$(MAIN).pdf: $(SOURCE)
	latexmk -pdf -pvc -pdflatex="pdflatex $(OPT)" $(MAIN)
	latexmk -CA

dry: $(SOURCE)
	latexmk -pdf -pvc -pdflatex="pdflatex $(OPT)" $(MAIN)

nomk: $(SOURCE)
	pdflatex $(MAIN)
	bibtex $(MAIN)
	pdflatex $(MAIN)
	pdflatex $(MAIN)
	pdflatex $(MAIN)

clean:
	latexmk -CA

clean_nomk:
	-rm -f $(MAIN).{pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls}
	-rm -f $(MAIN).{fdb_latexmk,synctex.gz}
	-rm -f sections/*.{pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls}
	-rm -f sections/*.{fdb_latexmk,synctex.gz}

targz:
	$(MAKE) clean_nomk
	$(MAKE) nomk
	$(MAKE) clean_nomk
	tar czf $(PROJECT)_$(DATE).tgz $(SOURCE)

zip:
	$(MAKE) clean_nomk
	$(MAKE) nomk
	$(MAKE) clean_nomk
	zip -q $(PROJECT)_$(DATE).zip $(SOURCE)

