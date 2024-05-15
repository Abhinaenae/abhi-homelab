#!/bin/bash
# Author: Abhinay Lavu
# Date: 05/15/2024
# Description: This script will ping multiple hosts and notify

hosts = "/home/alavu/scripts/myhosts"

for ip in $(cat $hosts)
do
    ping -c1 $ip &> /dev/null
    if [ $? -eq 0 ]
    then
    echo $ip is OK
    else
    echo $ip is NOT OK
    fi
done
