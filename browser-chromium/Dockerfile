FROM ubuntu:focal

RUN apt-get update; apt-get clean

RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install x11vnc xvfb fluxbox wget wmctrl

RUN apt-get -y install gnupg && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A

COPY debian.list /etc/apt/sources.list.d/debian.list
COPY chromium.pref /etc/apt/preferences.d/chromium.pref

RUN apt-get update && apt-get -y install chromium

COPY bootstrap.sh /

CMD '/bootstrap.sh'
