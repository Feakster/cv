# CV Compilation

<!-- Badges -->
[![license](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](https://choosealicense.com/licenses/mit/)
[![platform-suport](https://img.shields.io/badge/platform-linux%20%7C%20macos-lightgrey?style=flat-square)](https://en.wikipedia.org/wiki/Computing_platform)
[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg?style=flat-square)](https://www.tidyverse.org/lifecycle/#stable)

## Prerequisites
In order to compile this CV you will need to be using a Unix-like system with `pdfLaTeX` and `R` installed. `R` will need to have the _data.table_ and _rAltmetric_ packages installed. Additionally, Linux users will need to install `librsvg2-bin` via their distribution's package manager, while macOS users will need to install `librsvg` via [homebrew](https://brew.sh/).

## Compilation
Execute the following lines of code to clone the repository and compile the CV.

```bash
cd ~/Downloads
mkdir CV
git clone https://github.com/Feakster/cv.git CV/
cd CV
sh cv.sh
```
