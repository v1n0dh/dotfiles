#!/bin/bash

tiMe(){
	tiMe=`date +"%a %I:%M%p"`
	echo $tiMe
}

battery(){
	status=`cat /sys/class/power_supply/BAT0/status`
	capacity=`cat /sys/class/power_supply/BAT0/capacity`
	if [[ $status == "Charging" || $status == "Full" ]]; then
		echo "BAT: $capacity% ($status)"
	else
		echo "BAT: $capacity%"
	fi
}

user(){
	echo `whoami`
}

while true; do
	xsetroot -name " $(battery) | $(tiMe) | $(user)"
done
