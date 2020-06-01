FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -y cron

# clean up
RUN apt-get autoremove -y; apt-get autoclean; apt-get clean && rm -rf /var/lib/apt/lists/*

# Add crontab file in the cron directory
COPY ./cron-jobs /etc/cron.d/cron-jobs

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron-jobs

# Apply cron job
RUN crontab /etc/cron.d/cron-jobs

# Create the log file to be able to run tail
RUN touch /var/log/cron.log
