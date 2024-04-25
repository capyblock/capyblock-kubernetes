#!/usr/bin/env bash
set -e

# Function to log messages with timestamps for better tracking
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Directory containing the installation scripts
INSTALL_DIR="installation"

# Iterate over each .sh file in the installation directory
for script in "$INSTALL_DIR"/*.sh; do
    # Check if the file is readable
    if [ -r "$script" ]; then
        log "Running $script"
        if bash "$script"; then
            log "$script completed successfully"
        else
            log "Error: $script failed"
            exit 1
        fi
    else
        log "Error: Cannot read $script"
        exit 1
    fi
done

log "Installation completed successfully"

# Return success status
exit 0