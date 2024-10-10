# Use debian:bullseye-slim as a base image for ARM compatibility
FROM debian:bullseye-slim

# Install required dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    jq \
    groff \
    less && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Set default command
CMD ["/bin/sh"]
