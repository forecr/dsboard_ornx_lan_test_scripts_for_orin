#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_1=$1

HALF_FULL_NUM=330
HALF_FULL=PCC.02
HALF_FULL_VAL=0
RS422_232_NUM=389
RS422_232=PG.06
RS422_232_VAL=1

if $BOARD_REV_1_1; then
	sudo echo $HALF_FULL_NUM > /sys/class/gpio/export 
	sudo echo $RS422_232_NUM > /sys/class/gpio/export 

	sudo echo out > /sys/class/gpio/$HALF_FULL/direction 
	sudo echo out > /sys/class/gpio/$RS422_232/direction 

	sudo echo $HALF_FULL_VAL > /sys/class/gpio/$HALF_FULL/value 
	sudo echo $RS422_232_VAL > /sys/class/gpio/$RS422_232/value

	sudo gtkterm -p /dev/ttyTHS0 -s 115200
else
	sudo gtkterm -p /dev/ttyTHS0 -s 115200
fi


if $BOARD_REV_1_1; then
	sudo echo $HALF_FULL_NUM > /sys/class/gpio/unexport
	sudo echo $RS422_232_NUM > /sys/class/gpio/unexport
fi

