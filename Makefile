# Usage docs
#
#

PROJDIR := $(realpath $(CURDIR))
SOURCEDIR_C := $(PROJDIR)/Classic/
SOURCEDIR_A := $(PROJDIR)/Article/

TARGET_C = UnITeX_Classic
TARGET_A = UnITeX_Article
TARGET_H = UnITeX_Homework

DIRS = sections figs
SOURCES = $(foreach dir, $(DIRS), $(addprefix $(SOURCEDIR), $(dir)))

FILES_TEX = $(wildcard $(SOURCEDIR)*.tex)
FILES_BIB = $(wildcard $(SOURCEDIR)*.bib)
FILES_STY = $(wildcard $(SOURCEDIR)*.sty)

FILES = $(FILES_TEX) $(FILES_BIB) $(FILES_STY)

SUBFILES_TEX = $(foreach dir, $(DIRS), $(wildcard $(dir)/*.tex))
SUBFILES_BIB = $(foreach dir, $(DIRS), $(wildcard $(dir)/*.bib))
SUBFILES_STY = $(foreach dir, $(DIRS), $(wildcard $(dir)/*.sty))
FIGS = $(foreach dir, $(SOURCES), $(shell find $(dir)/* -type f))

SUBFILES = $(SUBFILES_TEX) $(SUBFILES_BIB) $(SUBFILES_STY) $(FIGS)

# OS specific part
ifeq ($(OS),Windows_NT)
    RM = del /F /Q 
    RMDIR = -RMDIR /S /Q
    MKDIR = -mkdir
else
    RM = rm -f 
    RMDIR = rm -rf 
    MKDIR = mkdir -p
endif

HIDE = @
VERBOSE = TRUE

.PHONY: classic article homework clean_all

classic:
	$(HIDE)$(MAKE) -C $(SOURCEDIR_C)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_C)

article:
	$(HIDE)$(MAKE) -C $(SOURCEDIR_A)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_A)

homework:
	$(HIDE)$(MAKE) -C $(SOURCEDIR_H)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_H)

clean_all:
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_C)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_A)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_H)
# $(MAIN).pdf: $(FILES) $(SUBFILES)
# 	@echo $(FILES)
# 	@echo "\n"
# 	@echo $(SUBFILES)
# 	@echo "\n"
# 	$(MK) -pdf -pvc -pdflatex="pdflatex $(OPT)" $(MAIN)
# 	$(MK) -CA

# $(MK) -CA $(MAIN)
# @echo "\nCleaning finished!"
#
# MAIN = main
# SHELL = /bin/bash
# PROJECT = 'UnITeX'
# DATE = $(shell date +"%F-%H")
#
# BIB = refs.bib
# FIGS = $(shell find figs/* -type f)
# STY = colors.sty style.sty commands.sty
# TEX = $(MAIN).tex PageTitre.tex sections/*.tex
#
# OPT = -interaction=batchmode
# SOURCE = $(BIB) $(STY) $(TEX) $(FIGS)
#
# all: $(MAIN).pdf
#
# $(MAIN).pdf: $(SOURCE)
# 	latexmk -pdf -pvc -pdflatex="pdflatex $(OPT)" $(MAIN)
# 	latexmk -CA
#
# dry: $(SOURCE)
# 	latexmk -pdf -pvc -pdflatex="pdflatex $(OPT)" $(MAIN)
#
# nomk: $(SOURCE)
# 	pdflatex $(MAIN)
# 	bibtex $(MAIN)
# 	pdflatex $(MAIN)
# 	pdflatex $(MAIN)
# 	pdflatex $(MAIN)
#
# clean:
# 	latexmk -CA
#
# clean_nomk:
# 	-rm -f $(MAIN).{pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls}
# 	-rm -f $(MAIN).{fdb_latexmk,synctex.gz}
# 	-rm -f sections/*.{pdf,log,blg,bbl,aux,out,toc,idx,bcf,run.xml,ind,ilg,fls}
# 	-rm -f sections/*.{fdb_latexmk,synctex.gz}
#
# targz:
# 	$(MAKE) clean_nomk
# 	$(MAKE) nomk
# 	$(MAKE) clean_nomk
# 	tar czf $(PROJECT)_$(DATE).tgz $(SOURCE)
#
# zip:
# 	$(MAKE) clean_nomk
# 	$(MAKE) nomk
# 	$(MAKE) clean_nomk
# 	zip -q $(PROJECT)_$(DATE).zip $(SOURCE)
#

