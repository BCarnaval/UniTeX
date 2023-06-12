<div align="center">

# UniTeX

UniTeX is a collection of scientific oriented and minimalistic [LaTeX](https://www.latex-project.org/) templates suitable for many assignment types.

![LaTeX](https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) ![Overleaf](https://img.shields.io/badge/Overleaf-47A141?style=for-the-badge&logo=Overleaf&logoColor=white)

![LICENSE](https://img.shields.io/github/license/BCarnaval/UniTeX?color=blue&style=for-the-badge) ![release](https://img.shields.io/github/v/tag/BCarnaval/Unitex?color=%23FF7F50&style=for-the-badge)

</div>

# Table of contents

[Overleaf support](#overleaf-support)

<details>
  <summary><a href="#requirements-full-installation">Requirements (full installation)</a></summary>
  <OL, TYPE="square">
    <li><a href="#tex">TeX</a></li>
    <li><a href="#shell">Shell</a></li>
    <li><a href="#pdf-viewer">PDF viewer</a></li>
  </OL>
</details>

<details>
  <summary><a href="#installation">Installation</a></summary>
  <OL, TYPE="square">
    <li><a href="#unix-based-os">Unix based OS</a></li>
    <li><a href="#windows">Windows</a></li>
  </OL>
</details>

[Quick start](#quick-start)

[Features](#features)

<details>
  <summary><a href="#screenshots">Screenshots</a></summary>
  <OL, TYPE="square">
    <li><a href="#classic">Classic</a></li>
    <li><a href="#homework">Homework</a></li>
    <li><a href="#cover-letter">Cover letter</a></li>
  </OL>
</details>

[TODO](#todo)

[Credits](#credits)

# Overleaf support

Using UniTeX templates inside an [Overleaf](https://www.overleaf.com/) project is encouraged and pretty simple to setup. Download the .zip file associated with wanted template and upload it inside [Overleaf](https://www.overleaf.com/) by selecting `New project > Upload project > Select a .zip file`. To do so, download any template folder using the links:

<div align="center">

| Classic                                                                                                  | Homework                                                                                                  | Cover                                                                                                  |
| -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| [Download](https://downgit.evecalm.com/#/home?url=https://github.com/BCarnaval/UniTeX/tree/main/Classic) | [Download](https://downgit.evecalm.com/#/home?url=https://github.com/BCarnaval/UniTeX/tree/main/Homework) | [Download](https://downgit.evecalm.com/#/home?url=https://github.com/BCarnaval/UniTeX/tree/main/Cover) |

</div>

then import wanted template directly from [Overleaf](https://www.overleaf.com/).

# Requirements (full installation)

### TeX

UniTeX requires a complete TeX distribution (you can find the most used TeX distributions
[here](https://www.latex-project.org/get/#tex-distributions)). Most features need external tools such as latexmk that fully automates LaTeX document generation. Latexmk is usually part of TeX distributions like MikTeX and MacTeX but you can always install it separately by following [these](https://mg.readthedocs.io/latexmk.html) steps.

### Shell

A Unix shell is better to install UniTeX properly. Commands such as `mkdir`, `cp`, `ln` and others are used within install script and makefiles so it's important for you to have access to this type of shell to install UniTeX correctly.

### PDF viewer

A responsive pdf viewer like [Skim](https://skim-app.sourceforge.io/),
[Zathura](https://pwmt.org/projects/zathura/index.html) and [SumatraPDF](https://www.sumatrapdfreader.org/free-pdf-reader) is also a must have
when working on LaTeX projects. These are some viewers that provide automatic refresh on file change and this is why they are working very well with `latexmk`. For example, using Skim on MacOS, the viewer settings offer to check automatically for changes and reload the pdf
<div align="center">
    <tr>
      <td><img src="/../screenshots/screenshots/skim_example.png" width=320 height=200></td>
    </tr>
</div>

# Installation

### Unix based OS

The ideal way to install UniTeX is via the install script `install.sh`.

```shell
git clone https://github.com/BCarnaval/UniTeX
```
```shell
cd UniTeX && chmod +x install.sh && ./install.sh
```

By doing it like so, you will be able to use UniTeX's commands (see `unitex -h`).

### Windows

On Windows, `install.sh` might be not the best way to use UniTeX. I personnally suggest to people in this situation to clone the repository somewhere on their system and use directly template's folder `Classic`, `Article`, `Homework` and `Cover`. Makefiles should work properly so one can copy `Homework` template for some homework and, in the same directory, use

```shell
make <dry, clean, all, zip, targz>
```

to work with it.

# Quick start

Once [installation](#installation) properly done and `unitex -h` command outputs no error, you can directly build any UniTeX template

1. Select a directory (folder) in which store template's files to edit later. For the example, we use a folder named **test** in home directory.

```shell
mkdir ~/test
```

2. Build the template inside previous directory using `unitex` by specifying the flags **-b build**: template (classic, article, homework, cover), **-d directory**: directory in which build it (directory created in step 1.) and **-o opt**: building options (`clean`, `dry`, `targz`, `zip` or empty to tell latexmk to continuously compile your project on save).

```shell
unitex -b classic -d ~/test -o dry
```

Here, the `dry` option means that latexmk will not compile your project continuously and not clean the directory either. It will simply build the template inside the specified directory and leave stallite files there. To clean it, you must use the option `clean` with the `-o` flag. These commands being done (`dry` and `clean`), you should have the following content inside your **test** folder

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

3. Assuming that **test** directory isn't missing any files, you can configure/customize the template to satisfy the nature of your project. Simply open your text editor and remove default values from `main.tex`, all the files inside `sections/` and `figs/` directories, references from `refs.bib` and feel free to add your personnal commands/style features inside `commands.sty`, `style.sty`.

# Features

IN DEVELOPPEMENT.

# Screenshots

### Classic

Example from 'classic' template with [Yale](https://en.wikipedia.org/wiki/Yale_University)'s darkblue as main color

<div align="center">
  <table>
    <tr>
      <td>Default title page</td>
      <td>Sections layout</td>
    </tr>
    <tr>
      <td><img src="/../screenshots/screenshots/Classic/title.png" width=360 height=480></td>
      <td><img src="/../screenshots/screenshots/Classic/body.png" width=360 height=480></td>
    </tr>
   </table>

  <table>
    <tr>
      <td>Maths display</td>
      <td>References</td>
    </tr>
    <tr>
      <td><img src="/../screenshots/screenshots/Classic/math.png" width=360 height=480></td>
      <td><img src="/../screenshots/screenshots/Classic/refs.png" width=360 height=480></td>
    </tr>
   </table>
</div>

### Homework

Example from 'homework' template with [lavender](https://www.w3schools.com/colors/color_tryit.asp?color=Lavender) as main color

<div align="center">
  <table>
    <tr>
      <td>Default title page</td>
      <td>Problem(s) presentation</td>
    </tr>
    <tr>
      <td><img src="/../screenshots/screenshots/Homework/title.png" width=360 height=480></td>
      <td><img src="/../screenshots/screenshots/Homework/problem_1.png" width=360 height=480></td>
    </tr>
   </table>

  <table>
    <tr>
      <td>Basic problem solving</td>
      <td>Problem(s) presentation</td>
    </tr>
    <tr>
      <td><img src="/../screenshots/screenshots/Homework/body_1.png" width=360 height=480></td>
      <td><img src="/../screenshots/screenshots/Homework/problem_2.png" width=360 height=480></td>
    </tr>
   </table>
</div>

### Cover Letter

Example from 'cover' template with [light blue](https://www.w3schools.com/colors/color_tryit.asp?color=LightBlue) as main color

<div align="center">
  <table>
    <tr>
      <td>Default cover letter</td>
    </tr>
    <tr>
      <td><img src="/../screenshots/screenshots/Cover/cover.png" width=360 height=480></td>
    </tr>
  </table>
</div>

# TODO

- [x] 'Classic' template
- [x] 'Homework' template (Overleaf's rebuild)
- [x] 'Cover Letter' template
- [ ] 'RevTeX' template
- [ ] 'Beamer' template
- [x] Install/uninstall scripts
- [x] Version control
- [ ] REAME.md
- [ ] Add all well explained commands and features
  - [ ] Supported colors
  - [ ] Supported Universities (emblems + colors)
- [ ] Setup default pdf viewer based on OS
- [ ] Rebuild 'Homework' template's `quesiton{}{}` command as newenvironnement

# Credits
