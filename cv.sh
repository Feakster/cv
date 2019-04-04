#!/bin/bash

#================================#
#                                #
#### COMPILE CURRICULUM VITAE ####
#                                #
#================================#

### TODO ###
# - Find out why pdf compilation results in translucent images.

### Get Altmetric Rosettes ###
echo 'Acquiring Altmetric Rosettes ...'
Rscript "badges.R"

### Compile PDF ###
echo 'Compiling PDF ...'
xelatex -no-pdf "cv.tex" > /dev/null
xelatex "cv.tex" > /dev/null

### Tidy Up ###
echo 'Removing Ancillary Files ...'
rm "cv.aux" "cv.log" "cv.out"

echo 'CV Ready!'
