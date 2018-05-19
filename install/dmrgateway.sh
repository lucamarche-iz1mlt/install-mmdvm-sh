#!/bin/sh
PATH_RUN_SCRIPT=$1
LOG_PATH_DMRGATEWAY=$2
CONFIG_PATH_DMRGATEWAY=$3
PATH_EXEC=$4
N_CPU=$5

	git clone https://github.com/g4klx/DMRGateway.git /home/pi/MMDVM/DMRGateway
	cd /home/pi/MMDVM/DMRGateway/
	make clean
	echo 'Compilazione  DMRGateway...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi

	cp -R /home/pi/MMDVM/DMRGateway/DMRGateway ${PATH_EXEC}
	mkdir -p ${CONFIG_PATH_DMRGATEWAY}
	mkdir -p ${LOG_PATH_DMRGATEWAY}
	chmod -R 777 ${CONFIG_PATH_DMRGATEWAY}
	chmod -R 777 ${LOG_PATH_DMRGATEWAY}

	# sed -i 's,FilePath=.,FilePath=${LOG_PATH_DMRGATEWAY},g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
	# sed -i 's,FileLevel=1,FileLevel=0,g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
	# sed -i 's,# Port=/dev/ttyACM0,Port=/dev/ttyAMA0,g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
	# sed -i 's,Port=\\.\COM3,# Port=\\.\COM3,g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini

	#nano DMRGateway.ini

	cp -R /home/pi/MMDVM/DMRGateway/DMRGateway.ini ${CONFIG_PATH_DMRGATEWAY}
	cp -R /home/pi/MMDVM/DMRGateway/XLXHosts.txt ${LOG_PATH_DMRGATEWAY}
	cp -R /home/pi/MMDVM/DMRGateway/Audio ${CONFIG_PATH_DMRGATEWAY}
	cp -R ${PATH_RUN_SCRIPT}/service/dmrgateway.service /lib/systemd/system/
	cp -R ${PATH_RUN_SCRIPT}/service/dmrgateway.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/dmrgateway.service	
	chmod 755 /lib/systemd/system/dmrgateway.timer
	
exit 0
