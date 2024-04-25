#!/usr/bin/env bash
set -e

# This script initializes the Kubernetes cluster using kubeadm.
# Only tested on Ubuntu 22.04 LTS.
# Use this script at your own risk. It is provided as-is without any guarantees.

# Function to log messages with timestamps for better tracking
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$(SCRIPT_NAME)] - $1" | tee -a "$LOG_FILE"
}

# Get script name
SCRIPT_NAME=$(basename "$0")

# Get current date and time from the first argument
START_DATE=$1

# Get the log directory from the second argument
LOG_DIR=$2

# Log file
LOG_FILE="$LOG_DIR/$SCRIPT_NAME-$START_DATE.log"

# Initialize the Kubernetes cluster using kubeadm
log "Initializing the Kubernetes cluster"
sudo kubeadm init

# Configure kubectl for the current user
log "Configuring kubectl for the current user"
mkdir -p "$HOME/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"

# Configure kubectl for autocompletion
log "Configuring kubectl autocompletion"
echo 'source <(kubectl completion bash)' >> "$HOME/.bashrc"

# Install a pod network add-on
# Calico is a popular choice for Kubernetes networking
log "Installing Calico pod network add-on"
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Check calico pod status
log "Checking Calico pod status"
kubectl get pods -n kube-system

# Taint the master node to allow workloads to run on it
log "Tainting the master node"
kubectl taint nodes --all node-role.kubernetes.io/master-

# Return success status
exit 0