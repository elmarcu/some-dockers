FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -y cron

# clean up
RUN apt-get autoremove -y; apt-get autoclean; apt-get clean && rm -rf /var/lib/apt/lists/*
