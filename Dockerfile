# Stage 1: Build the application
FROM node:20 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Stage 2: Create the production image
FROM node:20-slim

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/views/* ./

# Expose the port the application will run on
EXPOSE 3000

# Set the command to start the application
CMD ["npm", "start"]
