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
PATH_RUN_SCRIPT=$(pwd)

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

# apt-get -f upgrade
apt-get autoremove


echo 'Vuoi inatallare MMDVMHost? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/mmdvmhost.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_MMDVMHOST} ${CONFIG_PATH_MMDVMHOST} ${PATH_EXEC}
fi

echo 'Vuoi inatallare DMRGateway? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/dmrgateway.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_DMRGATEWAY} ${CONFIG_PATH_DMRGATEWAY} ${PATH_EXEC}
fi

echo 'Vuoi inatallare YSFClients? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/ysfclients.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_YSFGATEWAY} ${CONFIG_PATH_YSFGATEWAY} ${PATH_EXEC}
fi

echo 'Vuoi inatallare ircDDBGateway? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/ircddbgateway.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_IRCDDBGATEWAY} ${CONFIG_PATH_IRCDDBGATEWAY} ${PATH_EXEC}
fi

echo 'Vuoi inatallare i servizi bot telegram? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/telegrambot.sh
fi

cp -R ${PATH_RUN_SCRIPT}/script /home/pi/

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

echo 'Vuoi installare dashboard? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/dashboard.sh
fi

echo 'Vuoi inatallare buttonoff? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/buttonoff.sh ${PATH_FILEEXECBUTTON} ${FILE_NAME}
fi

systemctl daemon-reload

echo 'Fine istallazione, si consiglia di fare un reboot se tutto e stato eseguito corretamente '

exit 0
