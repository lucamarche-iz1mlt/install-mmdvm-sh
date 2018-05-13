#!/bin/bash
#-----------------------------------------------------
DMRGATEWAY_PATH="/etc/dmrgateway/DMRGateway.ini"
#-----------------------------------------------------

STARTDEFAULT=$(grep -e "Startup=40..#XLX2" ${DMRGATEWAY_PATH})

sudo sed -i "s/${STARTDEFAULT}/Startup=4000#XLX2/g" ${DMRGATEWAY_PATH}
sudo service dmrgateway restart
sudo sed -i "s/Startup=4000#XLX2/${STARTDEFAULT}/g" ${DMRGATEWAY_PATH}

exit
