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
  URL=https://static-content.dimensions.ai/static/radar/default/logo-20190221.svg
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
  URL=https://unpkg.com/ionicons@5.2.3/dist/svg/mail.svg
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
  URL=https://unpkg.com/ionicons@5.2.3/dist/svg/logo-github.svg
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
  URL=https://unpkg.com/ionicons@5.2.3/dist/svg/call.svg
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
  URL=https://unpkg.com/ionicons@5.2.3/dist/svg/logo-twitter.svg
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
  URL=https://unpkg.com/ionicons@5.2.3/dist/svg/globe.svg
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
