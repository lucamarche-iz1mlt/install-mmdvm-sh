#!/bin/sh

PATH_RUN_SCRIPT=$1
LOG_PATH_YSFGATEWAY=$2
CONFIG_PATH_YSFGATEWAY=$3
PATH_EXEC=$4
N_CPU=$5

	git clone https://github.com/g4klx/YSFClients.git /home/pi/MMDVM/YSFClients
	cd /home/pi/MMDVM/YSFClients/YSFGateway/
	sudo make clean
	echo 'Compilazione  YSFGateway...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi
	
	mkdir -p ${CONFIG_PATH_YSFGATEWAY}
	mkdir -p ${LOG_PATH_YSFGATEWAY}
	chmod -R 777 ${CONFIG_PATH_YSFGATEWAY}
	chmod -R 777 ${LOG_PATH_YSFGATEWAY}
	
	cp -R /home/pi/MMDVM/YSFClients/YSFGateway/YSFGateway ${PATH_EXEC}
	cp -R /home/pi/MMDVM/YSFClients/YSFGateway/FCSRooms.txt ${CONFIG_PATH_YSFGATEWAY}
	cp -R /home/pi/MMDVM/YSFClients/YSFGateway/YSFGateway.ini ${CONFIG_PATH_YSFGATEWAY}

	cd /home/pi/MMDVM/YSFClients/YSFParrot/
	echo 'Compilazione  YSFParrot...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi

	cp -R /home/pi/MMDVM/YSFClients/YSFParrot/YSFParrot ${PATH_EXEC}
	cp -R ${PATH_RUN_SCRIPT}/service/ysfgateway.service /lib/systemd/system/	
	cp -R ${PATH_RUN_SCRIPT}/service/ysfparrot.service /lib/systemd/system/	
	cp -R ${PATH_RUN_SCRIPT}/service/ysfgateway.timer /lib/systemd/system/
	cp -R ${PATH_RUN_SCRIPT}/service/ysfparrot.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/ysfgateway.service
	chmod 755 /lib/systemd/system/ysfparrot.service
	chmod 755 /lib/systemd/system/ysfgateway.timer
	chmod 755 /lib/systemd/system/ysfparrot.timer
	
exit 0
