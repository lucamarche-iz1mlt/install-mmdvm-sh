#!/bin/sh
#---------------------------------Carico percorsi da script di installazione-----------------------------------------------------
PATH_FILE_INSTAL_MMDVM=$(pwd)"/mmdvm.sh"

LOG_PATH_MMDVMHOST=$(grep -e "LOG_PATH_MMDVMHOST=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
LOG_PATH_DMRGATEWAY=$(grep -e "LOG_PATH_DMRGATEWAY=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
LOG_PATH_YSFGATEWAY=$(grep -e "LOG_PATH_YSFGATEWAY=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
LOG_PATH_IRCDDBGATEWAY=$(grep -e "LOG_PATH_IRCDDBGATEWAY=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_MMDVMHOST=$(grep -e "CONFIG_PATH_MMDVMHOST=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_DMRGATEWAY=$(grep -e "CONFIG_PATH_DMRGATEWAY=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_YSFGATEWAY=$(grep -e "CONFIG_PATH_YSFGATEWAY=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_IRCDDBGATEWAY=$(grep -e "CONFIG_PATH_IRCDDBGATEWAY=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
PATH_EXEC=$(grep -e "PATH_EXEC=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
FILE_NAME=$(grep -e "FILE_NAME=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
PATH_FILEEXECBUTTON=$(grep -e "PATH_FILEEXECBUTTON=" ${PATH_FILE_INSTAL_MMDVM} | cut -f 2 -d"=" | cut -f 2 -d'"')
#---------------------------------------------------------------------------------------------------------------------------------

echo 'Arresto e disabilitrazione servizi....'
service mmdvmhost stop
service dmrgateway stop
service ysfgateway stop
service ysfparrot stop
service ircddbgatewayd stop
service ${FILE_NAME} stop
service telegrambot stop
systemctl disable mmdvmhost.timer
systemctl disable dmrgateway.timer
systemctl disable ysfgateway.timer
systemctl disable ysfparrot.timer
systemctl disable ircddbgatewayd.timer
systemctl disable ${FILE_NAME}.timer
systemctl disable telegrambot.timer

echo 'Eliminazione servizi......'
rm -R /lib/systemd/system/mmdvmhost.* /lib/systemd/system/dmrgateway.* /lib/systemd/system/ysfgateway.* /lib/systemd/system/ysfparrot.* /lib/systemd/system/ircddbgatewayd.* /lib/systemd/system/telegrambot.* /lib/systemd/system/${FILE_NAME}.*

echo 'Disinstallazione ircDDBGateway.....'
cd /home/pi/MMDVM/OpenDV/ircDDBGateway/
make distclean
make clean

rm -R /usr/local/bin/aprstransmit /usr/local/bin/remotecontrold /usr/local/bin/texttransmit /usr/local/bin/voicetransmit /usr/local/sbin/aprstransmitd /usr/local/sbin/ircddbgatewayd /usr/local/sbin/starnetserverd /usr/local/sbin/timercontrold /usr/local/sbin/timeserverd
rm -R /usr/local/share/opendv

echo 'Disinstallazione di mmdvmhost, dmrgateway, ysfgateway, ysfparrot, buttonoff.....'
rm -R ${LOG_PATH_MMDVMHOST} ${LOG_PATH_DMRGATEWAY} ${LOG_PATH_YSFGATEWAY} ${LOG_PATH_IRCDDBGATEWAY} ${CONFIG_PATH_MMDVMHOST} ${CONFIG_PATH_DMRGATEWAY} ${CONFIG_PATH_YSFGATEWAY} ${CONFIG_PATH_IRCDDBGATEWAY} 
rm /usr/local/bin/MMDVMHost /usr/local/bin/DMRGateway /usr/local/bin/YSFGateway /usr/local/bin/YSFParrot ${PATH_FILEEXECBUTTON}${FILE_NAME}.py

echo 'Eliminazione cartella /home/pi/MMDVM.....'
rm -R /home/pi/MMDVM

echo 'Eliminazione dashbord....'
rm -R /var/www/html/MMDVMHost-Dashboard/

rm -R /home/pi/script/

sed -e /home/d -e /log/d /etc/crontab > /tmp/crontabappend
cat /tmp/crontabappend > /etc/crontab
rm /tmp/crontabappend

systemctl daemon-reload

echo 'Fine!! Riavviare il sistema'
exit 0

