import commands
import sys
import telepot
import time

def handle(msg):
    chat_id = msg['chat']['id']
    command = msg['text']

    print '%s' % command 

    if command == '/info':
    	info = commands.getoutput("uname -a")
     	bot.sendMessage(chat_id,"Sistema basato su Pi-Star %s" % info) 
		
    elif command == '/mmdvmstop':
      	bot.sendMessage(chat_id, "MMDVMHost arrestato")
      	out = commands.getoutput("sudo service mmdvmhost stop")
		
    elif command == '/mmdvmstart':
      	bot.sendMessage(chat_id, "MMDVMHost partito")
      	out = commands.getoutput("sudo service mmdvmhost start")
	
    elif command == '/mmdvmrst':
      	bot.sendMessage(chat_id, "MMDVMHost riavviato")
      	out = commands.getoutput("sudo service mmdvmhost restart")

    elif command == '/dmrgstop':
      	bot.sendMessage(chat_id, "DMRGateway arrestato")
      	out = commands.getoutput("sudo service dmrgateway stop")
		
    elif command == '/dmrgstart':
      	bot.sendMessage(chat_id, "DMRGateway partito")
      	out = commands.getoutput("sudo service dmrgateway start")
	
    elif command == '/dmrgrst':
      	bot.sendMessage(chat_id, "DMRGateway riavviato")
      	out = commands.getoutput("sudo service dmrgateway restart")	
		
    elif command == '/reboot':     	
        out = commands.getoutput("sudo reboot")
        bot.sendMessage(chat_id, "Riavvio in corso...")
		
    elif command == '/off':  
	bot.sendMessage(chat_id, "Arresro...")   	
      	out = commands.getoutput("sudo halt")

#----------------------------------------------------------------------------------------------------------------------------	
    elif command[0:5] == '/temp':
	temp = commands.getoutput("cat /sys/class/thermal/thermal_zone0/temp")
      	temperatura = int(temp) / 1000
      	temp = str(temperatura)
      	out = commands.getoutput("texttransmit iz1mlt_b -text:'Temp CPU %s gradi'" % temp)
        bot.sendMessage(chat_id,"Temperatura CPU %s gradi" % temp)

bot = telepot.Bot('token')
bot.message_loop(handle)

print 'sono in ascolto...'

while 1:
    time.sleep(10)

