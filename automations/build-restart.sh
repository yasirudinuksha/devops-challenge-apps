#!/bin/bash

# Variables for the repository URL and application directories
REPO_URL="https://github.com/yasirudinuksha/devops-challenge-apps.git"
APP_DIR="/var/www/devops-challenge-apps"
WEB_APP_DIR="$APP_DIR/web"
API_APP_DIR="$APP_DIR/api"

# Ensure PM2 is installed globally
sudo npm install -g pm2

# Clone or update the repository
if [ -d "$APP_DIR" ]; then
    echo "Repository directory exists, pulling the latest changes..."
    cd $APP_DIR
    git pull
else
    echo "Cloning repository..."
    git clone $REPO_URL $APP_DIR
fi


# Build the API Application
echo "Building API app..."
cd $API_APP_DIR
npm install

# Restart the API Application using PM2
echo "Restarting API app..."
pm2 restart apiapp || pm2 start npm --name "apiapp" -- run start

# Build the Web Application
echo "Building web app..."
cd $WEB_APP_DIR
npm install
npm run build  # Adjust this if there's no build step for the web app

# Restart the Web Application using PM2
echo "Restarting web app..."
pm2 restart webapp || pm2 start npm --name "webapp" -- run start

# Save PM2 process list to startup
pm2 save
pm2 startup

# Confirm completion
echo "Application deployment and restart complete."
