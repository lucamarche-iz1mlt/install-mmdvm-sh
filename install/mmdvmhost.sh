#! /bin/sh

PATH_RUN_SCRIPT=$1
LOG_PATH_MMDVMHOST=$2
CONFIG_PATH_MMDVMHOST=$3
PATH_EXEC=$4
N_CPU=$5

	git clone https://github.com/g4klx/MMDVMHost.git /home/pi/MMDVM/MMDVMHost
    sleep 2
    echo 'Vuoi installare la versione di MMDVMHost con Display HD44780? (y/n)'
	read VAR
	if [ $VAR = "y" ]; then
		echo 'Installazione di Wiring Pi....'
		sleep 2
		git clone git://git.drogon.net/wiringPi
		cd wiringPi
		sudo ./build
		sleep 2
		echo 'Compilazione e installazione di MMDVMHost con Display HD44780....'
		sleep 2
		cd /home/pi/MMDVM/MMDVMHost/

		make clean
		echo 'Compilazione di MMDVMHost....'
		if [ $N_CPU = "0" ]; then
			make -f Makefile.Pi.HD44780
		else
			make -f Makefile.Pi.HD44780 -j$N_CPU all
		fi 
	else
		echo 'Compilazione e installazione di MMDVMHost senza Display HD44780....'
		cd /home/pi/MMDVM/MMDVMHost/
	
		make clean
		echo 'Compilazione MMDVMHost...'
		if [ $N_CPU = "0" ]; then
			make 
		else
			make -j$N_CPU all
		fi
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
	
exit 0


