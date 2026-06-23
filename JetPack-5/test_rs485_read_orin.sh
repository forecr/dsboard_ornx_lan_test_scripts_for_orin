#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

NEW_SERIAL_DESIGN=$1

RS485_CTRL_NUM=328
RS485_CTRL=PCC.00
RS485_CTRL_VAL=0
HALF_FULL_NUM=330
HALF_FULL=PCC.02
HALF_FULL_VAL=1
RS422_232_NUM=389
RS422_232=PG.06
RS422_232_VAL=1

if $NEW_SERIAL_DESIGN; then
	sudo echo $RS485_CTRL_NUM > /sys/class/gpio/export 
	sudo echo $HALF_FULL_NUM > /sys/class/gpio/export 
	sudo echo $RS422_232_NUM > /sys/class/gpio/export 

	sudo echo out > /sys/class/gpio/$RS485_CTRL/direction 
	sudo echo out > /sys/class/gpio/$HALF_FULL/direction 
	sudo echo out > /sys/class/gpio/$RS422_232/direction 

	sudo echo $RS485_CTRL_VAL > /sys/class/gpio/$RS485_CTRL/value 
	sudo echo $HALF_FULL_VAL > /sys/class/gpio/$HALF_FULL/value 
	sudo echo $RS422_232_VAL > /sys/class/gpio/$RS422_232/value

	sudo gtkterm -p /dev/ttyTHS0 -s 115200 -w RS485
else
	echo "RS485 test is compatible for Rev-1.1"
	read -p 'Press [Enter] to exit' quit_key
fi

if $NEW_SERIAL_DESIGN; then
	sudo echo $RS485_CTRL_NUM > /sys/class/gpio/unexport
	sudo echo $HALF_FULL_NUM > /sys/class/gpio/unexport
	sudo echo $RS422_232_NUM > /sys/class/gpio/unexport
fi

