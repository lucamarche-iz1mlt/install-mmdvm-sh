#! /bin/sh

PATH_RUN_SCRIPT=$1
LOG_PATH_MMDVMHOST=$2
CONFIG_PATH_MMDVMHOST=$3
PATH_EXEC=$4

	git clone https://github.com/g4klx/MMDVMHost.git /home/pi/MMDVM/MMDVMHost
	echo 'Compilazione e instalazione....'
	cd /home/pi/MMDVM/MMDVMHost/

	make clean
	echo 'Compilazione MMDVMHost...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi

	cp -R /home/pi/MMDVM/MMDVMHost/MMDVMHost ${PATH_EXEC}
	mkdir -p ${CONFIG_PATH_MMDVMHOST}
	mkdir -p ${LOG_PATH_MMDVMHOST}

	chmod -R 777 ${CONFIG_PATH_MMDVMHOST}
	chmod -R 777 ${LOG_PATH_MMDVMHOST}

	# nano MMDVM.ini

	cp -R /home/pi/MMDVM/MMDVMHost/MMDVM.ini ${CONFIG_PATH_MMDVMHOST}
	cp -R /home/pi/MMDVM/MMDVMHost/NXDN.csv ${LOG_PATH_MMDVMHOST}
	cp -R ${PATH_RUN_SCRIPT}/service/mmdvmhost.service /lib/systemd/system/
	cp -R ${PATH_RUN_SCRIPT}/service/mmdvmhost.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/mmdvmhost.service
	chmod 755 /lib/systemd/system/mmdvmhost.timer
	
	echo 'Vuoi installare Wiring PI? y/n (consigliato)'
	read VAR
	if [ $VAR = "y" ]; then
    		echo 'Installazione Wiring PI....'
		git clone git://git.drogon.net/wiringPi
		cd wiringPi
		sudo ./build
	fi

exit 0