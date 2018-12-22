#!/bin/bash

# SIGTERM-handler
term_handler() {
    echo "Get SIGTERM"
    #iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
    /etc/init.d/apache2 stop
    kill -TERM "$child" 2> /dev/null
}

/etc/init.d/apache2 start

# setup handlers
trap term_handler INT TERM KILL

sleep infinity &
child=$!
wait "$child"
