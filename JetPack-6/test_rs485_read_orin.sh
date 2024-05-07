#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_1=$1

RS485_CTRL=`gpiofind "PCC.00"`
RS485_CTRL_VAL=0
HALF_FULL=`gpiofind "PCC.02"`
HALF_FULL_VAL=1
RS422_232=`gpiofind "PG.06"`
RS422_232_VAL=1

PID_RS485_CTRL=""
PID_HALF_FULL=""
PID_RS422_232=""

if $BOARD_REV_1_1; then
	gpioset --mode=signal $RS485_CTRL=$RS485_CTRL_VAL &
	PID_RS485_CTRL=$!
	gpioset --mode=signal $HALF_FULL=$HALF_FULL_VAL &
	PID_HALF_FULL=$!
	gpioset --mode=signal $RS422_232=$RS422_232_VAL &
	PID_RS422_232=$!

	sudo gtkterm -p /dev/ttyTHS3 -s 115200 -w RS485
else
	echo "RS485 test is compatible for Rev-1.1"
	read -p 'Press [Enter] to exit' quit_key
fi

trap interrupt_func INT
interrupt_func() {
	if $BOARD_REV_1_1; then
		kill $PID_RS485_CTRL
		kill $PID_RS422_232
		kill $PID_HALF_FULL
	fi
}

