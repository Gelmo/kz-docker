#!/bin/bash

./lgsm-gameserver auto-install

echo "metamod" | ./lgsm-gameserver mi
sleep 5s

echo "sourcemod" | ./lgsm-gameserver mi
sleep 5s

./lgsm-gameserver start
sleep 30s
