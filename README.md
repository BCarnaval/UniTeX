# UniTeX

UniTeX is a collection of scientific oriented and minimalistic [LaTeX](https://www.latex-project.org/) templates suitable for many assignement types.

![LaTeX](https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

## Table of contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick start](#quick-start)
  - [Sub-element](#sub-element)
- [Screenshots](#screenshots)
- [Features](#features)

  - [x] 'Classic' template & Makefile
  - [ ] 'Article' template
  - [ ] 'Homework' template
  - [ ] Bash install script
  - [ ] Test on different OS (Docker?)
  - [ ] README yikes

- [Credits](#credits)

## Requirements

UniTeX requires a complete TeX distribution (you can find the most used TeX distributions 
[here](https://www.latex-project.org/get/#tex-distributions)). Most features need external tools such as latexmk that fully automates LaTeX document generation. Latexmk is usually part of TeX distributions like MikTeX and MacTeX but you can always install it by following [these](https://mg.readthedocs.io/latexmk.html) steps.

A Unix shell is also required to install UniTeX properly and build it's templates. A pdf viewer like [Skim](https://skim-app.sourceforge.io/), 
[Zathura](https://pwmt.org/projects/zathura/index.html) and [SumatraPDF](https://www.sumatrapdfreader.org/free-pdf-reader) is also fun to have 
when working on LaTeX projects.

## Installation

The ideal way to install UniTeX templates is via the install script `install.sh`.
```shell
$ git clone https://github.com/BCarnaval/UniTeX
...
$ cd UniTeX && chmod +x install.sh && ./install.sh
```
By doing it like so, you will be able to use UniTeX command such as `unitex -build ...` and others.

## Quick start

### Sub-element

## Screenshots

## Features

## Credits
