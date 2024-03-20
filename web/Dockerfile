FROM node:latest

# Set environment variables
ENV API_HOST=${API_HOST}

# Set the working directory in the container
WORKDIR /app

# Copy package.json files to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port on which your app runs
EXPOSE 3000

# Command to run your application
CMD ["npm", "start"]
