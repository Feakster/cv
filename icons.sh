#!/usr/bin/env bash

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
## Dimensions Icon ##
if [ ! -f "./$DIR/dimensions.svg" ]
then
  URL=https://38h6q83kpel22aipe0iux4i1-wpengine.netdna-ssl.com/wp-content/themes/dimensions/public/images/logo.svg
  if curl -Is $URL | head -n 1 | grep "200" > /dev/null
  then
    curl -s $URL > "./$DIR/dimensions.svg"
  else
    echo "Dimensions icon not found"
    exit 1
  fi
fi

## Email Icon ##
if [ ! -f "./$DIR/email.svg" ]
then
  URL=http://www.clker.com/cliparts/0/6/8/3/12065629431871551574qubodup_16x16px-capable_black_and_white_icons_10.svg
  if curl -Is $URL | head -n 1 | grep "200" > /dev/null
  then
    curl -s $URL > "./$DIR/email.svg"
  else
    echo "Email icon not found"
    exit 1
  fi
fi

## GitHub Icon ##
if [ ! -f "./$DIR/github.svg" ]
then
  URL=https://image.flaticon.com/icons/svg/25/25231.svg
  if curl -Is $URL | head -n 1 | grep "200" > /dev/null
  then
    curl -s $URL > "./$DIR/github.svg"
  else
    echo "GitHub icon not found"
    exit 1
  fi
fi

## Phone Icon ##
if [ ! -f "./$DIR/phone.svg" ]
then
  URL=http://cdn.onlinewebfonts.com/svg/download_247097.svg
  if curl -Is $URL | head -n 1 | grep "200" > /dev/null
  then
    curl -s $URL > "./$DIR/phone.svg"
  else
    echo "Phone icon not found"
    exit 1
  fi
fi

## Twitter Icon ##
if [ ! -f "./$DIR/twitter.svg" ]
then
  URL=https://image.flaticon.com/icons/svg/8/8800.svg
  if curl -Is $URL | head -n 1 | grep "200" > /dev/null
  then
    curl -s $URL > "./$DIR/twitter.svg"
  else
    echo "Twitter icon not found"
    exit 1
  fi
fi

## Website Icon ##
if [ ! -f "./$DIR/website.svg" ]
then
  URL=https://openclipart.org/download/216096/WWW-Icon.svg
  if curl -Is $URL | head -n 1 | grep "200" > /dev/null
  then
    curl -s $URL > "./$DIR/website.svg"
  else
    echo "Website icon not found"
    exit 1
  fi
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
