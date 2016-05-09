#!/bin/bash

EMAIL=${EMAIL}
DOMAINS=(${DOMAINS})

if [ -z "$DOMAINS" ]; then
    echo "ERROR: Domain list is empty or unset"
    exit 1
fi

if [ -z "$EMAIL" ]; then
    echo "ERROR: Email is empty string or unset"
    exit 1
fi

domain_args=""
for i in "${DOMAINS[@]}"
do
   domain_args="$domain_args -d $i"
   # do whatever on $i
done

/letsencrypt/lego \
    $domain_args \
    --accept-tos \
    --dns "gcloud" \
    --email $EMAIL \
    -s $LETSENCRYPT_ENDPOINT \
    run
