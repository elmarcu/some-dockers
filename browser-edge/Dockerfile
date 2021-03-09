FROM ubuntu:focal

RUN apt-get update; apt-get clean

RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install x11vnc xvfb fluxbox wget wmctrl

RUN wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/microsoft-edge-dev_90.0.810.1-1_amd64.deb
RUN dpkg -i microsoft-edge-dev_90.0.810.1-1_amd64.deb || apt-get -fy install

COPY bootstrap.sh /

CMD '/bootstrap.sh'
