#!/bin/bash

echo "Starting Willow Application Server..."

# Map volume for persistent storage
# `/config` is a volume for persistent storage on Home Assistant
# `/app/storage` is a volume for persistent storage in the container
echo "Mapping persistent storage..."
rm -rf /app/storage
ln -s /config /app/storage

# Launch the application
echo "Launching Willow Application Server..."
cd /app || exit
sh entrypoint.sh
