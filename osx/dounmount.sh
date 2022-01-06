#!/bin/bash

#
# good crontab for this: 
#   0 17 * * *  /Users/trafferty/dounmount.sh 2>&1 | tee -a ~/unmount_log.txt
#

echo '-------------------------------------------------------------' 
echo 'Unmounting drives ('${0##*/}'):' $(date +%m-%d-%yT%H:%M:%S)
echo '-------------------------------------------------------------' 

declare -a DRIVES=(
  '/dev/disk2'
  '/dev/disk3'
);

COUNT=${#DRIVES[@]} 

echo '>>>  stopping tmutil'
/usr/bin/tmutil stopbackup

for idx in $(seq 0 $(($COUNT-1)) )
do
  echo '>>>  unmounting:' ${DRIVES[$idx]}
  /usr/sbin/diskutil unmountDisk ${DRIVES[$idx]}
done
