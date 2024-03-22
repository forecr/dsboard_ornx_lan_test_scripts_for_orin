#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

gpioset --mode=signal `gpiofind "PH.00"`=0 &
PID_M2E_DISABLE=$!
gpioset --mode=signal `gpiofind "PCC.03"`=1 &
PID_M2E_USB_SELECT=$!

trap interrupt_func INT
interrupt_func() {
	kill $PID_M2E_DISABLE
	kill $PID_M2E_USB_SELECT
	gpioset --mode=signal `gpiofind "PCC.03"`=0 &
	PID_M2E_USB_SELECT=$!

	sleep 0.1
	kill $PID_M2E_USB_SELECT
}

watch -n 0.1 lsusb

