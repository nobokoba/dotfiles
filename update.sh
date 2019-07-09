#!/bin/sh
set -eu

DIR=`dirname $0`
BASENAME=`basename $0`
cd $DIR
brew update
brew upgrade
brew-file init -y
git add .
if [[ `git diff --cached` ]]; then
  git commit -m "weekly"
fi
git push
terminal-notifier  -title $BASENAME  -message "FINISHED!"
