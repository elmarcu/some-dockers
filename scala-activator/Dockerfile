FROM openjdk:8-jdk
ENV ACTIVATOR_VERSION 1.3.7

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y unzip \
  && rm -rf /var/lib/apt/lists/*

# Download and install Activator
RUN wget --output-document /opt/typesafe-activator-$ACTIVATOR_VERSION.zip http://downloads.typesafe.com/typesafe-activator/$ACTIVATOR_VERSION/typesafe-activator-$ACTIVATOR_VERSION-minimal.zip
RUN unzip /opt/typesafe-activator-$ACTIVATOR_VERSION.zip -d /opt
RUN rm -f /opt/typesafe-activator-$ACTIVATOR_VERSION.zip
RUN mv /opt/activator-$ACTIVATOR_VERSION-minimal /opt/activator

ENV PATH="/opt/activator:${PATH}"

RUN mkdir /root/app
WORKDIR /root/app

ENTRYPOINT "activator"

EXPOSE 9000
