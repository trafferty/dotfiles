#!/bin/bash

#
# good crontab for this: 
#   0 17 * * *  /Users/trafferty/backup2USB.sh /Volumes/MacOS_SG/backup 2>&1 | tee -a ~/backup_log.txt
#

echo "[$(date +%m-%d-%yT%H:%M:%S)] Script starting ('${0##*/}')"

if [ $# -eq 0 ]; then
    echo "[$(date +%m-%d-%yT%H:%M:%S)] >>> No arguments supplied, exiting "
    exit 1
fi

if [ -z "$1" ]; then
    echo "[$(date +%m-%d-%yT%H:%M:%S)] >>> No arguments supplied, exiting"
    exit 1
fi

TARGET=$1

if [ ! -d $TARGET ]; then
    echo "[$(date +%m-%d-%yT%H:%M:%S)] >>> Target ($TARGET) does not exist or not connected, exiting"
    exit 1
fi

echo "-------------------------------------------------------------------------"
echo "[$(date +%m-%d-%yT%H:%M:%S)] Backup to $TARGET BEGIN"
echo "-------------------------------------------------------------------------"

declare -a SOURCES=(
  '/Users/trafferty/backup2USB.sh'
  '/Users/trafferty/.gitconfig'
  '/Users/trafferty/.bashrc'
  '/Users/trafferty/.bash_history'
  '/Users/trafferty/.bash_aliases'
  '/Users/trafferty/.ssh'
  '/usr/local/var/db/redis/dump.rdb'
  #'/Applications'
  #'/Users/trafferty/Applications'
  '/Users/trafferty/bin'
  '/Users/trafferty/data'
  '/Users/trafferty/tmp'
  '/Users/trafferty/Desktop'
  '/Users/trafferty/dev'
  '/Users/trafferty/Documents'
  '/Users/trafferty/Downloads'
  #'/Users/trafferty/Library'
  '/Users/trafferty/Movies'
  '/Users/trafferty/Music/iTunes/iTunes Media/Music'
  '/Users/trafferty/Pictures'
  '/Users/trafferty/src'
  '/Users/trafferty/workspace'
  '/Users/trafferty/workspace_tcs'
  '/Users/trafferty/workspace_VM'
  '/Users/trafferty/Virtual Machines.localized'
  '/Users/trafferty/VirtualBox VMs'
);

COUNT=${#SOURCES[@]} 

for idx in $(seq 0 $(($COUNT-1)) )
do
  echo "*************************************************************************************"
  echo "[$(date +%m-%d-%yT%H:%M:%S)] rsync $(($idx+1)) of $COUNT: ${SOURCES[$idx]} $TARGET"
  echo "*************************************************************************************"
  if [ -d ${SOURCES[$idx]} ]
  then
    echo '>>>  copying directory:' ${SOURCES[$idx]}
    /usr/bin/rsync -av --progress "${SOURCES[$idx]}" "$TARGET"
  else
    echo '>>>  copying file:' ${SOURCES[$idx]}
    /usr/bin/rsync -av --progress "${SOURCES[$idx]}" "$TARGET/"
  fi
done

echo "-------------------------------------------------------------------------"
echo "[$(date +%m-%d-%yT%H:%M:%S)] Backup to $TARGET END"
echo "-------------------------------------------------------------------------"
