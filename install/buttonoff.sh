#!/bin/sh

PATH_FILEEXECBUTTON=$1
FILE_NAME=$2

	echo 'installazione di buttonoff....'

	echo 'Creazione file python'

	echo '#!/usr/bin/python\n#Script per la gestione del power off del sistema tramite pulsante\n#collegato alla GPIO\n#scritto da Fabio PASTORINO IZ1JXP, Mauro ZUNINO IW1ELO' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'import RPi.GPIO as GPIO' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'import os\n' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setmode(GPIO.BCM)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setwarnings(False)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setup(21,GPIO.IN,pull_up_down=GPIO.PUD_UP)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.setup(16,GPIO.OUT)\n' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#attendo la pressione del tasto (pin a massa)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.wait_for_edge(21,GPIO.FALLING)\n' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo '#accendo il led per confermare avvenuta fase di poweroff' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'GPIO.output(16, True)' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py
	echo 'os.system("sudo shutdown -h now")' >>${PATH_FILEEXECBUTTON}${FILE_NAME}.py

	chmod 777 ${PATH_FILEEXECBUTTON}${FILE_NAME}.py

	# nano ${PATH_FILEEXECBUTTON}${FILE_NAME}.py

	echo 'Creazione servizio systemd....'

	echo '[Unit]' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'Description=Servizio Button Off' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'After=syslog.target network.target\n' >>/lib/systemd/system/${FILE_NAME}.service
	echo '[Service]' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'User=root' >>/lib/systemd/system/${FILE_NAME}.service
	echo "WorkingDirectory=${PATH_FILEEXECBUTTON}" >>/lib/systemd/system/${FILE_NAME}.service
	echo "ExecStart=/usr/bin/python ${PATH_FILEEXECBUTTON}${FILE_NAME}.py" >>/lib/systemd/system/${FILE_NAME}.service
	echo 'ExecReload=/bin/kill -HUP $MAINPID' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'KillMode=process\n' >>/lib/systemd/system/${FILE_NAME}.service
	echo '[Install]' >>/lib/systemd/system/${FILE_NAME}.service
	echo 'WantedBy=multi-user.target' >>/lib/systemd/system/${FILE_NAME}.service

	# nano /lib/systemd/system/${FILE_NAME}.service

	echo '[Timer]' >>/lib/systemd/system/${FILE_NAME}.timer
	echo 'OnStartupSec=30\n' >>/lib/systemd/system/${FILE_NAME}.timer
	echo '[Install]' >>/lib/systemd/system/${FILE_NAME}.timer
	echo 'WantedBy=multi-user.target' >>/lib/systemd/system/${FILE_NAME}.timer

	# nano /lib/systemd/system/${FILE_NAME}.timer

	chmod 755 /lib/systemd/system/${FILE_NAME}.service
	chmod 755 /lib/systemd/system/${FILE_NAME}.timer

	

	# systemctl enable ${FILE_NAME}.timer

	echo 'Fare "sudo reboot" per il corretto funzionanmeto.'
	echo "Per avviare manualmente l'applicazione   'sudo service ${FILE_NAME} start'"
	echo "per arrestare manualmente l'applicazione 'sudo service ${FILE_NAME} stop'"
	echo "Per disabilitare l'avvio automatico      'sudo systemctl disable ${FILE_NAME}.timer'"
	
exit 0
