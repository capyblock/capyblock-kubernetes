#!/usr/bin/env bash
set -e

# This script installs the kubeadm packages on a Debian-based system.
# Only tested on Ubuntu 22.04 LTS.
# Use this script at your own risk. It is provided as-is without any guarantees.

# Get script name
SCRIPT_NAME=$(basename "$0")

# Function to log messages with timestamps for better tracking
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] [INFO] - $1" | tee -a "$LOG_FILE"
}

# Get current date and time from the first argument
START_DATE=$1

# Get the log directory from the second argument
LOG_DIR=$2

# Log file
LOG_FILE="$LOG_DIR/$SCRIPT_NAME-$START_DATE.log"

# Update the package list to get the latest versions of all packages
log "Updating the package list"
sudo apt-get update

# Install the required packages for kubeadm
# These packages are necessary for the installation and operation of kubeadm
REQUIRED_PACKAGES=(apt-transport-https ca-certificates curl gpg)
for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
        log "Installing package $pkg"
        sudo apt-get install -y "$pkg"
    fi
done

# Add Kubernetes' official GPG key for secure package download
log "Adding Kubernetes official GPG key"
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes repository to the package sources
log "Adding Kubernetes repository to package sources"
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update the package list to get the latest versions of all packages
log "Updating the package list"
sudo apt-get update

# Install the kubeadm packages
log "Installing kubeadm packages"
sudo apt-get install -y kubeadm kubelet kubectl

# Mark the kubeadm packages on hold to prevent automatic updates
log "Marking kubeadm packages on hold"
sudo apt-mark hold kubeadm kubelet kubectl

# Enable and start the kubelet service
log "Enabling and starting the kubelet service"
sudo systemctl enable --now kubelet

# Return success status
exit 0