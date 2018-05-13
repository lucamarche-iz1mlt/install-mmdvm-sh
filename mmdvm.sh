#! /bin/sh
################################################################################
# Shellscript:  base.sh - visualizza un numero in basi differenti (Bourne Shell)
# Autore     :  Luca Marchesano IZ1MLT (iz1mlt@hotmail.it)
# Data       :  22-01-2018
# Categoria  :  shell
# $Id        :  mmdvm.sh ,v 1.0 2018/01/18 9:10:35
# ==> La riga precedente rappresenta l'ID RCS.
################################################################################
# Descrizione
# creazione script per l'installazione di MMDVMHost e DMRGateway
# Changes
# 22-01-18 st
# 12-05-18 aggiornamento script per debian 9 e aggiornamento YSFGateway
################################################################################

LOG_PATH_MMDVMHOST="/var/log/mmdvmhost/"
LOG_PATH_DMRGATEWAY="/var/log/dmrgateway/"
LOG_PATH_YSFGATEWAY="/var/log/ysfgateway/"
LOG_PATH_IRCDDBGATEWAY="/var/log/ircddbgateway/"
CONFIG_PATH_MMDVMHOST="/etc/mmdvmhost/"
CONFIG_PATH_DMRGATEWAY="/etc/dmrgateway/"
CONFIG_PATH_YSFGATEWAY="/etc/ysfgateway/"
CONFIG_PATH_IRCDDBGATEWAY="/etc/ircddbgateway/"
PATH_EXEC="/usr/local/bin/"

FILE_NAME="buttonoff" 			#Nome senza estersione
PATH_FILEEXECBUTTON="/usr/local/bin/" 	#Destinazione programma python



#Utility per ricavare il numero di core attivi e ottimizzare la compilazione del software
N_CPU=$(sed -n -e 1p -e 11p -e 21p -e 31p /proc/cpuinfo | grep -e "processor" | tail --lines 1 | cut -f 2 -d" ")
if [ $N_CPU = "1" ]; then
    N_CPU="2"
elif [ $N_CPU = "2" ]; then
    N_CPU="3"
elif [ $N_CPU = "3" ]; then
    N_CPU="4"
else
    N_CPU="0"
fi

echo "Il numero di core è $N_CPU"
sleep 3

echo 'Aggiornamento e installazione dei pachetti neccessari'

apt-get update
apt-get upgrade
apt-get install git build-essential libwxgtk3.0-dev portaudio19-dev libusb-1.0-0-dev chkconfig python-pip lighttpd php

#apt-get -f upgrade
apt-get autoremove


echo 'Vuoi inatallare MMDVMHost? (y/n)'
read VAR
if [ $VAR = "y" ]; then
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
	cp -R /home/pi/installazione_mmdvm/mmdvmhost.service /lib/systemd/system/
	cp -R /home/pi/installazione_mmdvm/mmdvmhost.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/mmdvmhost.service
	chmod 755 /lib/systemd/system/mmdvmhost.timer
fi

echo 'Vuoi inatallare DMRGateway? (y/n)'
read VAR
if [ $VAR = "y" ]; then
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
	cp -R /home/pi/installazione_mmdvm/dmrgateway.service /lib/systemd/system/
	cp -R /home/pi/installazione_mmdvm/dmrgateway.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/dmrgateway.service	
	chmod 755 /lib/systemd/system/dmrgateway.timer
fi

echo 'Vuoi inatallare YSFClients? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	git clone https://github.com/g4klx/YSFClients.git /home/pi/MMDVM/YSFClients
	cd /home/pi/MMDVM/YSFClients/YSFGateway/
	sudo make clean
	echo 'Compilazione  YSFGateway...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi

	cp -R /home/pi/MMDVM/YSFClients/YSFGateway/YSFGateway ${PATH_EXEC}
	cp -R /home/pi/MMDVM/YSFClients/YSFGateway/FCSRooms.txt ${CONFIG_PATH_YSFGATEWAY}
	
	mkdir -p ${CONFIG_PATH_YSFGATEWAY}
	mkdir -p ${LOG_PATH_YSFGATEWAY}
	chmod -R 777 ${CONFIG_PATH_YSFGATEWAY}
	chmod -R 777 ${LOG_PATH_YSFGATEWAY}
	cp -R /home/pi/MMDVM/YSFClients/YSFGateway/YSFGateway.ini ${CONFIG_PATH_YSFGATEWAY}

	cd /home/pi/MMDVM/YSFClients/YSFParrot/
	echo 'Compilazione  YSFParrot...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi

	cp -R /home/pi/MMDVM/YSFClients/YSFParrot/YSFParrot ${PATH_EXEC}
	cp -R /home/pi/installazione_mmdvm/ysfgateway.service /lib/systemd/system/	
	cp -R /home/pi/installazione_mmdvm/ysfparrot.service /lib/systemd/system/	
	cp -R /home/pi/installazione_mmdvm/ysfgateway.timer /lib/systemd/system/
	cp -R /home/pi/installazione_mmdvm/ysfparrot.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/ysfgateway.service
	chmod 755 /lib/systemd/system/ysfparrot.service
	chmod 755 /lib/systemd/system/ysfgateway.timer
	chmod 755 /lib/systemd/system/ysfparrot.timer	
fi

echo 'Vuoi inatallare ircDDBGateway? (y/n)'
read VAR
if [ $VAR = "y" ]; then
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
	cp -R /home/pi/installazione_mmdvm/ircddbgateway ${CONFIG_PATH_IRCDDBGATEWAY}
	cp -R /home/pi/installazione_mmdvm/ircddbgatewayd.service /lib/systemd/system/
	cp -R /home/pi/installazione_mmdvm/ircddbgatewayd.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/ircddbgatewayd.service
	chmod 755 /lib/systemd/system/ircddbgatewayd.timer
	
fi

echo 'Vuoi inatallare i servizi bot telegram? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	pip install telepot
	sleep 2

	echo 'Crezione dei servizi.....'

	cp -R /home/pi/installazione_mmdvm/telegrambot.service /lib/systemd/system/
	cp -R /home/pi/installazione_mmdvm/telegrambot.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/telegrambot.service
	chmod 755 /lib/systemd/system/telegrambot.timer

fi

systemctl daemon-reload

cp -R /home/pi/installazione_mmdvm/script /home/pi/

# echo 'Configurazione DVMega'
# systemctl stop serial-getty@ttyAMA0.service
# systemctl disable serial-getty@ttyAMA0.service

# echo 'Rimuovere la parte console=/dev/ttyAMA0.... or console=serial0 nel file che si aprirà tra poco....'
# sleep 5
# nano /boot/cmdline.txt

# echo 'Configurazione DVmega solo PI3'
# cd /boot/
# echo 'lettura file'
# DVMEGA_CONFIG=$(grep -e "dwc_otg.lpm_enable=0 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yesrootwait" /boot/cmdline.txt)
# if [ -z $DVMEGA_CONFIG_TEST ]; then
# {
	# CAT_FILE=$(cat cmdline.txt )
	# echo 'comento stringa /cmdline.txt'
	# sed -i "s/${CAT_FILE}/# ${CAT_FILE}/g" cmdline.txt
	# echo 'dwc_otg.lpm_enable=0 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yesrootwait' >> cmdline.txt
# }
# fi

# DVMEGA_CONFIG=$(grep -e "# Modification Bluetooth" /boot/config.txt)
# if [ -z $DVMEGA_CONFIG_TEST ]; then
# {
	# echo 'disabilito bluethoot'
	# echo '# Modification Bluetooth' >> config.txt
	# echo 'dtoverlay=pi3-disable-bt' >> config.txt
# }
# fi

# echo 'Installazione telegrambot...'
# cp -R /home/pi/installazione_mmdvm/telegrambot.py /home/pi/
# nano /home/pi/telegrambot.py

echo 'Vuoi inatallare dashboard? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	echo 'installazione dashboard....'

	cd /var/www/html/
	git clone https://github.com/dg9vh/MMDVMHost-Dashboard.git

	groupadd www-data
	usermod -G www-data -a pi
	chown -R www-data:www-data /var/www/html
	chmod -R 775 /var/www/html
	
	lighty-enable-mod fastcgi
	lighty-enable-mod fastcgi-php
	service lighttpd force-reload
fi

echo 'Vuoi inatallare buttonoff? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	echo 'installazione di buttonoff....'

	echo 'Creazione file python'

	echo '#!/usr/bin/python' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#Script per la gestione del power off del sistema tramite pulsante' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#collegato alla GPIO' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#scritto da Fabio PASTORINO IZ1JXP, Mauro ZUNINO IW1ELO' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'import RPi.GPIO as GPIO' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'import os' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setmode(GPIO.BCM)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setwarnings(False)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setup(21,GPIO.IN,pull_up_down=GPIO.PUD_UP)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setup(16,GPIO.OUT)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#attendo la pressione del tasto (pin a massa)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.wait_for_edge(21,GPIO.FALLING)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#accendo il led per confermare avvenuta fase di poweroff' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.output(16, True)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'os.system("sudo shutdown -h now")' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py

	chmod 777 ${PATH_FILEEXECBUTTON}${FILE_NAME}.py

	# nano ${PATH_FILEEXECBUTTON}${FILE_NAME}.py

	echo 'Creazione servizio systemd....'

	echo '[Unit]' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'Description=Servizio Button Off' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'After=syslog.target network.target' >>/lib/systemd/system/${FILE_NAME}.service
	echo ' ' >>/lib/systemd/system/${FILE_NAME}.service
	echo '[Service]' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'User=root' >>/lib/systemd/system/${FILE_NAME}.service
	echo "WorkingDirectory=${PATH_FILEEXECBUTTON}" >>/lib/systemd/system/${FILE_NAME}.service
	echo "ExecStart=/usr/bin/python ${PATH_FILEEXECBUTTON}${FILE_NAME}.py" >>/lib/systemd/system/${FILE_NAME}.service
	echo 'ExecReload=/bin/kill -HUP $MAINPID' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'KillMode=process' >>/lib/systemd/system/${FILE_NAME}.service
	echo ' ' >>/lib/systemd/system/${FILE_NAME}.service
	echo '[Install]' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'WantedBy=multi-user.target' >>/lib/systemd/system/${FILE_NAME}.service

	# nano /lib/systemd/system/${FILE_NAME}.service

	echo '[Timer]' >>/lib/systemd/system/${FILE_NAME}.timer
	echo 'OnStartupSec=30' >>/lib/systemd/system/${FILE_NAME}.timer
	echo ' ' >>/lib/systemd/system/${FILE_NAME}.timer
	echo '[Install]' >>/lib/systemd/system/${FILE_NAME}.timer
	echo 'WantedBy=multi-user.target' >>/lib/systemd/system/${FILE_NAME}.timer

	# nano /lib/systemd/system/${FILE_NAME}.timer

	chmod 755 /lib/systemd/system/${FILE_NAME}.service
	chmod 755 /lib/systemd/system/${FILE_NAME}.timer

	

	# systemctl enable ${FILE_NAME}.timer

	echo 'Fare "sudo reboot" per il corretto funzionanmeto.'
	echo "Per avviare manualmente l'applicazione   'sudo service ${FILE_NAME} start'"
	echo "per arrestare manualmente l'applicazione 'sudo service ${FILE_NAME} stop'"
	echo "Per disabilitare l'avvio automatico      'sudo systemctl disable ${FILE_NAME}.timer'"
fi

systemctl daemon-reload

echo 'Fine istallazione, si consiglia di fare un reboot se tutto e stato eseguito corretamente '

exit 0
