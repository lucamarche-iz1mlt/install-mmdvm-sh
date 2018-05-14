
# INSTALLAZIONE MMDVM Raspebrry PI             


Scaricare il pacchetto da terminale tramite il comando  

	git clone https://github.com/lucamarche-iz1mlt/install-mmdvm-sh.git ./install-mmdvm-sh

	cd install-mmdvm-sh

	Lanciare lo script tramite il comando

	sudo sh mmdvm.sh

	attendere fine istallazione....

# Comandi di avvio servizi

MMDVMHost

	sudo service mmdvmhost start
	
	sudo service mmdvmhost stop
	
	sudo service mmdvmhost reload
	
	sudo service mmdvmhost status
	
DMRGateway

	sudo service dmrgateway start
	
	sudo service dmrgateway stop
	
	sudo service dmrgateway reload
	
	sudo service dmrgateway status


YSFGateway

	sudo service ysfgateway start
	
	sudo service ysfgateway stop
	
	sudo service ysfgateway reload
	
	sudo service ysfgateway status

YSFParrot

	sudo service ysfparrot start
	
	sudo service ysfparrot stop
	
	sudo service ysfparrot reload
	
	sudo service ysfparrot status

Telegrambot

	sudo service ircddbgateway start
	
	sudo service ircddbgateway stop
	
	sudo service ircddbgateway reload
	
	sudo service ircddbgateway status

# Comando per l'avvio automatico servizio
	sudo systemctl enable mmdvmhost.timer
	sudo systemctl enable dmrgateway.timer
	sudo systemctl enable ysfgatewaty.timer
	sudo systemctl enable ysfparrot.timer
	sudo systemctl enable ircddbgateway.timer
	sudo systemctl enable telegrambot.timer

# Disabilitare servizio all'avvio
	sudo systemctl disable <nome_servizio>.timer


# Avvio programmi in modalità di debug
Ricordarsi di arrestare il servizio

	MMDVMHost
	sudo MMDVMHost /etc/mmdvmhost/MMDVM.ini
	
	DMRGateway
	sudo DMRGateway /etc/dmrgateway/DMRGateway.ini

	YSFGateway
	sudo DMRGateway /etc/dmrgateway/DMRGateway.ini
	
	ircDBGateway
	sudo ircddbgatewayd -logdir /var/log/ircddbgateway -confdir /etc/ircddbgateway

	Telegrambot
	sudo python /home/pi/telegrambot.py
	
CTRL+C per uscire

# Aggiungere servizio crontab

sudo crontab -e

aggiungere in fondo al file

	*/5 * * * * wget -O /var/log/ysfgateway/YSFHosts.txt http://register.ysfreflector.de/export_csv.php
	0  0  *  *  * sh /home/pi/script/DMRIDUpdate.sh 1>/dev/null 2>&1
	0  0  *  *  * wget -O /var/log/mmdvmhost/NXDN.csv http://nxmanager.weebly.com/uploads/7/1/2/0/71209569/nxuid_export.csv


# Percorsi file

MMDVMHost

	MMDVM.ini
	
	/etc/mmdvmhost/	
	
	LOG file e data base
	
	/var/log/mmdvmhost/

DMRGateway

	DMRGateway.ini

	/etc/dmrgateway/

	LOG file e data base

	/var/log/dmrgateway/

YSFgateway

	YSFGateway.ini

	/etc/ysfgateway/

	LOG file e data base

	/var/log/ysfgateway/

ircDDBGateway

	ircddbgateway_config

	/etc/ircddbgateway/

	LOG file e data base

	/var/log/ircddbgateway/
	
	AUDIO File and Reflector list
	
	/usr/local/share/opendv


