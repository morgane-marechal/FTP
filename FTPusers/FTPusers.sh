#!/bin/bash

here=$(pwd)
echo $here

sudo apt-get install -y proftpd openssl
sudo apt-get install proftpd-*
sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt -nodes -days 365
sudo chmod 600 /etc/ssl/certs/proftpd.crt
sudo chmod 600 /etc/ssl/private/proftpd.key
sudo cat $here/proftpd.conf > /etc/proftpd/proftpd.conf 
sudo cat $here/tls.conf > /etc/proftpd/tls.conf
sudo cat $here/modules.conf > /etc/proftpd/modules.conf
sudo systemctl restart proftpd
echo "Installation terminée !!!!!!!"
sudo groupadd FTPusers

INPUT=User.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

while read id nom mdp role
do
 echo "ID : $id"
        echo "Nom : $nom"
        echo "Mot de passe : $mdp"
        echo "Role : $role"
sudo useradd -m $nom
echo $nom:$mdp | sudo chpasswd
sudo addgroup $nom FTPusers


if [ ${role:0:5} == "Admin" ]
then
sudo usermod -aG sudo $nom
echo "$nom ajouter au groupe sudo"
fi
done < $INPUT

