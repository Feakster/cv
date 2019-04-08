# CV Compilation

## Prerequisites
In order to compile this CV you will need to be using a Unix-like system with pdfLaTeX and R installed. Additionally, Linux users will need to install `librsvg2-bin` via their distribution's package manager, while macOS users will need to install `librsvg` via [homebrew](https://brew.sh/).

## Compilation
Execute the following lines of code to clone the repository and compile the CV.

```bash
cd ~/Downloads
mkdir CV
git clone https://github.com/Feakster/cv.git CV/
cd CV
sh cv.sh
```
