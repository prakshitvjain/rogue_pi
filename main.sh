#!/bin/bash
# Main Script to be executed by initial_script.sh
# Author: Prakshit V Jain

set -e

# find the subnet
subnet = $(ip route | grep eth | grep -v default | awk '{print $1}')

#perform host scan using nmap
nmap -sn "$subnet" -T3 -oA host_scan
cat host_scan | grep "scan report" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' > hosts.txt

# use for loop to perform individual service scan on all hosts 
