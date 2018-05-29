#!/bin/bash

# GENERAL SETTING

CALLSIGN="IZ1MLT"
DMR_ID="2221119"
RPT_OR_HS="1" # 1 for duplex mode repeater, 0 for simplex mode Hot Spot
FREQ_TX="430.437500"
FREQ_RX="435.437500"
LAT="44.554375"
LONG="8.938647"
HEIGHT="15"
LOCATION="Genova"
DESCRIPTION="mmdvm system"
URL="www.google.it"
CW_ID="1" #1 active 0 disable
PORT_MODEM="/dev/ttyACM0"
TX_INV="1"
RX_INV="0"

# DSTAR

DS_EN="1"
MODULE="B"
IRC_EN="0"
IRC_PWD=""     
DPLUS_EN="1"
DEXTRA_EN="1"
DS_STARTUP="DCS999"
REF_MODULE="K"
LANGUIGE="Italiano"
#launguige support
#		 0   English (UK) 
#  		 1   Deutsch 
#		 2   Dansk 
#   		 3   Italiano 
#   		 4   Francais 
#   		 5   Espanol 
#   		 6   Svenska 
#   		 7   Polski 
#   		 8   English (US) 
#   		 9   Nederlands (NL) 
#   		10   Nederland (BE)

# DMR

DMR_EN="1"
CC="1"
TA="1"
XLX_EN="0"
XLX_TG="6"
XLX_TS="1"
XLX_STARTUP="999"
BM_EN="1"
BM_IP="95.110.161.52"
DMRP_EN="0"
DMRP_IP="93.186.255.126"

# YSF C4FM

YSF_EN="1"
FCS_EN="1"
YSFFCS_START="IT C4FM Piemonte"

# APRS
APRS_EN="1"
APRS_HOST="italy1.aprs2.net"
APRS_PORT="14580"
APRS_PWD=$(curl http://n5dux.com/ham/aprs-passcode/?callsign=$CALLSIGN | grep -e "size=24>" | cut -f 5 -d">" | cut -f1 -d"<")

#-----------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------#
#											  #
#-----------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------#

LOG_PATH_MMDVMHOST=$(grep -e "LOG_PATH_MMDVMHOST=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')
LOG_PATH_DMRGATEWAY=$(grep -e "LOG_PATH_DMRGATEWAY=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')
LOG_PATH_YSFGATEWAY=$(grep -e "LOG_PATH_YSFGATEWAY=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')
LOG_PATH_IRCDDBGATEWAY=$(grep -e "LOG_PATH_IRCDDBGATEWAY=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')

CONFIG_PATH_MMDVMHOST=$(grep -e "CONFIG_PATH_MMDVMHOST=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_DMRGATEWAY=$(grep -e "CONFIG_PATH_DMRGATEWAY=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_YSFGATEWAY=$(grep -e "CONFIG_PATH_YSFGATEWAY=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')
CONFIG_PATH_IRCDDBGATEWAY=$(grep -e "CONFIG_PATH_IRCDDBGATEWAY=" $(pwd)/mmdvm.sh | cut -f 2 -d"=" | cut -f 2 -d'"')


if [ $RPT_OR_HS = "1" ]; then
	YSF_SUFFIX="RPT"
else
	YSF_SUFFIX="ND"
fi

if [ $LANGUIGE = "English(UK)" ]; then
	LANGUIGE_NUM  ="0"
elif [ $LANGUIGE = "Deutsch" ]; then
	LANGUIGE_NUM  ="1"
elif [ $LANGUIGE = "Dansk" ]; then
	LANGUIGE_NUM  ="2" 
elif [ $LANGUIGE = "Italiano" ]; then
	LANGUIGE_NUM  ="3"
elif [ $LANGUIGE = "Francais" ]; then
	LANGUIGE_NUM  ="4"
elif [ $LANGUIGE = "Espanol" ]; then
	LANGUIGE_NUM  ="5"
elif [ $LANGUIGE = "Svenska" ]; then
	LANGUIGE_NUM  ="6"
elif [ $LANGUIGE = "Polski" ]; then
	LANGUIGE_NUM  ="7"
elif [ $LANGUIGE = "English(US)" ]; then
	LANGUIGE_NUM  ="8"
elif [ $LANGUIGE = "Nederlands(NL)" ]; then
	LANGUIGE_NUM  ="9"
elif [ $LANGUIGE = "Nederland(BE)" ]; then
	LANGUIGE_NUM  ="10"

fi


SHIFT=$((${FREQ_RX:0:3}${FREQ_RX:4} - ${FREQ_TX:0:3}${FREQ_TX:4}))

	rm  ${CONFIG_PATH_MMDVMHOST}MMDVM.ini

	printf "[General]\nCallsign=${CALLSIGN}\nId=${DMR_ID}\nTimeout=240\nDuplex=${RPT_OR_HS}\n# ModeHang=10\nRFModeHang=10\nNetModeHang=30\nDisplay=None\nDaemon=0 " >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Info]\nRXFrequency=${FREQ_RX:0:3}${FREQ_RX:4}\nTXFrequency=${FREQ_TX:0:3}${FREQ_TX:4}\nPower=10\nLatitude=${LAT}\nLongitude=${LONG}\nHeight=${HEIGHT}\nLocation=${LOCATION}\nDescription=${DESCRIPTION}\nURL=${URL}" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Log]\n# Logging levels, 0=No logging\nDisplayLevel=1\nFileLevel=2\nFilePath=${LOG_PATH_MMDVMHOST}\nFileRoot=MMDVM" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[CW Id]\nEnable=1\nTime=10\n# Callsign=" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[DMR Id Lookup]\nFile=${LOG_PATH_MMDVMHOST}DMRIds.dat\nTime=24" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[NXDN Id Lookup]\nFile=${LOG_PATH_MMDVMHOST}NXDN.csv\nTime=24" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Modem]\nPort=${PORT_MODEM}\nTXInvert=${TX_INV}\nRXInvert=${RX_INV}\nPTTInvert=0\nTXDelay=100\nRXOffset=0\nTXOffset=0\nDMRDelay=0\nRXLevel=50\nTXLevel=50\nRXDCOffset=0\nTXDCOffset=0\nRFLevel=100\n# CWIdTXLevel=50\n# D-StarTXLevel=50\n# DMRTXLevel=50\n# YSFTXLevel=50\n# P25TXLevel=50\n# NXDNTXLevel=50\nRSSIMappingFile=RSSI.dat\nTrace=0\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Transparent Data]\nEnable=0\nRemoteAddress=127.0.0.1\nRemotePort=40094\nLocalPort=40095" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[UMP]\nEnable=0\n# Port=\\.\COM4\n# Port=/dev/ttyACM1" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[D-Star]\nEnable=${DS_EN}\nModule=${MODULE}\nSelfOnly=0\nAckReply=1\nAckTime=750\nErrorReply=1\nRemoteGateway=0\n# ModeHang=10" >>${PATH_FILEEXECBUTTON}MMDVM.ini
	printf "\n\n[DMR]\nEnable=${DMR_EN}\nBeacons=1\nBeaconInterval=180\nBeaconDuration=3\nColorCode=${CC}\nSelfOnly=0\nEmbeddedLCOnly=0\nDumpTAData=${TA}\n# Prefixes=234,235\n# Slot1TGWhiteList=\n# Slot2TGWhiteList=\nCallHang=3\nTXHang=4\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[System Fusion]\nEnable=${YSF_EN}\nLowDeviation=0\nSelfOnly=0\nTXHang=4\n# DGID=1\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[P25]\nEnable=0\nNAC=293\nSelfOnly=0\nOverrideUIDCheck=0\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[NXDN]\nEnable=0\nRAN=1\nSelfOnly=0\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[D-Star Network]\nEnable=1\nGatewayAddress=127.0.0.1\nGatewayPort=20010\nLocalPort=20011\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[DMR Network]\nEnable=${DMR_EN}\nAddress=127.0.0.1\nPort=62031\nJitter=360\nLocal=62032\nPassword=PASSWORD\n# Options=\nSlot1=1\nSlot2=1\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[System Fusion Network]\nEnable=1\nLocalAddress=127.0.0.1\nLocalPort=3200\nGatewayAddress=127.0.0.1\nGatewayPort=4200\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[P25 Network]\nEnable=0\nGatewayAddress=127.0.0.1\nGatewayPort=42020\nLocalPort=32010\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[NXDN Network]\nEnable=0\nLocalAddress=127.0.0.1\nLocalPort=14021\nGatewayAddress=127.0.0.1\nGatewayPort=14020\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[TFT Serial]\n# Port=modem\nPort=/dev/ttyAMA0\nBrightness=50" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[HD44780]\nRows=2\nColumns=16\n\n# For basic HD44780 displays (4-bit connection)\n# rs, strb, d0, d1, d2, d3\nPins=11,10,0,1,2,3\n\n# Device address for I2C\nI2CAddress=0x20\n\n# PWM backlight\nPWM=0\nPWMPin=21\nPWMBright=100\nPWMDim=16\n\nDisplayClock=1\nUTC=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Nextion]\n# Port=modem\nPort=/dev/ttyAMA0\nBrightness=50\nDisplayClock=1\nUTC=0\n#Screen Layout: 0=G4KLX 2=ON7LDS\nScreenLayout=2\nIdleBrightness=20" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[OLED]\nType=3\nBrightness=0\nInvert=0\nScroll=1" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[LCDproc]\nAddress=localhost\nPort=13666\n#LocalPort=13667\nDimOnIdle=0\nDisplayClock=1\nUTC=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini

	nano ${CONFIG_PATH_MMDVMHOST}MMDVM.ini

# YSFGATEWEAY

	rm ${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini

	printf "[General]\nCallsign=${CALLSIGN}\nSuffix=${YSF_SUFFIX}\nId=${DMR_ID}\nRptAddress=127.0.0.1\nRptPort=3200\nLocalAddress=127.0.0.1\nLocalPort=4200\nDaemon=0" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[Info]\nRXFrequency=${FREQ_RX:0:3}${FREQ_RX:4}\nTXFrequency=${FREQ_TX:0:3}${FREQ_TX:4}\nPower=10\nLatitude=${LAT}\nLongitude=${LONG}\nHeight=${HEIGHT}\nLocation=${LOCATION}\nDescription=${DESCRIPTION}" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[Log]\n# Logging levels, 0=No logging\nDisplayLevel=1\nFileLevel=2\nFilePath=${LOG_PATH_YSFGATEWAY}\nFileRoot=YSFGateway" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[aprs.fi]\nEnable=${APRS_EN}\nServer=${APRS_HOST}\nPort=${APRS_PORT}\nPassword=${APRS_PWD}\nDescription=${DESCRIPTION}\nSuffix=Y" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[Network]\n${YSF_AUTOSTART}Startup=${YSFFCS_START}\nInactivityTimeout=0\nRevert=0\nDebug=0" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[YSF Network]\nEnable=1\nPort=42000\nHosts=${LOG_PATH_YSFGATEWAY}YSFHosts.txt\nReloadTime=60\nParrotAddress=127.0.0.1\nParrotPort=42012\nYSF2DMRAddress=127.0.0.1\nYSF2DMRPort=42013\nYSF2NXDNAddress=127.0.0.1\nYSF2NXDNPort=42014\nYSF2P25Address=127.0.0.1\nYSF2P25Port=42015" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[FCS Network]\nEnable=${FCS_EN}\nRooms=${LOG_PATH_YSFGATEWAY}FCSRooms.txt\nPort=42001" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini

	nano ${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini

# DMRGATEWAY

	rm ${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini

	printf "[General]\nTimeout=10\n# RFTimeout=10\n# NetTimeout=7\nRptAddress=127.0.0.1\nRptPort=62032\nLocalAddress=127.0.0.1\nLocalPort=62031\nRuleTrace=0\nDaemon=0\nDebug=0" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n[Log]\n# Logging levels, 0=No logging\nDisplayLevel=1\nFileLevel=2\nFilePath=${LOG_PATH_DMRGATEWAY}\nFileRoot=DMRGateway" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n[Voice]\nEnabled=1\nLanguage=it_IT\nDirectory=${CONFIG_PATH_DMRGATEWAY}Audio" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n[Info]\nRXFrequency=${FREQ_RX:0:3}${FREQ_RX:4}\nTXFrequency=${FREQ_TX:0:3}${FREQ_TX:4}\nPower=10\nLatitude=${LAT}\nLongitude=${LONG}\nHeight=${HEIGHT}\nLocation=${LOCATION}\nDescription=${DESCRIPTION}\nURL=${URL}" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n[XLX Network]\nEnabled=${XLX_EN}\nFile=XLXHosts.txt\nPort=62030\nPassword=passw0rd\nReloadTime=60\n# Local=3351\nSlot=${XLX_TS}\nTG=${XLX_TG}\nBase=64000\nStartup=999\nRelink=10\nDebug=0" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n# BrandMeister\n[DMR Network 1]\nEnabled=${BM_EN}\nName=BM\nAddress=${BM_IP}\nPort=62031\n# Local=3352\nPassAllPC=1\nPassAllPC=2\nPassAllTG=1\nPassAllTG=2\nPassword=passow0rd\nLocation=1\nDebug=0" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n# DMR+\n[DMR Network 2]\nEnabled=${DMRP_EN}\nName=DMR+\nAddress=${DMRP_IP}\nPort=55555\n# Local=3352\nPassAllPC=1\nPassAllPC=2\nPassAllTG=1\nPassAllTG=2\nPassword=PASSWORD\nLocation=0\nDebug=0" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini
	printf "\n\n# Local HBLink network\n[DMR Network 3]\nEnabled=0\nName=HBLink\nAddress=44.131.4.2\nPort=55555\n# Local=3352\n# Local area TG on to slot 2 TG11\nTGRewrite=2,11,2,11,1\nPassword=PASSWORD\nLocation=0\nDebug=0" >>${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini

	nano ${CONFIG_PATH_DMRGATEWAY}DMRGateway.ini

# IRCDDBGATEWAY

	rm ${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway


	printf "gatewayType=1\ngatewayCallsign=${CALLSIGN}\ngatewayAddress=0.0.0.0\nicomAddress=127.0.0.1\nicomPort=20000\nhbAddress=127.0.0.1\nhbPort=20010\nlatitude=${LAT}\nlongitude=${LONG}\ndescription1=${DESCRIPTION}\ndescription2=${DESCRIPTION}\nurl=${URL}" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall1=${CALLSIGN}\nrepeaterBand1=${MODULE}\nrepeaterType1=0\nrepeaterAddress1=127.0.0.1\nrepeaterPort1=20011\nreflector1=${DS_STARTUP} ${REF_MOSULE}\natStartup1=1\nreconnect1=0\nfrequency1=${FREQ_TX}\noffe1=${SHIFT: -9: -8}${SHIFT: -8: -7}${SHIFT: -7: -6}.${SHIFT: -6}\nrangeKms1=1.000\nlatitude1=${LAT}\nlongitude1=${LONG}\nagl1=3.000\ndescription1_1=${DESCRIPTION}\ndescription1_2=${DESCRIPTION}\nurl1=${URL}\nband1_1=0\nband1_2=0\nband1_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall2=\nrepeaterBand2=\nrepeaterType2=0\nrepeaterAddress2=127.0.0.1\nrepeaterPort2=20012\nreflector2=\natStartup2=0\nreconnect2=0\nfrequency2=0.00000\noffset2=0.0000\nrangeKms2=0.000\nlatitude2=0.000000\nlongitude2=0.000000\nagl2=0.000\ndescription2_1=\ndescription2_2=\nurl2=\nband2_1=0\nband2_2=0\nband2_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall3=\nrepeaterBand3=\nrepeaterType3=0\nrepeaterAddress3=127.0.0.1\nrepeaterPort3=20012\nreflector3=\natStartup3=0\nreconnect3=0\nfrequency3=0.00000\noffset3=0.0000\nrangeKms3=0.000\nlatitude3=0.000000\nlongitude3=0.000000\nagl3=0.000\ndescription3_1=\ndescription3_2=\nurl2=\nband3_1=0\nband3_2=0\nband3_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall4=\nrepeaterBand2=\nrepeaterType4=0\nrepeaterAddress4=127.0.0.1\nrepeaterPort4=20012\nreflector4=\natStartup4=0\nreconnect4=0\nfrequency4=0.00000\noffset4=0.0000\nrangeKms4=0.000\nlatitude4=0.000000\nlongitude4=0.000000\nagl4=0.000\ndescription4_1=\ndescription4_2=\nurl4=\nband4_1=0\nband4_2=0\nband4_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nircddbEnabled=${IRC_EN}\nircddbHostname=rr.openquad.net\nircddbUsername=${CALLSIGN}\nircddbPassword=${IRC_PWD}\nircddbEnabled2=0\nircddbHostname2=rr.openquad.net\nircddbUsername2=\nircddbPassword2=\nircddbEnabled3=0\nircddbHostname3=\nircddbUsername3=\nircddbPassword3=\nircddbEnabled4=0\nircddbHostname4=\nircddbUsername4=\nircddbPassword4=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\naprsEnabled=${APRS_EN}\naprsHostname=${APRS_HOST}\naprsPort=${APRS_PORT}\ndextraEnabled=${DEXTRA_EN}" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\ndextraMaxDongles=5\ndplusEnabled=${DPLUS_EN}\ndplusMaxDongles=5\ndplusLogin=${CALLSIGN}" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\ndcsEnabled=1\nccsEnabled=1\nccsHost=CCS701\nxlxEnabled=1\nxlxOverrideLocal=1\nxlxHostsFileUrl=xlxapi.rlx.lu/api.php?do=GetReflectorHostname" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand1=B\nstarNetCallsign1=\nstarNetLogoff1=\nstarNetInfo1=\nstarNetPermanent1=\nstarNetUserTimeout1=300\nstarNetGroupTimeout1=300\nstarNetCallsignSwitch1=1\nstarNetTXMsgSwitch1=1\nstarNetReflector1=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand2=B\nstarNetCallsign2=\nstarNetLogoff2=\nstarNetInfo2=\nstarNetPermanent2=\nstarNetUserTimeout2=300\nstarNetGroupTimeout2=300\nstarNetCallsignSwitch2=1\nstarNetTXMsgSwitch2=1\nstarNetReflector2=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand3=B\nstarNetCallsign3=\nstarNetLogoff3=\nstarNetInfo3=\nstarNetPermanent3=\nstarNetUserTimeout3=300\nstarNetGroupTimeout3=300\nstarNetCallsignSwitch3=1\nstarNetTXMsgSwitch3=1\nstarNetReflector3=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand4=B\nstarNetCallsign4=\nstarNetLogoff4=\nstarNetInfo4=\nstarNetPermanent4=\nstarNetUserTimeout4=300\nstarNetGroupTimeout4=300\nstarNetCallsignSwitch4=1\nstarNetTXMsgSwitch4=1\nstarNetReflector4=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand5=B\nstarNetCallsign5=\nstarNetLogoff5=\nstarNetInfo5=\nstarNetPermanent5=\nstarNetUserTimeout5=300\nstarNetGroupTimeout5=300\nstarNetCallsignSwitch5=1\nstarNetTXMsgSwitch5=1\nstarNetReflector5=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nremoteEnabled=1\nremotePassword=mettipassword\nremotePort=10022\nlanguage=${LANGUIGE_NUM}\ninfoEnabled=1\nechoEnabled=1\nlogEnabled=1\ndratsEnabled=1\ndtmfEnabled=1\nwindowX=290\nwindowY=284" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway

	nano ${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway

exit 0

