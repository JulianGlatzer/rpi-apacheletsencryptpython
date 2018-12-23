#!/bin/bash

# SIGTERM-handler
term_handler() {
    echo "Get SIGTERM"
    #iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
    /etc/init.d/apache2 stop
    kill -TERM "$child" 2> /dev/null
}

# setup handlers
trap term_handler INT TERM KILL

a2ensite letsencrypt
echo "Hallo" > /var/www/html/test.txt
/etc/init.d/apache2 start

certbot certonly --webroot -n -w /var/www/html -d iot.glatzer.eu --agree-tos -m jg@commail.glatzer.eu 

/etc/init.d/apache2 stop
a2enmod ssl
a2ensite default-ssl
/etc/init.d/apache2 start

sleep infinity &
child=$!
wait "$child"
