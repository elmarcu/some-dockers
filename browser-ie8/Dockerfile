FROM ubuntu:focal

RUN apt-get update; apt-get clean

RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install x11vnc xvfb fluxbox wget wmctrl
RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get -y install wine32 winetricks cabextract

COPY bootstrap.sh /

CMD '/bootstrap.sh'
