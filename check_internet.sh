#!/bin/sh /etc/rc.common
# Init script for checking internet and restarting optical service

START=99  

SERVICE="/etc/start_optical/start_optical.sh"
CHECK_URL="8.8.8.8"  



start() {
    while true; do
	echo "Starting internet check service..."
        if ping -c 3 -W 3 $CHECK_URL >/dev/null 2>&1; then
            echo "Internet is available."
        else
            echo "No internet! Waiting 1 minute before restarting optical service..."
            sleep 60  
            sh "$SERVICE"
        fi
        sleep 600 
    done &
}
