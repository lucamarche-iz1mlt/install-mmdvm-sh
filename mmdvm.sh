#!/bin/sh
################################################################################
# Shellscript:  base.sh - visualizza un numero in basi differenti (Bourne Shell)
# Autore     :  Luca Marchesano IZ1MLT (iz1mlt@hotmail.it)
# Data       :  22-01-2018
# Categoria  :  shell
# $Id        :  mmdvm.sh ,v 1.0 2018/01/18 9:10:35
# 
################################################################################
# Descrizione
# creazione script per l'installazione di MMDVMHost e DMRGateway
# Changes
# 22-01-18 st
# 12-05-18 aggiornamento script per debian 9 e aggiornamento YSFGateway
# 06-01-20 Update script for Debian 10
################################################################################

LOG_PATH_MMDVMHOST="/var/log/mmdvmhost/"
LOG_PATH_DMRGATEWAY="/var/log/dmrgateway/"
LOG_PATH_YSFGATEWAY="/var/log/ysfgateway/"
LOG_PATH_IRCDDBGATEWAY="/var/log/ircddbgateway"

CONFIG_PATH_MMDVMHOST="/etc/mmdvmhost/"
CONFIG_PATH_DMRGATEWAY="/etc/dmrgateway/"
CONFIG_PATH_YSFGATEWAY="/etc/ysfgateway/"
CONFIG_PATH_IRCDDBGATEWAY="/etc/ircddbgateway"

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
apt-get install git build-essential libwxgtk3.0-dev portaudio19-dev libusb-1.0-0-dev chkconfig python-pip lighttpd

# apt-get -f upgrade
apt-get autoremove


echo 'Vuoi installare MMDVMHost? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/mmdvmhost.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_MMDVMHOST} ${CONFIG_PATH_MMDVMHOST} ${PATH_EXEC} ${N_CPU}
fi

echo 'Vuoi installare DMRGateway? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/dmrgateway.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_DMRGATEWAY} ${CONFIG_PATH_DMRGATEWAY} ${PATH_EXEC} ${N_CPU}
fi

echo 'Vuoi installare YSFClients? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/ysfclients.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_YSFGATEWAY} ${CONFIG_PATH_YSFGATEWAY} ${PATH_EXEC} ${N_CPU}
fi

echo 'Vuoi installare ircDDBGateway? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/ircddbgateway.sh ${PATH_RUN_SCRIPT} ${LOG_PATH_IRCDDBGATEWAY} ${CONFIG_PATH_IRCDDBGATEWAY} ${PATH_EXEC} ${N_CPU}
fi

echo 'Vuoi installare i servizi bot telegram? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/telegrambot.sh ${PATH_RUN_SCRIPT}
fi

cp -R ${PATH_RUN_SCRIPT}/script /home/pi/

echo 'Vuoi installare dashboard? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/dashboard.sh
fi

echo 'Vuoi installare buttonoff? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/buttonoff.sh ${PATH_FILEEXECBUTTON} ${FILE_NAME}
fi

echo 'Vuoi installare OpenVPN? (y/n)'
read VAR
if [ $VAR = "y" ]; then
	sh ${PATH_RUN_SCRIPT}/install/openvpn.sh
fi

systemctl daemon-reload

echo 'Fine istallazione, si consiglia di fare un reboot se tutto e stato eseguito corretamente '

exit 0
