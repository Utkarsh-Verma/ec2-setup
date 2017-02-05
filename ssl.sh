#!/bin/bash
. venv/bin/activate
git clone https://github.com/letsencrypt/letsencrypt && cd letsencrypt/
service nginx stop
./letsencrypt-auto certonly --debug --standalone -d api.hackinout.co
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo rm /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default

sudo cat <<EOT >> /etc/nginx/sites-available/default
server {
    listen 80;

    server_name api.hackinout.co;

    return 301 https://$server_name$request_uri;

}


server {

   # SSL configuration

   listen 443 ssl;
   include snippets/ssl-api.hackinout.co.conf;
   include snippets/ssl-params.conf;
}
EOT

sudo touch /etc/nginx/snippets/ssl-api.hackinout.co.conf
sudo touch /etc/nginx/snippets/ssl-params.conf

sudo cat <<EOT >> /etc/nginx/snippets/ssl-params.conf
# from https://cipherli.st/
# and https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
#add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;

ssl_dhparam /etc/ssl/certs/dhparam.pem;
EOT

sudo cat <<EOT >> /etc/nginx/snippets/ssl-api.hackinout.co.conf
ssl_certificate /etc/letsencrypt/live/api.hackinout.co/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/api.hackinout.co/privkey.pem;
EOT

service nginx start
