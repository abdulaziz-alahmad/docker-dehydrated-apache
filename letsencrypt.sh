#!/bin/bash

# Run apache in the backgrund
httpd-foreground &

# prepair dehydrated
dehydrated --register --accept-terms

#run dehydrated every 20sec
while true; do
dehydrated --cron

sleep 20

done
