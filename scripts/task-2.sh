#!/bin/bash

git clone https://github.com/yasirudinuksha/devops-challenge-apps.git

cd api 

npm install 
npm run build 

#this is under the assumption that applications are hosted with pm2 
pm2 restart backend-app 

cd ../web 

npm install 
npm run build 

#this is under the assumption that applications are hosted with pm2 
pm2 restart frontend-app 