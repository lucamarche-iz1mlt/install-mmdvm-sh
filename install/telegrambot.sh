#! /bin/sh

PATH_RUN_SCRIPT=$1

	pip install telepot
	sleep 2

	echo 'Crezione dei servizi.....'

	cp -R ${PATH_RUN_SCRIPT}/telegrambot.py /home/pi/
	cp -R ${PATH_RUN_SCRIPT}/service/telegrambot.service /lib/systemd/system/
	cp -R ${PATH_RUN_SCRIPT}/service/telegrambot.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/telegrambot.service
	chmod 755 /lib/systemd/system/telegrambot.timer

exit 0