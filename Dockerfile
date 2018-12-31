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

RUN touch INSTALLING.LOCK \
 && ./linuxgsm.sh $LGSM_GAMESERVERNAME \
 && mv $LGSM_GAMESERVERNAME lgsm-gameserver \
 && ./lgsm-gameserver auto-install \
 && rm -f INSTALLING.LOCK
RUN wget https://kzmaps.tangoworldwide.net/mapcycles/gokz.txt \
 && mv /home/linuxgsm/linuxgsm/gokz.txt /home/linuxgsm/linuxgsm/serverfiles/csgo/mapcycle.txt

RUN echo "metamod" | ./lgsm-gameserver mi \
 && sleep 5s

RUN echo "sourcemod" | ./lgsm-gameserver mi \
 && sleep 5s

CMD ["bash"]