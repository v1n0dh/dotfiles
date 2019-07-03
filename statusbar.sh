#!/bin/bash

Time(){
	Time=$(date +"%a %I:%M%p")
	icon=""
	echo -e "$icon $Time"
}

battery(){
	charging=$(acpi -b | cut -d ":" -f 2 | awk '{print $1}')
	battery=$(acpi -b | cut -d "," -f 2 | sed 's/.$//')
	battery_percentage=$(acpi -b | cut -d "," -f 2 )
	if [ "$charging" == "Charging," ]
	then
		icon=""
	elif [ $battery -le 20 ]
	then
		icon=""
	elif [ 20 -le $battery ] && [ $battery -le 40 ]
	then
		icon=""
	elif [ 40 -le $battery ] && [ $battery -le 60 ]
	then
		icon=""
	elif [ 60 -le $battery ] && [ $battery -le 80 ]
	then
		icon=""
	else
		icon=""
	fi
	echo -e "$icon$battery_percentage"
}

cpu(){
	cpu=$(free -h | awk '/^Mem/ {print $3 "/" $2}')
	icon=""
	echo -e "$icon $cpu"
}
while true
do
	xsetroot -name " $(cpu) | $(battery) | $(Time)"
	sleep 10s
done
