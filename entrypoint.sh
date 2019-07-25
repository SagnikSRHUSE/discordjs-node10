#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${STARTUP}"

# Run the Server
npm install &> /dev/null && npm audit fix &> /dev/null
eval ${MODIFIED_STARTUP}
