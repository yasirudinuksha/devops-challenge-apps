#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies for adding a new repository over HTTPS
sudo apt install -y curl software-properties-common

# Install the latest Node.js (version 18.x) from the official Ubuntu source
sudo apt install -y nodejs npm

# Verify installation
node -v
npm -v

# Install Nginx
sudo apt install -y nginx

# Create Nginx configuration files for the Web App and the API
WEB_APP_CONF="/etc/nginx/sites-available/web.example.com"
API_CONF="/etc/nginx/sites-available/api.example.com"

# Web App configuration
sudo tee $WEB_APP_CONF > /dev/null <<EOL
server {
    listen 80;
    server_name web.example.com;

    location / {
        proxy_pass http://localhost:3001; # Assuming your web app runs on port 3000
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL

# API configuration
sudo tee $API_CONF > /dev/null <<EOL
server {
    listen 80;
    server_name api.example.com;

    location / {
        proxy_pass http://localhost:3000; # Assuming your API runs on port 4000
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL

# Enable the configurations by creating symlinks to the sites-enabled directory
sudo ln -s $WEB_APP_CONF /etc/nginx/sites-enabled/
sudo ln -s $API_CONF /etc/nginx/sites-enabled/

# Test the Nginx configuration
sudo nginx -t

# Restart Nginx to apply changes
sudo systemctl restart nginx

# Install Certbot and provision SSL certificates (automated)
sudo apt install -y certbot python3-certbot-nginx

# Obtain SSL certificates for both applications non-interactively
sudo certbot --nginx --non-interactive --agree-tos --email sample@gmail.com --no-eff-email -d web.example.com -d api.example.com


# Confirm the setup
echo "Environment setup complete. Nginx and Certbot have been configured."
