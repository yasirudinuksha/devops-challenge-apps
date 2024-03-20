#!/bin/bash

# Update package index
sudo apt update

# Install Node.js and npm
sudo apt install -y nodejs npm

# Install Nginx
sudo apt install -y nginx

sudo cat <<EOF > /etc/nginx/sites-available/api.devopstest.com
server {
    listen 80;
    server_name api.example.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/x.example.com /etc/nginx/sites-enabled/
sudo nginx -t

sudo cat <<EOF > /etc/nginx/sites-available/web.devopstest.com
server {
    listen 80;
    server_name y.example.com;

    location / {
        proxy_pass http://localhost:4000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/y.example.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx


# Install Certbot
sudo apt install -y certbot python3-certbot-nginx

# Obtain SSL certificates
sudo certbot --nginx -d api.devopstest.com -d web.devopstest.com


# Automatically renew certificates
sudo systemctl enable --now certbot.timer