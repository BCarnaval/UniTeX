# UniTeX

UniTeX is a collection of scientific oriented and minimalistic [LaTeX](https://www.latex-project.org/) templates suitable for many assignment types.

![LaTeX](https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) ![LICENSE](https://img.shields.io/github/license/BCarnaval/UniTeX?color=blue&style=for-the-badge) ![release](https://img.shields.io/github/v/tag/BCarnaval/UniTeX?color=gree&style=for-the-badge)

## Table of contents

- [Requirements](#requirements)
  - [TeX](#tex)
  - [Shell](#shell)
  - [PDF viewer (optional)](#pdf-viewer-optional)
- [Installation](#installation)
- [Quick start](#quick-start)
- [Screenshots](#screenshots)
  - [Classic](#classic)
  - [Article](#article)
  - [Homework](#homework)
  - [Cover Letter](#cover-letter)
- [Features](#features)
- [TODO](#todo)
- [Credits](#credits)

## Requirements

### TeX

UniTeX requires a complete TeX distribution (you can find the most used TeX distributions
[here](https://www.latex-project.org/get/#tex-distributions)). Most features need external tools such as latexmk that fully automates LaTeX document generation. Latexmk is usually part of TeX distributions like MikTeX and MacTeX but you can always install it separately by following [these](https://mg.readthedocs.io/latexmk.html) steps.

### Shell

A Unix shell is also required to install UniTeX properly. Commands such as `mkdir`, `cp`, `ln` and others are used within install script and makefiles so it's important for you to have access to this type of shell to install UniTeX correctly.

### PDF viewer (optional)

A pdf viewer like [Skim](https://skim-app.sourceforge.io/),
[Zathura](https://pwmt.org/projects/zathura/index.html) and [SumatraPDF](https://www.sumatrapdfreader.org/free-pdf-reader) is also fun to have
when working on LaTeX projects.

## Installation

The ideal way to install UniTeX is via the install script `install.sh`.

```shell
$ git clone https://github.com/BCarnaval/UniTeX
...
$ cd UniTeX && chmod +x install.sh && ./install.sh
```

By doing it like so, you will be able to use UniTeX's commands `unitex -h`.

<table>
  <tr>
    <td>Usage outputed by unitex</td>
  </tr>
  <tr>
    <td><img src="/../screenshots/screenshots/unitex_cmd.png" width=880 height=320></td>
  </tr>
 </table>

## Quick start

Once [installation](#Installation) properly done and `unitex -h` command outputs no error, you can directly build
your first UniTeX template

1. Select a directory (folder) on your machine in which store template's files that you'll edit later. For the example, we will use a folder named **test** in home directory.

```shell
$ mkdir ~/test
```

2. Build your template inside this directory using `unitex` by specifying the flags **-b build**: template (classic, article, homework, cover), **-d directory**: directory in which build it (directory created in step 1.) and **-o opt**: building options (`clean`, `dry`, `targz`, `zip` or empty to tell latexmk to continuously compile your project on save).

```shell
$ unitex -b classic -d ~/test -o dry
```

Here, the `dry` option means that latexmk will not compile your project continuously and not clean the directory either. It will simply build the template inside the specified directory and leave all files there. To clean it, you must use the option `clean` with the `-o` flag. These commands being done (`dry` and `clean`), you should have the following content inside your **test** folder

```shell
$ ls ~/test
Makefile
PageTitre.tex
colors.sty
commands.sty
figs/
main.pdf
main.tex
refs.bib
sections/
style.sty
```

3. If you read this I am assuming that your **test** directory isn't missing any files and you now are ready to configure/customize the template to satisfy the nature of your project. To do this, you simply open your favorite text editor and remove default values from `PageTitre.tex`, `main.tex`, all the files inside `sections/` and `figs/` directories, references from `refs.bib` and feel free to add your personnal commands inside `commands.sty`.

## Screenshots

### Classic

Example of what you should get from 'classic' template with [Yale](https://en.wikipedia.org/wiki/Yale_University)'s darkblue as main color

<table>
  <tr>
    <td>Default title page</td>
    <td>Sections layout</td>
  </tr>
  <tr>
    <td><img src="/../screenshots/screenshots/Classic/title_screen.png" width=360 height=480></td>
    <td><img src="/../screenshots/screenshots/Classic/mid_screen.png" width=360 height=480></td>
  </tr>
 </table>

<table>
  <tr>
    <td>Maths display</td>
    <td>References</td>
  </tr>
  <tr>
    <td><img src="/../screenshots/screenshots/Classic/math_screen.png" width=360 height=480></td>
    <td><img src="/../screenshots/screenshots/Classic/refs_screen.png" width=360 height=480></td>
  </tr>
 </table>
 
### Article

IN DEVELOPPEMENT

### Homework

Example of what you should get from 'homework' template with [Princeton](https://en.wikipedia.org/wiki/Princeton_University)'s orange as main color

<table>
  <tr>
    <td>Default title page</td>
    <td>Problem(s) presentation</td>
  </tr>
  <tr>
    <td><img src="/../screenshots/screenshots/Homework/title_screen.png" width=360 height=480></td>
    <td><img src="/../screenshots/screenshots/Homework/problem_screen.png" width=360 height=480></td>
  </tr>
 </table>

<table>
  <tr>
    <td>Basic problem solving</td>
    <td>References</td>
  </tr>
  <tr>
    <td><img src="/../screenshots/screenshots/Homework/res_screen.png" width=360 height=480></td>
    <td><img src="/../screenshots/screenshots/Homework/refs_screen.png" width=360 height=480></td>
  </tr>
 </table>
 
### Cover Letter

Example of what you should get from 'cover' template with [Cornflower blue](https://en.wikipedia.org/wiki/Cornflower_blue) as main color

<table>
  <tr>
    <td>Default cover letter</td>
  </tr>
  <tr>
    <td><img src="/../screenshots/screenshots/Cover/cover_screen.png" width=360 height=480></td>
  </tr>
 </table>
 
## Features

IN DEVELOPPEMENT.

## TODO

- [x] 'Classic' template
- [x] Add MIT license
- [ ] 'Article' template (RevTeX)
- [x] 'Cover Letter' template
- [x] 'Homework' template (Overleaf's rebuild)
- [x] Install/uninstall scripts
- [ ] Test on fresh Linux and Mac OS (Docker)
  - [x] Installation fresh ubuntu (git & sudo post installed).
  - [ ] Build template.
- [x] Man pages (MacOS, Linux)
- [x] Version control
- [ ] REAME.md
- [ ] Add all well explained commands and features
- [ ] Setup default pdf viewer based on OS

## Credits
