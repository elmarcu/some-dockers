FROM python:3.8-slim-buster

# Install AWS CLI and other utilities
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    unzip \
    zip

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Set working directory in the container
WORKDIR /scripts

# Copy the code into the container
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

CMD [ "bash" ]
