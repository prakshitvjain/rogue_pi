#!/bin/bash
# Script to run for cronjob
# Cronjob: * * * * * $(whoami) ./initial_script.sh
# Author: Prakshit V Jain

set -e 

# checking for successful ethernet connection
x=$(ip -4 addr show scope global | grep eth | grep inet | awk '{print $2}') | cut -d/ -f1
if [ -z "$x" ]
then
  echo "No Ethernet Connected, quitting"
  exit 1

else
  # we configure the kali ARM to require no password or configure user kali to act as root without password
  sudo su
  if [ "$(id -u)" -ne 0 ]; then
    echo "Error migrating to root"
    exit 1
  else
    echo "Ethernet Detected"
    echo "Starting the attack Script"
    # deleting the cronjob and stopping the service
    crontab -r  
    systemctl stop crond

    # executing main.sh
    chmod +x main.sh
    ./main.sh
  fi
fi

