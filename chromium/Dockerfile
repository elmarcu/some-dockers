FROM ubuntu:16.04

RUN apt-get update; apt-get clean

# Add a user for running applications.
RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

RUN apt-get update && apt-get -y install x11vnc xvfb fluxbox wget wmctrl chromium-browser

COPY bootstrap.sh /

CMD '/bootstrap.sh'
