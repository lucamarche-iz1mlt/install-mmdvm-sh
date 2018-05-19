#!/bin/sh

PATH_RUN_SCRIPT=$1
LOG_PATH_IRCDDBGATEWAY=$2
CONFIG_PATH_IRCDDBGATEWAY=$3
PATH_EXEC=$4
N_CPU=$5

	git clone https://github.com/dl5di/OpenDV.git /home/pi/MMDVM/OpenDV
	echo 'Compilazione  IRCDDBGateway...'
	cd /home/pi/MMDVM/OpenDV/ircDDBGateway/
    make clean
	./configure --without-gui
	if [ $N_CPU = "0" ]; then
		sudo make
	else
		sudo make -j$N_CPU all
	fi

	make install
	mkdir -p ${CONFIG_PATH_IRCDDBGATEWAY}
	mkdir -p ${LOG_PATH_IRCDDBGATEWAY}
	chmod -R 777 ${CONFIG_PATH_IRCDDBGATEWAY}
	chmod -R 777 ${LOG_PATH_IRCDDBGATEWAY}
	cp -R ${PATH_RUN_SCRIPT}/ircddbgateway ${CONFIG_PATH_IRCDDBGATEWAY}
	cp -R ${PATH_RUN_SCRIPT}/service/ircddbgatewayd.service /lib/systemd/system/
	cp -R ${PATH_RUN_SCRIPT}/service/ircddbgatewayd.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/ircddbgatewayd.service
	chmod 755 /lib/systemd/system/ircddbgatewayd.timer

exit 0
