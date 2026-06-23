#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

NEW_SERIAL_DESIGN=$1

HALF_FULL=`gpiofind "PCC.02"`
HALF_FULL_VAL=0
RS422_232=`gpiofind "PG.06"`
RS422_232_VAL=1

PID_HALF_FULL=""
PID_RS422_232=""

if $NEW_SERIAL_DESIGN; then

	gpioset --mode=signal $HALF_FULL=$HALF_FULL_VAL &
	PID_HALF_FULL=$!
	gpioset --mode=signal $RS422_232=$RS422_232_VAL &
	PID_RS422_232=$!

	sudo gtkterm -p /dev/ttyTHS1 -s 115200
else
	sudo gtkterm -p /dev/ttyTHS1 -s 115200
fi

if $NEW_SERIAL_DESIGN; then
	kill $PID_RS422_232
	kill $PID_HALF_FULL
fi

