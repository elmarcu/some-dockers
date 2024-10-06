# Use a lightweight image, such as alpine or debian
FROM debian:latest

# Install required tools and MySQL client
RUN apt-get update && apt-get install -y \
    cron \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy the script to the container
COPY insert_products.sh /usr/local/bin/insert_products.sh

# Give execution permissions to the script
RUN chmod +x /usr/local/bin/insert_products.sh

# Create a crontab file
RUN echo "*/1 * * * * /usr/local/bin/insert_products.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/my-cron-job

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/my-cron-job

# Apply the cron job
RUN crontab /etc/cron.d/my-cron-job

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the cron command on container startup and tail the logs
CMD cron && tail -f /var/log/cron.log
