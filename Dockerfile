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

# Stage 2: Create the production image with NGINX
FROM node:20-alpine AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the necessary files from the build stage
COPY --from=builder /app ./

# Install NGINX
RUN apk add --no-cache nginx

# Copy the NGINX configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the ports
EXPOSE 80

# Start NGINX and the Node.js application
CMD ["sh", "-c", "nginx -g 'daemon off;' & npm start"]
