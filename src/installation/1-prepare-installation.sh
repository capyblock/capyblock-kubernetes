#!/usr/bin/env bash
set -e

# This script prepare the system for the installation
# Only tested on Ubuntu 22.04 LTS.
# Use this script at your own risk. It is provided as-is without any guarantees.

# Function to log messages with timestamps for better tracking
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Get script name
SCRIPT_NAME=$(basename "$0")

# Get current date and time from the first argument
START_DATE=$1

# Get the log directory from the second argument
LOG_DIR=$2

# Log file
LOG_FILE="$LOG_DIR/$SCRIPT_NAME-$START_DATE.log"

# Update the package list to get the latest versions of all packages
log "Updating the package list"
sudo apt-get update

# Upgrade the installed packages to the latest versions
log "Upgrading installed packages"
sudo apt-get upgrade -y

# Return success status
exit 0