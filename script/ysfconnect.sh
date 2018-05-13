#!/bin/bash
#-----------------------------------------------------
LOG_PATH="/var/log/ysfgateway/YSFGateway-*"
YSFHOST_PATH="/var/log/ysfgateway/YSFHosts.txt"
#-----------------------------------------------------

#faccio una ricerca su tutti i log YSFGateway filtrando gli stati di info della connessione tramite grep prendendo l'ultima riga con cut e andando a salvare la prima parola dopo la data e ora
DUMMY=$(grep -e "Disconnect" -e "Automatic connection to" -e "Connect to" ${LOG_PATH} | tail --lines 1 | cut -f 4 -d" ")
#controllo la parola salvata e decido cosa fare
if [ $DUMMY = "Automatic" ]; then
	N_NODE=$(grep "Automatic connection to" ${LOG_PATH}  | tail --lines 1 | cut -f 7 -d" ")
   	N_NODEA=$(grep "${N_NODE}" ${YSFHOST_PATH} | cut -f 2 -d";")
   	echo "Connesso a $N_NODEA"
elif [ $DUMMY = "Connect" ]; then  #idem come sopra
   	N_NODE=$(grep "Connect to" ${LOG_PATH} | tail --lines 1 | tail --lines 1 | cut -f 6 -d" ")
	N_NODEA=$(grep "${N_NODE}" ${YSFHOST_PATH} | cut -f 2 -d";")
	echo "Connesso a $N_NODEA"
else #altrimenti non e connesso e lo stampo
	echo "Non Connesso"
fi
exit
