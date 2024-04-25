#!/usr/bin/env bash
set -e

# Calculate current terminal how many '-' characters can be displayed
# This is used to display a separator line in the log file
TERMINAL_WIDTH=$(tput cols)

# Function to log messages with timestamps for better tracking
log() {
    printf "%${TERMINAL_WIDTH}s\n" | tr ' ' '-' | tee -a "$LOG_FILE"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MAIN] [INFO] - $1" | tee -a "$LOG_FILE"
    printf "%${TERMINAL_WIDTH}s\n" | tr ' ' '-' | tee -a "$LOG_FILE"
}

# Get current date and time
START_DATE=$(date '+%Y-%m-%d_%H-%M-%S')

# Get directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create a directory to store the logs
LOG_DIR="$DIR/logs"
mkdir -p "$LOG_DIR"

# Log file
LOG_FILE="$LOG_DIR/install-$START_DATE.log"

# Directory containing the installation scripts
INSTALL_DIR="installation"

# Iterate over each .sh file in the installation directory
for script in "$INSTALL_DIR"/*.sh; do
    # Check if the file is readable
    if [ -r "$script" ]; then
        log "Running $script"
        if bash "$script" "$START_DATE" "$LOG_DIR"; then
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