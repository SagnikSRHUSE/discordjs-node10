#!/bin/bash
cd /home/container

echo ":/home/container$ ${STARTUP}"

# Run the Server
npm install && npm audit fix
eval ${STARTUP}
