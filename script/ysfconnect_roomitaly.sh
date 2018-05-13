#!/bin/bash
#Script per il controlo della connesione su YSFGateway

#Configurazione PATH
#---------------------------------------------------
YSFHOST_PATH="/var/log/ysfgateway/YSFHosts.txt"
YSFGATEWAYINI_PATH="/etc/ysfgateway/YSFGateway.ini"
#----------------------------------------------------

ID_REFLECTOR="82044"
STARTDEFAULT=$(grep -e "#Startup" -e "Startup=" ${YSFGATEWAYINI_PATH})
REF_CONTROL=$(grep "${ID_REFLECTOR}" ${YSFHOST_PATH} | cut -f 1 -d";")
if [ $ID_REFLECTOR = "D" ]; then
{
	sudo sed -i "s/${STARTDEFAULT}/#Startup=/g" ${YSFGATEWAYINI_PATH}
        sudo service ysfgateway restart
        sudo sed -i "s/#Startup=/${STARTDEFAULT}/g" ${YSFGATEWAYINI_PATH}
        echo "Non connesso"
}
elif [ -z $REF_CONTROL ]; then
{
	echo "Reflector assente o non esistente"
}
else
{
	sudo sed -i "s/${STARTDEFAULT}/Startup=${REF_CONTROL}/g" ${YSFGATEWAYINI_PATH}
	sudo service ysfgateway restart
	sudo sed -i "s/Startup=${REF_CONTROL}/${STARTDEFAULT}/g" ${YSFGATEWAYINI_PATH}
	N_NODE=$(grep "${REF_CONTROL}" ${YSFHOST_PATH} | cut -f 2 -d";")
   	echo "Connesso a ${N_NODE}"
}
fi
exit

