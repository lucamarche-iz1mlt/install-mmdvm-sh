#!/bin/bash
#Script per toggled switch netword dmr+

#Configurazione PATH
#---------------------------------------------------
DMRGATEWAY_PATH="/etc/dmrgateway/DMRGateway.ini"
#----------------------------------------------------

DMRPLUS_STATE=$(grep "Enabled=.#dmrplus" /etc/dmrgateway/DMRGateway.ini  | tail --lines 1)
if [ $DMRPLUS_STATE = "Enabled=1#dmrplus" ]; then
{
    sudo sed -i "s/Enabled=1#dmrplus/Enabled=0#dmrplus/g" ${DMRGATEWAY_PATH}
    sudo service dmrgateway stop
    sudo service mmdvmhost stop
    sudo service mmdvmhost start
    sudo service dmrgateway start

    echo "DMR+ Disable"
}
elif [ $DMRPLUS_STATE = "Enabled=0#dmrplus" ]; then
{
    sudo sed -i "s/Enabled=0#dmrplus/Enabled=1#dmrplus/g" ${DMRGATEWAY_PATH}
    sudo service dmrgateway stop
    sudo service mmdvmhost stop
    sudo service mmdvmhost start
    sudo service dmrgateway start

    echo "DMR+ Enable"
}

fi
exit
