#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${STARTUP}"

# Run the Server
npm install > "/dev/null" 2>&1 && npm audit fix > "/dev/null" 2>&1
eval ${MODIFIED_STARTUP}
