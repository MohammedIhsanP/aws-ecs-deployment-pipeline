# Use the Node.js image for both build and production
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Set the command to start the application
CMD ["npm", "start"]

# Expose the port the application will run on
EXPOSE 3000
