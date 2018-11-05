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
QUADNET_EN="0"
IRC_PWD=""     
DPLUS_EN="1"
DEXTRA_EN="1"
DS_STARTUP="DCS999"
REF_MODULE="K"
REMOTE_EN="0"
REMOTE_PWD="password"
REMOTE_PORT="10022"
LANGUAGE="Italiano"
#language list
#                0   English(UK)
#                1   Deutsch
#                2   Dansk
#                3   Francais
#                4   Italiano
#                5   Espanol
#                6   Svenska
#                7   Polski
#                8   English(US)
#                9   Nederlands(NL)
#               10   Nederland(BE)

# DMR
DMR_EN="1"
CC="1"
TA="1"
XLX_EN="0"
XLX_TG="6"
XLX_TS="1"
XLX_STARTUP="999"
BM_EN="1"
BM_IP="bm2222@dmrbrescia.it"
DMRP_EN="0"
DMRP_IP="93.186.255.126"

# YSF C4FM
YSF_EN="1"
FCS_EN="1"
YSFFCS_START="IT C4FM Piemonte"
YSF_TXHANG="1"

# APRS
APRS_EN="1"
APRS_HOST="italy1.aprs2.net"
APRS_PORT="14580"
APRS_PWD=$(curl http://n5dux.com/ham/aprs-passcode/?callsign=$CALLSIGN | grep -e "size=24>" | cut -f 5 -d">" | cut -f1 -d"<")

#DASHBOARD
DASH_EN="1"
CONFIG_PATH_DASHBOARD="/var/www/html/MMDVMHost-Dashboard/config/"

# -----------------------
# MMDVMHost-Configuration
# -----------------------
Snm="on"				   # Enable extended lookup (show names
ShTA="on"				   # Show Talker Alias
SL3="off"				   # Use SQLITE3-Database instead of DMRIDs.dat
TGN="on"				   # Enable TG-Names

# ------------------------
# YSFGateway-Configuration
# ------------------------
YSFGat="on"				   # Enable YSFGateway
YSFlog="YSFGateway"			   # Logfile-prefix
YSFini="YSFGateway.ini"		   # YSFGateway.ini-filename
YSFHos="YSFHotst.txt"			   # YSFHosts.txt-filename

# ------------------------
# DMRGateway-Configuration
# ------------------------
DMRGat="on"				   # Enable DMRGateway
DMRlog="DMRGateway"			   # Logfile-prefix
DMRini="DMRGateway.ini"		   # DMRGateway.ini-filename

# ---------------------------
# ircddbgateway-Configuration
# ---------------------------
ircDDB="ircddbgatewayd"		# Name of ircddbgateway-executeable

# --------------------
# Global Configuration
# --------------------
PathEx="/usr/local/bin/"	           # Path to executable files
TZ="Europe/Rome"			   # Timezone
LOC="en_GB"				   # Locale
URLlogo=""				   # URL to Logo
NETphp="on"				   # Use networks.php instead of configuration below
DMRlogo=""				   # URL to DMRplus-Logo
BMlogo=""				   # URL to BrandMeister-Logo
Ref="60"				   # Refresh page after in seconds
ShCI="on"				   # Show Custom Info
ShSI="on"				   # Show System Info
ShDU="on"				   # Show Disk Use	
ShRI="on"				   # Show Repeater Info
ShEM="on"				   # Show Enabled Modes
ShLH="on"				   # Show Last Heard List of today's
ShLT="on"				   # Show Today's local transmissions
ShPR="on"				   # Show progressbars
CPUT="on"				   # Enable CPU-temperature-warning
WART="60"				   # Warning temperature
NSF="on"				   # Enable Network-Switching-Function
DMRRSF="on"				   # Enable Reflector-Switching-Function (DMR)
YSFRSF="on"				   # Enable Reflector-Switching-Function (YSF)
UseSN=""				   # Username for switching networks
PasSN=""				   # Password for switching networks
MF="on"				   # Enable Management-Functions below
UseVL=""				   # Username for view log
PasVL=""				   # Password for view log	
UseHa=""				   # Username for halt
PasHa=""				   # Password for halt
UseRe=""		                   # Username for reboot
PasRe=""				   # Password for reboot
UseRs=""				   # Username for restart
PasRs=""				   # Password for restart
ShPO="on"				   # Show Powerstate (online or battery, wiringpi needed) 
GPIOMo="18"				   # GPIO pin to monitor
OnLnSt="1"				   # State that signalizes online-state
QRZcom="on"				   # Show link to QRZ.com on Callsigns
RSSI="avg"				   # RSSI value (min, max, avg, all)

#-----------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------#
#											   	                                          #
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

if [ $LANGUAGE = "English(UK)" ]; then
        LANGUAGE_NUM="0"
elif [ $LANGUAGE = "Deutsch" ]; then
        LANGUAGE_NUM="1"
elif [ $LANGUAGE = "Dansk" ]; then
        LANGUAGE_NUM="2"
elif [ $LANGUAGE = "Francais" ]; then
        LANGUAGE_NUM="3"
elif [ $LANGUAGE = "Italiano" ]; then
        LANGUAGE_NUM="4"
elif [ $LANGUAGE = "Espanol" ]; then
        LANGUAGE_NUM="5"
elif [ $LANGUAGE = "Svenska" ]; then
        LANGUAGE_NUM="6"
elif [ $LANGUAGE = "Polski" ]; then
        LANGUAGE_NUM="7"
elif [ $LANGUAGE = "English(US)" ]; then
        LANGUAGE_NUM="8"
elif [ $LANGUAGE = "Nederlands(NL)" ]; then
        LANGUAGE_NUM="9"
elif [ $LANGUAGE = "Nederland(BE)" ]; then
        LANGUAGE_NUM="10"
else
        LANGUAGE_NUM="0"
fi


SHIFT=$((${FREQ_RX:0:3}${FREQ_RX:4} - ${FREQ_TX:0:3}${FREQ_TX:4}))

	rm  ${CONFIG_PATH_MMDVMHOST}MMDVM.ini

	printf "[General]\nCallsign=${CALLSIGN}\nId=${DMR_ID}\nTimeout=240\nDuplex=${RPT_OR_HS}\n# ModeHang=10\nRFModeHang=10\nNetModeHang=30\nDisplay=None\nDaemon=0 " >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Info]\nRXFrequency=${FREQ_RX:0:3}${FREQ_RX:4}\nTXFrequency=${FREQ_TX:0:3}${FREQ_TX:4}\nPower=10\nLatitude=${LAT}\nLongitude=${LONG}\nHeight=${HEIGHT}\nLocation=${LOCATION}\nDescription=${DESCRIPTION}\nURL=${URL}" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Log]\n# Logging levels, 0=No logging\nDisplayLevel=1\nFileLevel=2\nFilePath=${LOG_PATH_MMDVMHOST}\nFileRoot=MMDVM" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[CW Id]\nEnable=1\nTime=10\n# Callsign=" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[DMR Id Lookup]\nFile=${LOG_PATH_MMDVMHOST}DMRIds.dat\nTime=24" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[NXDN Id Lookup]\nFile=${LOG_PATH_MMDVMHOST}NXDN.csv\nTime=24" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Modem]\nPort=${PORT_MODEM}\nProtocol=uart\n# Address=0x22\nTXInvert=${TX_INV}\nRXInvert=${RX_INV}\nPTTInvert=0\nTXDelay=100\nRXOffset=0\nTXOffset=0\nDMRDelay=0\nRXLevel=50\nTXLevel=50\nRXDCOffset=0\nTXDCOffset=0\nRFLevel=100\n# CWIdTXLevel=50\n# D-StarTXLevel=50\n# DMRTXLevel=50\n# YSFTXLevel=50\n# P25TXLevel=50\n# NXDNTXLevel=50\n# POCSAGTXLevel=50\nRSSIMappingFile=RSSI.dat\nTrace=0\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Transparent Data]\nEnable=0\nRemoteAddress=127.0.0.1\nRemotePort=40094\nLocalPort=40095\n# SendFrameType=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[UMP]\nEnable=0\n# Port=\\.\COM4\n# Port=/dev/ttyACM1" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[D-Star]\nEnable=${DS_EN}\nModule=${MODULE}\nSelfOnly=0\nAckReply=1\nAckTime=750\nAckMessage=0\nErrorReply=1\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[DMR]\nEnable=${DMR_EN}\nBeacons=1\nBeaconInterval=180\nBeaconDuration=3\nColorCode=${CC}\nSelfOnly=0\nEmbeddedLCOnly=0\nDumpTAData=${TA}\n# Prefixes=234,235\n# Slot1TGWhiteList=\n# Slot2TGWhiteList=\nCallHang=3\nTXHang=4\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[System Fusion]\nEnable=${YSF_EN}\nLowDeviation=0\nSelfOnly=0\nTXHang=${YSF_TXHANG}\n# DGID=1\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[P25]\nEnable=0\nNAC=293\nSelfOnly=0\nOverrideUIDCheck=0\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[NXDN]\nEnable=0\nRAN=1\nSelfOnly=0\nRemoteGateway=0\n# ModeHang=10" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[POCSAG]\nEnable=0\nFrequency=439987500" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[D-Star Network]\nEnable=1\nGatewayAddress=127.0.0.1\nGatewayPort=20010\nLocalPort=20011\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[DMR Network]\nEnable=${DMR_EN}\nAddress=127.0.0.1\nPort=62031\nJitter=360\nLocal=62032\nPassword=PASSWORD\n# Options=\nSlot1=1\nSlot2=1\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[System Fusion Network]\nEnable=1\nLocalAddress=127.0.0.1\nLocalPort=3200\nGatewayAddress=127.0.0.1\nGatewayPort=4200\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[P25 Network]\nEnable=0\nGatewayAddress=127.0.0.1\nGatewayPort=42020\nLocalPort=32010\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[NXDN Network]\nEnable=0\nLocalAddress=127.0.0.1\nLocalPort=14021\nGatewayAddress=127.0.0.1\nGatewayPort=14020\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[POCSAG Network]\nEnable=0\nLocalAddress=127.0.0.1\nLocalPort=3800\nGatewayAddress=127.0.0.1\nGatewayPort=4800\n# ModeHang=3\nDebug=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[TFT Serial]\n# Port=modem\nPort=/dev/ttyAMA0\nBrightness=50" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[HD44780]\nRows=2\nColumns=16\n\n# For basic HD44780 displays (4-bit connection)\n# rs, strb, d0, d1, d2, d3\nPins=11,10,0,1,2,3\n\n# Device address for I2C\nI2CAddress=0x20\n\n# PWM backlight\nPWM=0\nPWMPin=21\nPWMBright=100\nPWMDim=16\n\nDisplayClock=1\nUTC=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[Nextion]\n# Port=modem\nPort=/dev/ttyAMA0\nBrightness=50\nDisplayClock=1\nUTC=0\n#Screen Layout: 0=G4KLX 2=ON7LDS\nScreenLayout=2\nIdleBrightness=20" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[OLED]\nType=3\nBrightness=0\nInvert=0\nScroll=1\nRotate=0\nCast=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	printf "\n\n[LCDproc]\nAddress=localhost\nPort=13666\n#LocalPort=13667\nDimOnIdle=0\nDisplayClock=1\nUTC=0" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
        printf "\n\n[Lock File]\nEnable=0\nFile=/tmp/MMDVM_Active.lck" >>${CONFIG_PATH_MMDVMHOST}MMDVM.ini
	nano ${CONFIG_PATH_MMDVMHOST}MMDVM.ini

# YSFGATEWEAY
if [ $YSF_EN = "1" ] || [ $FCS_EN = "1" ]; then
	rm ${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini

	printf "[General]\nCallsign=${CALLSIGN}\nSuffix=${YSF_SUFFIX}\nId=${DMR_ID}\nRptAddress=127.0.0.1\nRptPort=3200\nLocalAddress=127.0.0.1\nLocalPort=4200\nDaemon=0" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[Info]\nRXFrequency=${FREQ_RX:0:3}${FREQ_RX:4}\nTXFrequency=${FREQ_TX:0:3}${FREQ_TX:4}\nPower=10\nLatitude=${LAT}\nLongitude=${LONG}\nHeight=${HEIGHT}\nLocation=${LOCATION}\nDescription=${DESCRIPTION}" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[Log]\n# Logging levels, 0=No logging\nDisplayLevel=1\nFileLevel=2\nFilePath=${LOG_PATH_YSFGATEWAY}\nFileRoot=YSFGateway" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[aprs.fi]\nEnable=${APRS_EN}\nServer=${APRS_HOST}\nPort=${APRS_PORT}\nPassword=${APRS_PWD}\nDescription=${DESCRIPTION}\nSuffix=Y" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[Network]\n${YSF_AUTOSTART}Startup=${YSFFCS_START}\nInactivityTimeout=0\nRevert=0\nDebug=0" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[YSF Network]\nEnable=1\nPort=42000\nHosts=${LOG_PATH_YSFGATEWAY}YSFHosts.txt\nReloadTime=60\nParrotAddress=127.0.0.1\nParrotPort=42012\nYSF2DMRAddress=127.0.0.1\nYSF2DMRPort=42013\nYSF2NXDNAddress=127.0.0.1\nYSF2NXDNPort=42014\nYSF2P25Address=127.0.0.1\nYSF2P25Port=42015" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
	printf "\n\n[FCS Network]\nEnable=${FCS_EN}\nRooms=${LOG_PATH_YSFGATEWAY}FCSRooms.txt\nPort=42001" >>${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini

	nano ${CONFIG_PATH_YSFGATEWAY}YSFGateway.ini
fi

# DMRGATEWAY
if [ $DMR_EN = "1" ]; then
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
fi

# IRCDDBGATEWAY
if [ $DS_EN = "1" ]; then
	rm ${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway

	printf "gatewayType=1\ngatewayCallsign=${CALLSIGN}\ngatewayAddress=0.0.0.0\nicomAddress=127.0.0.1\nicomPort=20000\nhbAddress=127.0.0.1\nhbPort=20010\nlatitude=${LAT}\nlongitude=${LONG}\ndescription1=${DESCRIPTION}\ndescription2=${DESCRIPTION}\nurl=${URL}" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall1=${CALLSIGN}\nrepeaterBand1=${MODULE}\nrepeaterType1=0\nrepeaterAddress1=127.0.0.1\nrepeaterPort1=20011\nreflector1=${DS_STARTUP} ${REF_MODULE}\natStartup1=1\nreconnect1=0\nfrequency1=${FREQ_TX}\noffe1=${SHIFT: -9: -8}${SHIFT: -8: -7}${SHIFT: -7: -6}.${SHIFT: -6}\nrangeKms1=1.000\nlatitude1=${LAT}\nlongitude1=${LONG}\nagl1=3.000\ndescription1_1=${DESCRIPTION}\ndescription1_2=${DESCRIPTION}\nurl1=${URL}\nband1_1=0\nband1_2=0\nband1_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall2=\nrepeaterBand2=\nrepeaterType2=0\nrepeaterAddress2=127.0.0.1\nrepeaterPort2=20012\nreflector2=\natStartup2=0\nreconnect2=0\nfrequency2=0.00000\noffset2=0.0000\nrangeKms2=0.000\nlatitude2=0.000000\nlongitude2=0.000000\nagl2=0.000\ndescription2_1=\ndescription2_2=\nurl2=\nband2_1=0\nband2_2=0\nband2_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall3=\nrepeaterBand3=\nrepeaterType3=0\nrepeaterAddress3=127.0.0.1\nrepeaterPort3=20013\nreflector3=\natStartup3=0\nreconnect3=0\nfrequency3=0.00000\noffset3=0.0000\nrangeKms3=0.000\nlatitude3=0.000000\nlongitude3=0.000000\nagl3=0.000\ndescription3_1=\ndescription3_2=\nurl3=\nband3_1=0\nband3_2=0\nband3_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nrepeaterCall4=\nrepeaterBand4=\nrepeaterType4=0\nrepeaterAddress4=127.0.0.1\nrepeaterPort4=20014\nreflector4=\natStartup4=0\nreconnect4=0\nfrequency4=0.00000\noffset4=0.0000\nrangeKms4=0.000\nlatitude4=0.000000\nlongitude4=0.000000\nagl4=0.000\ndescription4_1=\ndescription4_2=\nurl4=\nband4_1=0\nband4_2=0\nband4_3=0" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nircddbEnabled=${IRC_EN}\nircddbHostname=group1-irc.ircddb.net\nircddbUsername=${CALLSIGN}\nircddbPassword=${IRC_PWD}\nircddbEnabled2=${QUADNET_EN}\nircddbHostname2=rr.openquad.net\nircddbUsername2=${CALLSIGN}\nircddbPassword2=${IRC_PWD}\nircddbEnabled3=0\nircddbHostname3=\nircddbUsername3=\nircddbPassword3=\nircddbEnabled4=0\nircddbHostname4=\nircddbUsername4=\nircddbPassword4=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\naprsEnabled=${APRS_EN}\naprsHostname=${APRS_HOST}\naprsPort=${APRS_PORT}\ndextraEnabled=${DEXTRA_EN}" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\ndextraMaxDongles=5\ndplusEnabled=${DPLUS_EN}\ndplusMaxDongles=5\ndplusLogin=${CALLSIGN}" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\ndcsEnabled=1\nccsEnabled=1\nccsHost=CCS701\nxlxEnabled=1\nxlxOverrideLocal=1\nxlxHostsFileUrl=xlxapi.rlx.lu/api.php?do=GetReflectorHostname" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand1=A\nstarNetCallsign1=\nstarNetLogoff1=\nstarNetInfo1=\nstarNetPermanent1=\nstarNetUserTimeout1=300\nstarNetGroupTimeout1=300\nstarNetCallsignSwitch1=0\nstarNetTXMsgSwitch1=0\nstarNetReflector1=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand2=A\nstarNetCallsign2=\nstarNetLogoff2=\nstarNetInfo2=\nstarNetPermanent2=\nstarNetUserTimeout2=300\nstarNetGroupTimeout2=300\nstarNetCallsignSwitch2=0\nstarNetTXMsgSwitch2=0\nstarNetReflector2=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand3=A\nstarNetCallsign3=\nstarNetLogoff3=\nstarNetInfo3=\nstarNetPermanent3=\nstarNetUserTimeout3=300\nstarNetGroupTimeout3=300\nstarNetCallsignSwitch3=0\nstarNetTXMsgSwitch3=0\nstarNetReflector3=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand4=A\nstarNetCallsign4=\nstarNetLogoff4=\nstarNetInfo4=\nstarNetPermanent4=\nstarNetUserTimeout4=300\nstarNetGroupTimeout4=300\nstarNetCallsignSwitch4=0\nstarNetTXMsgSwitch4=0\nstarNetReflector4=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nstarNetBand5=A\nstarNetCallsign5=\nstarNetLogoff5=\nstarNetInfo5=\nstarNetPermanent5=\nstarNetUserTimeout5=300\nstarNetGroupTimeout5=300\nstarNetCallsignSwitch5=0\nstarNetTXMsgSwitch5=0\nstarNetReflector5=" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
	printf "\nremoteEnabled=${REMOTE_EN}\nremotePassword=${REMOTE_PWD}\nremotePort=${REMOTE_PORT}\nlanguage=${LANGUAGE_NUM}\ninfoEnabled=1\nechoEnabled=1\nlogEnabled=1\ndratsEnabled=1\ndtmfEnabled=1\nwindowX=290\nwindowY=284" >>${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway

	nano ${CONFIG_PATH_IRCDDBGATEWAY}ircddbgateway
fi

if [ $DASH_EN = "1" ]; then

	rm  ${CONFIG_PATH_DASHBOARD}config.php

	printf "<?php\n# This is an auto-generated config-file!\n# Be careful, when manual editing this!\n\ndate_default_timezone_set('UTC');">>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("MMDVMLOGPATH", "${LOG_PATH_MMDVMHOST}");\ndefine("MMDVMINIPATH", "${CONFIG_PATH_MMDVMHOST}");\ndefine("MMDVMINIFILENAME", "MMDVM.ini");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("MMDVMHOSTPATH", "/usr/local/bin/");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $Snm = "on" ]; then
		printf '\ndefine("ENABLEXTDLOOKUP", "${Snm}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShTA = "on" ]; then
		printf '\ndefine("TALKERALIAS", "${ShTA}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $SL3 = "on" ]; then
        printf '\ndefine("USESQLITE", "${SL3}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("DMRIDDATPATH", "${LOG_PATH_MMDVMHOST}DMRIds.dat");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $TGN = "on" ]; then
		printf '\ndefine("RESOLVETGS", "${TGN}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $YSFGat = "on" ]; then
		printf '\ndefine("ENABLEYSFGATEWAY", "${YSFGat}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("YSFGATEWAYLOGPATH", "${LOG_PATH_YSFGATEWAY}");\ndefine("YSFGATEWAYLOGPREFIX", "YSFGateway");\ndefine("YSFGATEWAYINIPATH", "${CONFIG_PATH_YSFGATEWAY}");\ndefine("YSFGATEWAYINIFILENAME", "YSFGateway.ini");\ndefine("YSFHOSTSPATH", "${LOG_PATH_YSFGATEWAY}YSFHosts.txt");\ndefine("YSFHOSTSFILENAME", "YSFHotst.txt");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $DMRGat = "on" ]; then
		printf '\ndefine("ENABLEDMRGATEWAY", "${DMRGat}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("DMRGATEWAYLOGPATH", "${LOG_PATH_DMRGATEWAY}");\ndefine("DMRGATEWAYLOGPREFIX", "DMRGateway");\ndefine("DMRGATEWAYINIPATH", "${CONFIG_PATH_DMRGATEWAY}");\ndefine("DMRGATEWAYPATH", "/usr/local/bin/");\ndefine("DMRGATEWAYINIFILENAME", "DMRGateway.ini");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("LINKLOGPATH", "${LOG_PATH_IRCDDBGATEWAY}");\ndefine("IRCDDBGATEWAY", "ircddbgatewayd");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("TIMEZONE", "${TZ}");\ndefine("LOCALE", "${LOC}");\ndefine("LOGO", "${URLlogo}");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $NETphp = "on" ]; then
		printf '\ndefine("JSONNETWORK", "${NETphp}");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("DMRPLUSLOGO", "${DMRlogo}");\ndefine("BRANDMEISTERLOGO", "${BMlogo}");\ndefine("REFRESHAFTER", "${Ref}");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $ShCI = "on" ]; then
		printf '\ndefine("SHOWCUSTOM", "'${ShCI}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShSI = "on" ]; then
		printf '\ndefine("SHOWCPU", "'${ShSI}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShDU = "on" ]; then
		printf '\ndefine("SHOWDISK", "'${ShDU}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShRI = "on" ]; then
		printf '\ndefine("SHOWRPTINFO", "'${ShRI}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShEM = "on" ]; then
		printf '\ndefine("SHOWMODES", "'${ShEM}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShLH = "on" ]; then
		printf '\ndefine("SHOWLH", "'${ShLH}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShLT = "on" ]; then
		printf '\ndefine("SHOWLOCALTX", "'${ShLT}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $ShPR = "on" ]; then
		printf '\ndefine("SHOWPROGRESSBARS", "'${ShPR}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $CPUT = "on" ]; then
		printf '\ndefine("TEMPERATUREALERT", "'${CPUT}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
		printf '\ndefine("TEMPERATUREHIGHLEVEL", "'${WART}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $NSF = "on" ]; then
		printf '\ndefine("ENABLENETWORKSWITCHING", "'${NSF}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $DMRRSF = "on" ]; then
		printf '\ndefine("ENABLEREFLECTORSWITCHING", "'${DMRRSF}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	if [ $YSFRSF = "on" ]; then
		printf '\ndefine("ENABLEYSFREFLECTORSWITCHING", "'${YSFRSF}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("SWITCHNETWORKUSER", "'${UseSN}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("SWITCHNETWORKPW", "'${PasSN}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $MF = "on" ]; then
		printf '\ndefine("ENABLEMANAGEMENT", "'${MF}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("VIEWLOGUSER", "'${UseVL}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("VIEWLOGPW", "'${PasVL}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("HALTUSER", "'${UseHa}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("HALTPW", "'${PasHa}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("REBOOTUSER", "'${UseRe}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("REBOOTPW", "'${PasRe}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("RESTARTUSER", "'${UseRs}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("RESTARTPW", "'${PasRs}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("REBOOTYSFGATEWAY", "sudo service ysfgateway restart");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("REBOOTMMDVM", "sudo service mmdvmhost restart");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("REBOOTSYS", "sudo reboot");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("HALTSYS", "sudo halt");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $ShPO = "on" ]; then
		printf '\ndefine("SHOWPOWERSTATE", "'${ShPO}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("POWERONLINEPIN", "'${GPIOMo}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	printf '\ndefine("POWERONLINESTATE", "'${OnLnSt}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	if [ $QRZcom = "on" ]; then
		printf '\ndefine("SHOWQRZ", "'${QRZcom}'");'>>${CONFIG_PATH_DASHBOARD}config.php
	fi
	printf '\ndefine("RSSI", "'${RSSI}'");'>>${CONFIG_PATH_DASHBOARD}config.php

	printf "\n?>">>${CONFIG_PATH_DASHBOARD}config.php

	nano ${CONFIG_PATH_DASHBOARD}config.php
fi

exit 0

