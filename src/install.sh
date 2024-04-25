#!/usr/bin/env bash
set -e

# Function to log messages with timestamps for better tracking
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Get current date and time
CURRENT_DATE=$(date '+%Y-%m-%d_%H-%M-%S')

# Create a directory to store the logs
LOG_DIR="logs"
mkdir -p "$LOG_DIR"

# Log file
LOG_FILE="$LOG_DIR/install-$CURRENT_DATE.log"

# Directory containing the installation scripts
INSTALL_DIR="installation"

# Iterate over each .sh file in the installation directory
for script in "$INSTALL_DIR"/*.sh; do
    # Check if the file is readable
    if [ -r "$script" ]; then
        log "Running $script" | tee -a "$LOG_FILE"
        if bash "$script"; then
            log "$script completed successfully" | tee -a "$LOG_FILE"
        else
            log "Error: $script failed" | tee -a "$LOG_FILE"
            exit 1
        fi
    else
        log "Error: Cannot read $script" | tee -a "$LOG_FILE"
        exit 1
    fi
done

log "Installation completed successfully" | tee -a "$LOG_FILE"

# Return success status
exit 0