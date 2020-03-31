#!/usr/bin/env bash

#================================#
#                                #
#### COMPILE CURRICULUM VITAE ####
#                                #
#================================#

### TODO ###
# - Find out why XeLaTeX compilation results in translucent images.

### Acquire Icons ###
echo 'Acquiring icons ...'
sh "icons.sh"

### Get Altmetric Badges ###
echo 'Acquiring Altmetric Badges ...'
Rscript "badges.R"

### Compile PDF ###
echo 'Compiling PDF ...'
pdflatex -synctex=1 -interaction=nonstopmode "cv.tex" > /dev/null # First compilation
pdflatex -synctex=1 -interaction=nonstopmode "cv.tex" > /dev/null # Second compilation
# xelatex -no-pdf "cv.tex" > /dev/null
# xelatex "cv.tex" > /dev/null

### Renaming ###
mv cv.pdf "Benjamin Feakins - CV.pdf"

### Tidy Up ###
echo 'Removing Ancillary Files ...'
rm "cv.aux" "cv.log" "cv.out" "cv.synctex.gz"

echo 'CV Ready!'
