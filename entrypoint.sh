#!/bin/bash
sleep 2

cd /home/container

# Run the Server
npm install && npm audit fix
${STARTUP}
