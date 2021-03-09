FROM ubuntu:focal

RUN apt-get update; apt-get clean

RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install x11vnc xvfb fluxbox wget wmctrl
RUN apt-get -y install gnupg

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt-get update && apt-get -y install google-chrome-stable

COPY bootstrap.sh /

CMD '/bootstrap.sh'
