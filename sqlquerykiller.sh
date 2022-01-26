#!/bin/bash

DBHOST=
DBUSER=
DBPASSWD=
DBPORT=


#init boucle while
/bin/systemctl -q is-active "requestkillerSQL.service"
status=$?

#start boucle while



while [[ $status == 0 ]]
	do
		mysql $DBUSER $DBPASSWD $DBHOST $DBPORT -e "select concat('KILL ',id,';')  from information_schema.processlist where  INFO like 'SELECT%' and time >= 150;"
		
    #test service active
    /bin/systemctl -q is-active "requestkillerSQL.service"
		status=$?
    
    #exec all seconds
		sleep 1
	done
