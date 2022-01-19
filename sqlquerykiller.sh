#!/bin/bash

DBHOST=
DBUSER=
DBPASSWD=
DBPORT=


mysql $DBUSER $DBPASSWD $DBHOST $DBPORT -e "select concat('KILL ',id,';')  from information_schema.processlist where  INFO like 'SELECT%' and time >= 150;"
