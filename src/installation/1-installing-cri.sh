#!/usr/bin/env bash
set -e

# This script installs the Container Runtime Interface (CRI) on a Debian-based system.
# Only tested on Ubuntu 22.04 LTS.
# Use this script at your own risk. It is provided as-is without any guarantees.
# It uses containerd and installs the Docker version of it.

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

# Check if the START_DATE is set
if [ -z "$START_DATE" ]; then
    START_DATE=$(date '+%Y-%m-%d_%H-%M-%S')
fi

# Uninstall old versions of Docker and related packages
# This is to ensure that there are no conflicts with the new installation
OLD_PACKAGES=(docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc)

for pkg in "${OLD_PACKAGES[@]}"; do
    if dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
        read -p "Package $pkg is installed. Do you want to remove it? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log "Removing package $pkg"
            sudo apt-get remove -y "$pkg"
        fi
    fi
done

# Update the package list to get the latest versions of all packages
log "Updating the package list"
sudo apt-get update

# Install the required packages for Docker and containerd
# These packages are necessary for the installation and operation of Docker and containerd
REQUIRED_PACKAGES=(ca-certificates curl software-properties-common)
for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
        log "Installing package $pkg"
        sudo apt-get install -y "$pkg"
    fi
done

# Add Docker's official GPG key for secure package download
log "Adding Docker's official GPG key"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to the system's package sources
# This allows us to install Docker and related packages directly from Docker's official repository
log "Adding Docker's repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again to include packages from Docker's repository
log "Updating the package list"
sudo apt-get update

# Install the Docker packages
# These packages include Docker itself, the Docker CLI, containerd, and Docker plugins for buildx and compose
NEW_PACKAGES=(docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin)
for pkg in "${NEW_PACKAGES[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
        log "Installing package $pkg"
        sudo apt-get install -y "$pkg"
    fi
done

# Return success status
exit 0