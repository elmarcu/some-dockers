# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy only package.json and package-lock.json to install dependencies first
COPY package*.json ./

# Install dependencies
RUN npm install

# Expose the port
EXPOSE 3000

# Start the React app
CMD ["npm", "start"]
