#!/bin/bash

# Exit script if any command fails
set -e

echo "Starting Willow Autocorrect..."

# Map volume for persistent storage
# `/config` is a volume for persistent storage on Home Assistant
# `/app/data` is a volume for persistent storage in the container
echo "Mapping persistent storage..."
rm -rf /app/data || true
ln -s /config /app/data || true

# Make TypeSense data directory
mkdir -p /app/data/ts || true

# Set TypeSense environment variables
echo "Setting TypeSense environment variables..."
export TYPESENSE_HOST=http://typesense:8108 # This should be the same as the IP address of the WAC container, which, since we're running on Home Assistant, is the same as the IP address of Home Assistant
export TYPESENSE_API_KEY="testing"

# Parse configuration options
echo "Parsing configuration options..."
OPTIONS_FILE=/data/options.json
HA_URL="http://localhost:8123"
HA_TOKEN=$(jq --raw-output ".ha_token // empty" $OPTIONS_FILE)


# Write Home Assistant configuration to .env file
if [ "$HA_URL" == "empty" ]; then
  echo "ha_url not set in Configuration tab. Exiting..."
  exit 1
fi
if [ "$HA_TOKEN" == "empty" ]; then
  echo "ha_token not set in Configuration tab. Exiting..."
  exit 1
fi
echo "Writing Home Assistant configuration to .env file..."
echo "HA_TOKEN='$HA_TOKEN'" >> /app/.env
echo "HA_URL='$HA_URL'" >> /app/.env

# Launch the application
echo "Launching Willow Autocorrect..."
cd /app || exit
# Source the .env file
. .env
LOG_LEVEL="info"
RUN_MODE="prod"

set -a # Needed for positional arguments

uvicorn wac:app --host 0.0.0.0 --port 9241 --log-config uvicorn-log-config.json \
        --log-level "$LOG_LEVEL" --loop uvloop --timeout-graceful-shutdown 5 \
        --no-server-header
