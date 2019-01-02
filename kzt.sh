#!/bin/bash

cd \
 && mkdir downloads \
 && cd downloads/ \
 && wget https://bitbucket.org/kztimerglobalteam/kztimerglobal/downloads/1.90_Full.zip \
 && unzip 1.90_Full.zip && rm -rf 1.90_Full.zip \
 && rsync -Pva /home/linuxgsm/downloads/ /home/linuxgsm/linuxgsm/serverfiles/csgo/ \
 && rm -rf ~/downloads/*

cd \
 && wget https://kzmaps.tangoworldwide.net/mapcycles/kztimer.txt \
 && mv /home/linuxgsm/linuxgsm/kztimer.txt /home/linuxgsm/linuxgsm/serverfiles/csgo/mapcycle.txt

./lgsm-gameserver auto-install

echo "metamod" | ./lgsm-gameserver mi
sleep 5s

echo "sourcemod" | ./lgsm-gameserver mi
sleep 5s

./lgsm-gameserver start
