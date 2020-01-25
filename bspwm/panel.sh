#!/bin/bash

normal_color="#353535"
sel_color="#be0105"
grey_color="#808080"
white_color="#FFFFFF"

workspaces(){
	for i in {2..11};do
		SPACE=`bspc wm --get-status | cut -d ":" -f $i`
		if [ "${SPACE:0:1}" == "O" ] || [ "${SPACE:0:1}" == "F" ]; then
			echo -n "^fg($white_color) ^bg($sel_color)"
		elif [ "${SPACE:0:1}" == "o" ]; then
			echo -n "^fg($white_color) ^bg($normal_color)"
		elif [ "${SPACE:0:1}" == "f" ]; then
			echo -n "^fg($grey_color) ^bg($normal_color)"
		fi
		echo -n " ${SPACE:1}"
	done
}

setime(){
	tiMe=`date +"%a %I:%M%p"`
	echo -n $tiMe
}

charging=0
battery(){
	status=`cat /sys/class/power_supply/BAT0/status`
	capacity=`cat /sys/class/power_supply/BAT0/capacity`
	if [[ $status == "Charging" || $status == "Full" ]]; then
		charging=1
		echo -n "BAT: $capacity% ($status)"
	else
		charging=0
		echo -n "BAT: $capacity%"
	fi
}

user(){
	echo -n `whoami`
}

opstatus(){
	while true; do
		workspaces
		echo -n "^p("_RIGHT")"
		if [ $charging -eq 1 ]; then
			echo -n "^p("-385")"
		else
			echo -n "^p("-300")"
		fi
		battery
		echo -n " "
		setime
		echo -n " "
		user
		echo
		sleep 1
	done
}

opstatus | dzen2 -w 1920 -h 24 -e - -ta l -fn terminus -bg "#353535"
