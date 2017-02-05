#!/bin/bash
. venv/bin/activate
git clone https://github.com/letsencrypt/letsencrypt && cd letsencrypt/
service nginx stop
./letsencrypt-auto certonly --debug --standalone -d api.hackinout.co
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo rm /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default
