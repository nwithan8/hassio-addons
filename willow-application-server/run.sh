#!/bin/bash

echo "Starting Willow Application Server..."

# Map volume for persistent storage
# `/config` is a volume for persistent storage on Home Assistant
# `/app/storage` is a volume for persistent storage in the container
echo "Mapping persistent storage..."
rm -rf /app/storage
ln -s /config /app/storage


# Parse configuration options
echo "Parsing configuration options..."
OPTIONS_FILE=/data/options.json
PROVIDED_LOG_LEVEL=$(jq --raw-output ".log_level // empty" $OPTIONS_FILE)

# Write Home Assistant configuration to .env file
if [ "$PROVIDED_LOG_LEVEL" == "empty" ]; then
  PROVIDED_LOG_LEVEL="info"
fi
echo "Writing Home Assistant configuration to .env file..."
echo "export LOG_LEVEL='$PROVIDED_LOG_LEVEL'" > /app/.env
echo "export WAS_LOG_LEVEL='$PROVIDED_LOG_LEVEL'" >> /app/.env

# Source the .env file
. /app/.env

# Launch the application
echo "Launching Willow Application Server..."
sh /app/entrypoint.sh
