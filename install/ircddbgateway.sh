#!/bin/sh

PATH_RUN_SCRIPT=$1
LOG_PATH_IRCDDBGATEWAY=$2
CONFIG_PATH_IRCDDBGATEWAY=$3
PATH_EXEC=$4
N_CPU=$5

	git clone https://github.com/g4klx/ircDDBGateway.git /home/pi/MMDVM/
	echo 'Compilazione  IRCDDBGateway...'
	cd /home/pi/MMDVM/ircDDBGateway/
    make clean
	sed -i "s%/var/log%${LOG_PATH_IRCDDBGATEWAY}%g" /home/pi/MMDVM/ircDDBGateway/Makefile
	sed -i "s%/etc%${CONFIG_PATH_IRCDDBGATEWAY}%g" /home/pi/MMDVM/ircDDBGateway/Makefile
	sed -i "s%/usr/bin%/usr/local/bin%g" /home/pi/MMDVM/ircDDBGateway/Makefile
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi

	make install
	mkdir -p ${CONFIG_PATH_IRCDDBGATEWAY}
	mkdir -p ${LOG_PATH_IRCDDBGATEWAY}
	chown -R pi ${CONFIG_PATH_IRCDDBGATEWAY}
	chown -R pi ${LOG_PATH_IRCDDBGATEWAY}
	cp -R ${PATH_RUN_SCRIPT}/ircddbgateway ${CONFIG_PATH_IRCDDBGATEWAY}
	cp -R ${PATH_RUN_SCRIPT}/service/ircddbgatewayd.service /lib/systemd/system/
	cp -R ${PATH_RUN_SCRIPT}/service/ircddbgatewayd.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/ircddbgatewayd.service
	chmod 755 /lib/systemd/system/ircddbgatewayd.timer

exit 0
