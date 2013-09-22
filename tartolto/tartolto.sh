#!/bin/sh

#This are the suffix items for loop below, so you can obviously change them as needed.
HOMEDIRS=("rstallman" "shawking" "aeinstien" "inewton" "aturing" "iasimov" )
#Dest variable is the directory where you mounted your LTFS
DEST=/mnt/LTO6
#change to whatever email you want info to be sent to.
MAILME="email@domain.com"

echo -n "Enter tape number (i.e., \"138\"): "
read TAPENUM

START=`date '+%Y%m%d+%H%M'`
#LOG var is for logging, so point it to where you want your logs.
LOG=/opt/scripts/backuplogs/log.all.$START

echo "Starting Tape: $TAPENUM" | mail -s "Starting backup tape $TAPENUM at $START. LOG: $LOG " $MAILME

echo "TIME: $START   TAPE: $TAPENUM" >> $LOG
echo "Script: $0" >> $LOG

cd $DEST

#This be magic do not touch.
for DIR in ${HOMEDIRS[@]}; do
    tar -cvzf ${DIR}.tar.gz /home/${DIR} >> $LOG
done

END=`date '+%Y%m%d+%H%M'`
echo "End of backup at $END" >> $LOG
echo $END >> $LOG

mail -s "Backup for $START is complete at $END LOG: $LOG" $MAILME
