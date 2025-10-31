#!/bin/bash
# Main Script to be executed by initial_script.sh
# Author: Prakshit V Jain

set -e

# find the subnet
subnet=$(ip route | grep eth | grep -v default | awk '{print $1}')

# perform host scan using nmap
nmap -sn "$subnet" -T3 -oA host_scan
grep "scan report" host_scan.gnmap | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' > hosts.txt

# use for loop to perform individual service scan on all hosts 
for ip in $(cat hosts.txt); do
  i=1
  sudo nmap "$ip" -Pn -sS -sV -v -sC -p- -T3 --max-retries 3 -D RND:10 -f -g 53 -oA "service_scan${i}"
  ((i++))
done
