#!/bin/bash 
# Script om ejabber certificaten automatisch te vernieuwen.
# Datum: 24 mei 2018 
# Tim de Bruijn

readonly DIR='/dir/to/jabber/cert/'
readonly NAME='your.domain.tld'
readonly DATE=`date '+%Y-%m-%d %H:%M:%S'`

renew_cert(){
	   certbot certonly -d ${NAME} --standalone -n
   }
create_chain(){
      cat /etc/letsencrypt/live/${NAME}/privkey.pem /etc/letsencrypt/live/${NAME}/fullchain.pem /etc/letsencrypt/live/${NAME}/rootca.pem >${DIR}/${NAME}.pem
   }
set_permissions(){
      chmod 640 ${DIR}/${NAME}.pem
      chown root:ejabberd ${DIR}/${NAME}.pem
   }
restart_ejabberd(){
      systemctl restart ejabberd
   }
main(){
      renew_cert
      create_chain
      set_permissions
      restart_ejabberd
   }
main