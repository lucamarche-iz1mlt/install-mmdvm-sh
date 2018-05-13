#!/bin/bash
#-----------------------------------------------------
LOG_PATH="/var/log/mmdvm/MMDVM-*"
#-----------------------------------------------------

LAST_DSTAR=$(grep -e "D-Star, received network header from" -e "D-Star, received RF header from" ${LOG_PATH} | tail --lines 1 | cut -f 2,4,6,9,11,13,14 -d" ")
LAST_C4FM=$(grep -e "YSF, received network header from" -e "YSF, received RF header from" ${LOG_PATH} | tail --lines 1 | cut -f 2,4,6,9,10,16 -d" ")
LAST_DMR_TS1=$(grep -e "DMR Slot 1, received RF voice header from" -e "DMR Slot 1, received network voice header from" ${LOG_PATH} | tail --lines 1 | cut -f 2,5,6,8,12,14,15 -d" ")
LAST_DMR_TS2=$(grep -e "DMR Slot 2, received RF voice header from" -e "DMR Slot 2, received network voice header from" ${LOG_PATH} | tail --lines 1 | cut -f 2,5,6,8,12,14,15 -d" ")
echo ${LAST_DSTAR}
echo ${LAST_C4FM}
echo ${LAST_DMR_TS1}
echo ${LAST_DMR_TS2}

exit

