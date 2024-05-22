#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_1=$1

HALF_FULL=`gpiofind "PCC.02"`
HALF_FULL_VAL=0
RS422_232=`gpiofind "PG.06"`
RS422_232_VAL=0

PID_HALF_FULL=""
PID_RS422_232=""

if $BOARD_REV_1_1; then

	gpioset --mode=signal $HALF_FULL=$HALF_FULL_VAL &
	PID_HALF_FULL=$!
	gpioset --mode=signal $RS422_232=$RS422_232_VAL &
	PID_RS422_232=$!

	sudo gtkterm -p /dev/ttyTHS3 -s 115200
else
	sudo gtkterm -p /dev/ttyTHS1 -s 115200
fi

if $BOARD_REV_1_1; then
	kill $PID_RS422_232
	kill $PID_HALF_FULL
fi

