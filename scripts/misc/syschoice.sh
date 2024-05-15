#!/bin/bash
# Author: Abhinay Lavu
# Date: 05/15/2024
# Description: This script will provide a choice of various system administration commands

echo
echo "Choose one of the options below"
echo
echo 'a = Display processes' 
echo 'b = Report CPU and IO Stats'
echo 'c = Display free and used memory'
echo 'd = View CPU information'
echo 'e = View Kernel Ring Buffer'
echo

	read choice

	case $choice in

a) top;;
b) iostat;;
c) free;;
d) cat /proc/cpuinfo | more;;
e) dmesg | more;;
*) echo invalid choice - END.

	esac
echo
echo "Choose one of the options below"
echo
echo 'a = Display processes' 
echo 'b = Report CPU and IO Stats'
echo 'c = Display free and used memory'
echo 'd = View CPU information'
echo 'e = View Kernel Ring Buffer'
echo

	read choice

	case $choice in

a) top;;
b) iostat;;
c) free;;
d) cat /proc/cpuinfo | more;;
e) dmesg | more;;
*) echo invalid choice - END.

	esac
