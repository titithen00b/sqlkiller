#!/bin/bash

host=""
password=""
user=""
port=""

wanttime=180

#init boucle while
/bin/systemctl -q is-active "requestkillerSQL.service"
status=$?

timestamp=$(date +"%d-%m-%y_%H:%M")

listsqlrequest(){
    resultat=`mysql -u "$user" -p"$password" -h "$host" -P "$port" -e "select concat('KILL ',id,';') from information_schema.processlist where INFO like 'SELECT%' AND TIME >='$wanttime';"`

    return 0
}


killrequest(){
    kill=$(echo $resultat | cut -c 24-)
    echo $kill 
    return 0
}


killcom(){
    if [[ "$kill" == *KILL* ]]
    then mysql -u "$user" -p"$password" -h "$host" -P "$port" -e "$kill"
    else echo "[$timestamp] Aucune requête trouvé avec le temps maximal indiqué : $wanttime seconde(s)" >> /var/log/killerrequests
    fi

}

stopservice(){
    systemctl stop "requestkillerSQL.service"
    echo "[$timestamp] Le service a été arreté."
}


#start boucle while
while [[ $status == 0 ]]
do

    if [[ $wanttime -ge 1 ]]; then 
        listsqlrequest
        killrequest
        killcom
    else 
        stopservice
        echo "[$timestamp] Merci de rentrer un temps d'execution (en seconde) valide" >> /var/log/killerrequests
        exit
    fi
#test service active    
/bin/systemctl -q is-active "requestkillerSQL.service"
    status=$?

#exec all 10 seconds
    sleep 10
done
