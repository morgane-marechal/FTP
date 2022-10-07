#!/bin/bash
here=$(pwd)
echo $here

sudo apt-get install -y proftpd openssl
sudo apt-get install proftpd-*
sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt -nodes -da>
sudo chmod 600 /etc/ssl/certs/proftpd.crt
sudo chmod 600 /etc/ssl/private/proftpd.key
sudo cat $here/proftpd.conf > /etc/proftpd/proftpd.conf
sudo cat $here/tls.conf > /etc/proftpd/tls.conf
sudo cat $here/modules.conf > /etc/proftpd/modules.conf
sudo systemctl restart proftpd
echo "Installation terminée !!!!!!!"
