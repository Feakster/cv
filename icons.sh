#!/bin/bash

#=====================#
#                     #
#### ACQUIRE ICONS ####
#                     #
#=====================#

### Install librsvg ###
# brew install librsvg # macOS
# sudo apt install librsvg2-bin # Ubuntu

### Directory Object ###
DIR="icons"

### Generate Output Directory ###
if [ ! -d "$DIR" ]
then
  echo 'Creating icons directory ...'
  mkdir icons
fi

### Get Vector Graphics ###
echo 'Downloading icons ...'
if [ ! -f "./$DIR/dimensions.svg" ]
then
  curl -s https://38h6q83kpel22aipe0iux4i1-wpengine.netdna-ssl.com/wp-content/themes/dimensions/public/images/logo.svg > "./$DIR/dimensions.svg" # Dimensions
fi

if [ ! -f "./$DIR/email.svg" ]
then
  curl -s http://www.clker.com/cliparts/0/6/8/3/12065629431871551574qubodup_16x16px-capable_black_and_white_icons_10.svg > "./$DIR/email.svg" # Email
fi

if [ ! -f "./$DIR/github.svg" ]
then
  curl -s https://image.flaticon.com/icons/svg/25/25231.svg > "./$DIR/github.svg" # GitHub
fi

if [ ! -f "./$DIR/phone.svg" ]
then
  curl -s http://cdn.onlinewebfonts.com/svg/download_247097.svg > "./$DIR/phone.svg" # Phone
fi

if [ ! -f "./$DIR/twitter.svg" ]
then
  curl -s https://image.flaticon.com/icons/svg/8/8800.svg > "./$DIR/twitter.svg" # Twitter
fi

if [ ! -f "./$DIR/website.svg" ]
then
  curl -s https://openclipart.org/download/216096/WWW-Icon.svg > "./$DIR/website.svg" # Website
fi

### Convert SVG to PDF ###
echo 'Converting icons ...'
for FILE in dimensions email github phone twitter website
do
  if [ ! -f "./$DIR/$FILE.pdf" ]
  then
  rsvg-convert -f pdf -o "./$DIR/$FILE.pdf" "./$DIR/$FILE.svg"
fi

done
