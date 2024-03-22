sudo echo 331 > /sys/class/gpio/export
sudo echo 391 > /sys/class/gpio/export

sudo echo low > /sys/class/gpio/PH.00/direction
sudo echo high > /sys/class/gpio/PCC.03/direction

trap disable_keye INT
disable_keye() {
	sudo echo low > /sys/class/gpio/PCC.03/direction
	sudo echo 331 > /sys/class/gpio/unexport
	sudo echo 391 > /sys/class/gpio/unexport
}

watch -n 0.1 lsusb

