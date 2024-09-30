# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies, including dev dependencies
COPY package.json tsconfig.json ./
RUN npm install --only=dev && npm install

# Copy the source code
COPY ./src ./src

# Expose the port
EXPOSE 3001

# Start the server
CMD ["npm", "start"]
