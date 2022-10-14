#!/bin/bash
DIR=/home/ikhsan/Maildir
LOG=/home/ikhsan/Maildir/getmail.log
date +%r-%-d/%-m/%-y >> $LOG
fetchmail
mv $DIR/new/* $DIR/process/landing/
cd $DIR/process/landing/
shopt -s nullglob
for i in *
do
echo "processing $i" >> $LOG
mkdir $DIR/process/extract/$i
cp $i $DIR/process/extract/$i/
echo "saving backup $i to archive"  >> $LOG
mv $i $DIR/process/archive
echo "unpacking $i" >> $LOG
munpack -C $DIR/process/extract/$i -q $DIR/process/extract/$i/$i
done
shopt -u nullglob
echo "finishing.." >> $LOG
mv $DIR/process/extract/* /$DIR/process/store/ 
echo "done!" >> $LOG