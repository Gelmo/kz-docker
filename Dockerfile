FROM gelmo/kz-docker-base:latest

WORKDIR /home/linuxgsm/linuxgsm

# Stop apt-get asking to get Dialog frontend
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV LGSM_GAMESERVERNAME csgoserver
ENV LGSM_UPDATEINSTALLSKIP UPDATE
EXPOSE 27015/tcp
EXPOSE 27015/udp

USER linuxgsm

RUN cd \
 && mkdir downloads \
 && cd downloads/ \
 && wget https://bitbucket.org/kztimerglobalteam/gokz/downloads/GOKZ-latest.zip \
 && unzip GOKZ* && rm -rf GOKZ* \
 && rsync -Pva /home/linuxgsm/downloads/ /home/linuxgsm/linuxgsm/serverfiles/csgo/ \
 && rm -rf ~/downloads/*

RUN cd ~/downloads/ \
 && curl -s https://api.github.com/repos/danzayau/MovementAPI/releases/latest | grep browser_download_url | cut -d '"' -f 4 | xargs wget \
 && unzip -o Movement* \
 && rsync -Pva /home/linuxgsm/downloads/addons/ /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/ \
 && rm -rf ~/downloads/*

RUN cd ~/downloads/ \
 && wget https://users.alliedmods.net/~drifter/builds/dhooks/2.2/dhooks-2.2.0-hg126-linux.tar.gz \
 && tar -xzvf dhooks* \
 && rsync -Pva /home/linuxgsm/downloads/addons/ /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/ \
 && rm -rf ~/downloads/*

RUN cd ~/downloads/ \
 && wget http://updater.global-api.com/plugins/GlobalAPI-Core.smx \
 && touch /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/ \
 && touch /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/plugins/ \
 && mv ./GlobalAPI-Core.smx /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/plugins/ \
 && touch /home/linuxgsm/linuxgsm/serverfiles/csgo/cfg/ \
 && touch /home/linuxgsm/linuxgsm/serverfiles/csgo/cfg/sourcemod/ \
 && touch /home/linuxgsm/linuxgsm/serverfiles/csgo/cfg/sourcemod/globalrecords.cfg

RUN cd /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/extensions/ \
 && wget https://github.com/Accelerator74/Cleaner/raw/master/Release/cleaner.ext.2.csgo.so \
 && wget https://github.com/Accelerator74/Cleaner/raw/master/Release/cleaner.autoload \
 && wget https://github.com/thraaawn/SMJansson/raw/master/bin/smjansson.ext.so

RUN cd ~/downloads/ \
 && wget https://users.alliedmods.net/~kyles/builds/SteamWorks/SteamWorks-git126-linux.tar.gz \
 && tar -xzvf Steam* \
 && rsync -Pva /home/linuxgsm/downloads/addons/ /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/ \
 && rm -rf ~/downloads/*

RUN cd /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/plugins/ \
 && wget https://bitbucket.org/GoD_Tony/updater/downloads/updater.smx \
 && chmod 600 ./*.smx

RUN cd /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/gamedata/ \
 && wget https://raw.githubusercontent.com/nikooo777/ckSurf/master/csgo/addons/sourcemod/gamedata/cleaner.txt

RUN cd /home/linuxgsm/linuxgsm/serverfiles/csgo/addons/sourcemod/extensions/ \
 && chmod 700 ./*.so \
 && chmod 700 ./*.autoload

RUN touch INSTALLING.LOCK \
 && ./linuxgsm.sh $LGSM_GAMESERVERNAME \
 && mv $LGSM_GAMESERVERNAME lgsm-gameserver \
 && ./lgsm-gameserver auto-install \
 && rm -f INSTALLING.LOCK
RUN wget https://kzmaps.tangoworldwide.net/mapcycles/gokz.txt \
 && mv /home/linuxgsm/linuxgsm/gokz.txt /home/linuxgsm/linuxgsm/serverfiles/csgo/mapcycle.txt
RUN wget https://kzmaps.tangoworldwide.net/bsps/kz_coronado_fix.bsp
 && mv /home/linuxgsm/linuxgsm/kz_coronado_fix.bsp /home/linuxgsm/linuxgsm/serverfiles/csgo/maps/

CMD ["bash"]