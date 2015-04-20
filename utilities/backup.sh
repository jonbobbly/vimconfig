#!/bin/bash
# vimbackup script
# Jonathon Bly
# To be run daily

### Config Options ###
SUFFIX="vimbackup.tar.gz" #Suffix for backup files
BACKDIR="$HOME/vimbackups"    #Directory the backups are stored to
DIRECTORIES="$HOME/.vim/* $HOME/.vimrc"
           # List of directories to backup
D2KEEP=7   #days to keep
W2KEEP=4   #weeks to keep
WONDAY=7   #day to perform weekly
MONDAY=1   #day to perform monthly
### End Config Options ###

DAY=`date +%u`
MONTH=`date +%m`
DATE=`date +%d`
YEAR=`date +%Y`

cd $BACKDIR
let LOOP=D2KEEP-1
while [ $LOOP -ge 1 ]; do
  if [ -e d$LOOP.$SUFFIX ]; then
    let NEXT=LOOP+1
    mv d$LOOP.$SUFFIX d$NEXT.$SUFFIX
  fi
  let LOOP=LOOP-1
done
tar -Pczf d1.$SUFFIX $DIRECTORIES
cp d$NEXT.$SUFFIX $DAILYCPY/d$NEXT.$SUFFIX
echo "$YEAR/$MONTH/$DATE : Daily backup done." >> backup.log
if [ $DAY -eq $WONDAY ]; then
  let LOOP=W2KEEP-1
  while [ $LOOP -ge 1 ]; do
    if [ -e w$LOOP.$SUFFIX ]; then
      let NEXT=LOOP+1
      mv w$LOOP.$SUFFIX w$NEXT.$SUFFIX
    fi
    let LOOP=LOOP-1
  done
  cp d1.$SUFFIX w1.$SUFFIX
  echo "$YEAR/$MONTH/$DATE : Weekly backup done." >> backup.log
fi
if [ $DATE -eq $MONDAY ]; then
  cp d1.$SUFFIX $YEAR.$MONTH.$SUFFIX
  echo "$YEAR/$MONTH/$DATE : Monthly backup done." >> backup.log
fi
