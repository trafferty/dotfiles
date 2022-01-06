#!/bin/bash

#
# good crontab for this: 
#   0 17 * * *  /Users/trafferty/domount.sh 2>&1 | tee -a ~/mount_log.txt
#

echo '-------------------------------------------------------------' 
echo 'Mounting drives ('${0##*/}'):' $(date +%m-%d-%yT%H:%M:%S)
echo '-------------------------------------------------------------' 

declare -a DRIVES=(
  '/dev/disk2s2'
  '/dev/disk2s3'
  '/dev/disk2s4'
);

COUNT=${#DRIVES[@]} 

for idx in $(seq 0 $(($COUNT-1)) )
do
  echo '>>>  mounting:' ${DRIVES[$idx]}
  /usr/sbin/diskutil mount ${DRIVES[$idx]}
done